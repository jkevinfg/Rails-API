class PostsController < ApplicationController
    include Secured
    before_action :authenticate_user!, only: [:create, :update, :unpublished_posts]

    rescue_from Exception do |e|
        render json: { error: e.message }, status: :internal_server_error
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
        render json: { error: e.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
        render json: { error: e.message }, status: :unprocessable_entity
    end

    #GET /posts
    def index
        posts = Post.where(published: true) # all posts published
        if !params[:search].nil? && params[:search].present?
            posts = PostsSearchService.search(posts, params[:search])
        end
        render json: posts, status: :ok
    end

    #GET /posts/{id}
    def show #show post published
        post = Post.find(params[:id])
        if post.published?
            return render json: post, status: :ok
        end
        render json: { error: 'Post is not published' }, status: :unprocessable_entity
    end

    #GET /posts/unpublished
    def unpublished_posts
        posts = Current.user.posts.where(published: false)
        render json: posts, status: :ok
    end

    #POST /posts
    def create
        post = Current.user.posts.create!(create_params)
        render json: post, status: :created
    end

    #PUT /posts/{id}
    def update
        post = Current.user.posts.find(params[:id])
        post.update!(update_params)
        render json: post, status: :ok
    end

    private

    def create_params
        params.require(:post).permit(:title, :content, :published)
    end

    def update_params
        params.require(:post).permit(:title, :content, :published)
    end
end