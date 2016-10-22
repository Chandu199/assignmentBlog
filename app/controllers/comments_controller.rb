class CommentsController < ApplicationController
    before_action :find_post
    before_action :authenticate_user!, except: [:index]
    def create
        @comment = @post.comments.new(comment_params)
        if @comment.save
            flash[:success] ="Comment was created"
            redirect_to post_path(@post)
        else
            flash[:error]="comment was not created"    
            redirect_to post_path(@post)
        end
        
    end
    
    
    def update
        @comment = @post.comments.find(params[:id])
        @comment.update_attributes(comment_params)
    end
    
    def destroy
        unless @user.admin?
            @comment.destroy
        end
    end
    private
    def comment_params
        params.require(:comment).permit(:comment)
    end
    def find_post
        @post = Post.find(params[:post_id])
    end
    
    def find_user
        @user = current_user.id
    end
    
end
