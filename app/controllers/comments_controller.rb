class CommentsController < ApplicationController
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @commentable, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { redirect_to @commentable }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @commentable = @comment.commentable
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @commentable, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
  end

  def comment_params
    params.require(:comment).permit()
  end
end
