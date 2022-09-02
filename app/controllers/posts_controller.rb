class PostsController < ApplicationController

    rescue_from Exception do |e|
        render json: { error: e.message }, status: :internal_error #500 failed server
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
        render json: { error: e.message }, status: :unprocessable_entity
    end

    #list GET /posts
    def index
        @posts = Post.where(published: true)
        render json: @posts, status: :ok 
    end

    # /GET /posts/{id}
    def show
        @post = Post.find_by(id: params[:id])
        if @post.nil?
            return render json: { message: "Post not exist" }, status: :not_found 
        end
        render json: @post, status: :ok
    end

    # POST /posts
    def create
        @post = Post.create!(create_params) # ! => lanza excepcion sobre las validaciones
        render json: @post, status: :created
    end

    # PUT /posts/{id}
    def update
        @post = Post.find_by(id: params[:id])
        @post.update!(update_params)
        render json: @post, status: :ok
    end

    private

    def create_params
        params.require(:post).permit(:title, :content, :published, :user_id)
    end

    def update_params
        params.require(:post).permit(:title, :content, :published)
    end
end