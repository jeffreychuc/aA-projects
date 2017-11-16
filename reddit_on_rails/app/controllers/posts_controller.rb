class PostsController < ApplicationController
  def new
  end

  def create
    @post = Post.new(post_params)
    fail
  end

  def edit
  end

  def update
  end

  def index
  end

  def destroy
  end

  def show
  end

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
end
