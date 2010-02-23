class Admin::UsersController < ApplicationController
    layout 'admin'
  
  # You must be logged in to access admin features
  before_filter :authorize
  
  # Initialize data elements needed by the layout
  before_filter :init
  
  def init
    @title = 'Users'
  end
     
  active_scaffold :user do |config|
    config.label = '&nbsp;'
    config.columns = [:id, :full_name, :first_name, :last_name, :login_name, :created_at, :login_count, :password, :email]
    config.columns[:created_at].label = 'Create Date'   
    config.actions.exclude :search
    
    config.list.sorting = {:last_name => 'ASC'}
    
    config.list.columns.exclude :openid, :desc, :password, :first_name, :last_name, :id, :created_at, :email
    config.create.columns.exclude :id, :created_at, :full_name, :login_count
    config.update.columns.exclude :id, :created_at, :full_name, :login_count
  end
  
  protected
  
  # Defines ActiveScaffold criteria for a row to be included in the list, e.g. - the
  # row must not have been designated as Inactive.
  
  def conditions_for_collection
    [ 'is_active = ?', 1]
  end

  # Overrides the standard delete functionality for ActiveScaffold so that records
  # are removed by being marked as "Inactive" rather than being physically deleted.

  def do_destroy
    @record = find_if_allowed(params[:id], :destroy)
    @record.active_ind = false
    self.successful = @record.save
  end
end
