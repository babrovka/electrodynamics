# coding: utf-8

module ApplicationHelper
  
  def controller?(*controller)
     controller.include?(params[:controller])
   end

   def action?(*action)
     action.include?(params[:action])
   end
  
  def date_with_month(date)
    I18n.localize(date, :format => :with_month)
  end
  
  def link_to_delete_comment(user, comment)
    link_to 'удалить', comment_path(comment), :method => :delete, :confirm => 'Вы уверены?' if comment.author_id == user.id
  end
  
  def users
    User.where('firstname != ?', 'admin')
  end
  
  def categories_list
    Category.all
  end
  
  def side_articles
    Article.limit(5)
  end
    
end
