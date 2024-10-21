module Api
  module V1
    class PostsController < ApplicationController
      before_action :authenticate_user!
      before_action :authorize_post!, only: %i[update destroy]
      before_action :set_post, only: [:show, :edit, :update, :destroy]
      # skip_before_action :authenticate_user!, only: [:index] # Skip authentication to test rate-limiting

      def index
        @posts = Post.includes(:user).all
        render json: @posts
      end

      def show
        render json: @post
      end

      def create
        @post = current_user.posts.build(post_params)
        authorize @post
        if @post.save
          redirect_to @post, notice: 'Post created successfully.'
        else
          render :new
        end
      end

      def update
        authorize @post
        if @post.update(post_params)
          redirect_to @post, notice: 'Post updated successfully.'
        else
          render :edit
        end
      end

      def destroy
        authorize @post
        @post.destroy
        redirect_to posts_path, notice: 'Post deleted successfully.'
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def authorize_post!
        @post = Post.find(params[:id])
        render json: { error: 'You are not authorized' }, status: :forbidden unless @post.user == current_user
      end

      def post_params
        params.require(:post).permit(:title, :body)
      end
    end
  end
end
