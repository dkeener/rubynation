class AdminController < ApplicationController
  # You must be logged in to access admin features
  before_filter :authorize
  
  def index
    @title = 'Admin Home'
  end
end