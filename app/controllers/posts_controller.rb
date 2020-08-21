class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :category]

  def new
    @new_post = Post.new
  end

  def index
    @all_posts = Post.all
    comment_count = Comment.where(id: :post_id).count
    favorite_count = Favorite.where(id: :post_id).count
    @posts = Post.order(created_at: "DESC").page(params[:page]).per(1)
    unless request.post?
      # @posts = Post.order(params[:keyword]).page(params[:page]).per(1)
      selection = params[:keyword]
      @posts = Post.sort(selection).page(params[:page]).per(1)
    end
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
    unless @post.user == current_user
      redirect_to redirect_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
      @post = Post.find(params[:id])
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def category
    @genre = Genre.find(params[:genre_id])
    @genre_posts = @genre.posts.order(created_at: "DESC").page(params[:page]).per(1)
  end

  private
  
  def post_params
    params.require(:post).permit(:title, :body, :image, :closed_on, genre_ids: [])
  end
end
