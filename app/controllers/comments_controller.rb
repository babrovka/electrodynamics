# coding: utf-8

class CommentsController < InheritedResources::Base

  def create 
    @comment = Comment.new(params[:comment])
    if @comment.save
      redirect_to :back, :notice => 'Спасибо за комментарий'
    else
      redirect_to :back
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to :back, :notice => 'Ваш комментарий удален'
  end
  
end
