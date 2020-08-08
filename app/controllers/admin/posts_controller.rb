class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: "DESC")
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end
end
