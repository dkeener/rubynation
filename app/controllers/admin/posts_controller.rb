class Admin::PostsController < ApplicationController
  layout 'admin'
  
  # You must be logged in to access admin features
  before_filter :authorize
  
  def initialize
    super
    @title = 'Posts'
  end
    
  active_scaffold :post do |config|
    config.label = '&nbsp;'
    config.columns = [:id, :title, :content, :created_at, :updated_at, :user_name]
    config.columns[:created_at].label = 'Create Date'
    config.columns[:updated_at].label = 'Update Date'
    config.columns[:id].label = 'ID'   
    config.columns[:content].form_ui = :textarea
    config.columns[:content].options = { :cols => 60, :rows => 20, }
    config.columns[:content].sort = false
    config.actions.exclude :search
    
    config.list.columns.exclude :id, :content
    config.list.sorting = {:created_at => 'ASC'}
    
    config.create.columns.exclude :id, :created_at, :updated_at, :user_name
    config.update.columns.exclude :id, :created_at, :updated_at, :user_name
  end
  
  protected
  
  # Makes any behind-the-scenes changes required for a new object before it is created.
  
  def before_create_save(record)
    # The new post should be "owned" by the current user
    record.user_id = session[:user_id]
  end

end
