module ApplicationHelper

  def admin?
    !session[:admin].nil?
  end

end
