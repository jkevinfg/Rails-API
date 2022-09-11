class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :update]

    rescue_from Exception do |e|
        render json: { error: e.message }, status: :internal_error
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
        render json: { error: e.message }, status: :unprocessable_entity
    end

    #list GET /posts
    def index
        @posts = Post.where(published: true)
        if !params[:search].nil? && params[:search].present?
            @posts = PostsSearchService.search(@posts, params[:search])
        end
        render json: @posts.includes(:user), status: :ok  #includes: solution problem n+1 querys. 
    end

    # /GET /posts/{id}
    def show
        @post = Post.find_by(id: params[:id])
        if @post.nil?
            return render json: { message: "Post not exist" }, status: :not_found 
        end
        if (@post.published? || (Current.user && @post.user_id == Current.user.id))
            return render json: @post, status: :ok
        end
        render json: { error: 'Not Found' }, status: :not_found
    end

    # POST /posts
    def create
        @post = Current.user.posts.create!(create_params) # ! => lanza excepcion sobre las validaciones
        render json: @post, status: :created
    end

    # PUT /posts/{id}
    def update
        @post = Current.user.posts.find_by(id: params[:id])
        @post.update!(update_params)
        render json: @post, status: :ok
    end

    private

    def create_params
        params.require(:post).permit(:title, :content, :published)
    end

    def update_params
        params.require(:post).permit(:title, :content, :published)
    end

    def authenticate_user!
        token_regex = /Bearer (\w+)/
        headers = request.headers
        if headers['Authorization'].present? && headers['Authorization'].match(token_regex)
            token = headers['Authorization'].match(token_regex)[1]
            if (Current.user = User.find_by_auth_token(token))
                return 
            end
        end

        render json: {error: 'Unauthorized'}, status: :unauthorized
    end
end