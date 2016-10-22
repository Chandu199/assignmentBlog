class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index,:show]
    before_action :find_user,except: [:index,:show]
    before_action :find_post,except: [:index,:new,:create,:featured,:popular]
    def index
        @posts = Post.all
        if params[:search]
            @posts = Post.search(params[:search]).order("created_at DESC")
        else
            @posts = Post.all.order('created_at DESC')
        end
    end
    def new
        @post = Post.new
    end
    
    def create
        @post =  Post.new(post_params)
        @post.user =  current_user
        if @post.save
            redirect_to @post
        else
            render 'new'
        end
    end
    
    def edit
        
    end
    
    def update
        if @post.update_attributes(post_params)
            redirect_to @post
        else
            render 'edit'
        end
    end
    def show
        if user_signed_in?
            redirect_to post_path(@post)
        else
            flash[:error]="PLease sign in to check the deatils"
            redirect_to user_session_path
        end
    end
    
    def destroy
        @post.destroy
        redirect_to posts_path
    end
    
    def like
         like = Like.create(like:params[:like],user: current_user, post: @post)
         if like.valid?
             flash[:success]="Success"
             redirect_to :back
         else
             flash[:danges]="Like not added"
             redirect_to :back
         end
    end
    def featured
        @posts= Post.all
        @posts = Post.where(featured: true)
        render 'featured'
    end
    def popular
        @posts = Post.all.sort_by{|post|post.likes.count}.reverse
        render 'popular'
    end
    
    private
    
    def  post_params
        params.require(:post).permit(:title,:description,:featured)
    end
    
    def find_user
        @user = current_user.id
    end
    
    def find_post
        @post=  Post.find(params[:id])
    end
    
end