class PostsController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :create]
  before_action :correct_user, only: :destroy
  
  def create
    @new_post = current_user.posts.new(post_params)
    if !@new_post.save
      flash[:danger] = @new_post.errors.full_messages.first
    end
    redirect_to root_path
  end
  
  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "Your post has been deleted."
    redirect_to root_path
  end
  
  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
    
    def logged_in_user
      unless logged_in?
        flash[:danger] = "You are not logged in."
        redirect_to login_path
      end
    end
    
    def correct_user
      user = Post.find(params[:id]).user
      unless current_user? user
        flash[:danger] = "That post does not belong to you."
        redirect_to root_path
      end
    end
end
