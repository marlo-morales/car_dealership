class PostsController < ApplicationController
  before_action :fetch_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.ordered
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(permitted_params)
    @post.author = current_user

    if @post.save
      redirect_to @post, notice: t(".success")
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(permitted_params)
      redirect_to @post, notice: t(".success")
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to root_path, notice: t(".success")
    else
      redirect_to root_path, alert: t(".error")
    end
  end

  private

  def fetch_post
    @post = Post.find(params[:id])
  end

  def permitted_params
    params.require(:post).permit(
      :title,
      :body,
    )
  end
end
