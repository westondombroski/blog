class PostsController < ApplicationController
    before_action :find_post, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :edit, :destroy]
    before_action :is_owner, only: [:edit, :destroy]
    def index
        @posts = Post.where(["title LIKE ?", "%#{params[:search]}%"]).order("created_at DESC").paginate(:page => params[:page], :per_page => 3)
    end

    def show
    end

    def new
        @post = Post.new
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            redirect_to @post, notice: "Post successfully created!"
        else
            render "new"
        end
    end

    def edit
    end

    def update
        if @post.update(post_params)
            redirect_to @post, notice: "Post successfully updated!"
        else
            render "edit"
        end
    end

    def destroy
        @post.destroy
        flash[:notice] = "Post successfully deleted!"
        redirect_to root_path
    end

    private

    def post_params
        params.require(:post).permit(:title, :body, :user, :avatar)
    end

    def find_post
        @post = Post.friendly.find(params[:id])
    end

    def is_owner
        unless current_user == @post.user
            flash[:alert] = "Sorry, that post belongs to someone else!"
            redirect_to @post
        end
    end
end
