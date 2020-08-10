class Admin::PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: "DESC").page(params[:page]).per(5)
    @all_posts = Post.all
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
