class Post < ActiveRecord::Base
  belongs_to :user
  
  def user_name
    u = User.find_by_id(user_id)
    u.nil? || u.name
  end
end