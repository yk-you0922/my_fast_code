class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def new
    @new_post = Post.new
  end

  def index
    @posts = Post.all.order(created_at: "DESC")
  end

  def create
    @new_post = Post.new(post_params)
    @new_post.user_id = current_user.id
    if @new_post.save
      redirect_to post_path(@new_post.id)
    else
      @posts = Post.all
      render :new
    end 
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @new_comment = Comment.new
    @comments = @post.comments
  end

  def edit
    @post = Post.find(params[:id])

  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path
    else
      @post = Post.find(params[:id])
      render :show
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def ranking
  end

  def category
    @genre = Genre.find(params[:genre_id])
    @genre_posts = @genre.posts
  end

  private
  
  def post_params
    params.require(:post).permit(:title, :body, :image, :closed_on, genre_ids: [])
  end
end
