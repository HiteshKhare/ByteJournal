module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_comment, only: [:update, :destroy]

      def create
        @comment = current_user.comments.new(body: sanitize(params[:comment][:body]))
        authorize @comment
        if @comment.save
          redirect_to @comment.post, notice: 'Comment added successfully.'
        else
          redirect_to @comment.post, alert: 'Unable to add comment.'
        end
      end

      def update
        authorize @comment
        if @comment.update(body: sanitize(params[:comment][:body]))
          redirect_to @comment.post, notice: 'Comment updated successfully.'
        else
          render :edit
        end
      end

      def destroy
        authorize @comment
        @comment.destroy
        redirect_to @comment.post, notice: 'Comment deleted successfully.'
      end

      private

      def set_comment
        @comment = Comment.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:content, :post_id)
      end
    end
  end
end
