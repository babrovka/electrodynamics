module ApplicationHelper
  
  def date_with_month(date)
    I18n.localize(date, :format => :with_month)
  end
end
