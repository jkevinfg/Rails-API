class PostsController < ApplicationController
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
end