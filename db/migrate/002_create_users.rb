require 'active_record/fixtures'

class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :first_name, :null => false, :limit => 50
      t.string    :last_name, :null => false, :limit => 50
      t.string    :login_name, :null => false, :limit => 50
      t.string    :hashed_password, :null => true, :limit => 40
      t.string    :email, :null => false, :limit => 100
      t.string    :salt, :null => true, :limit => 40
      t.integer   :login_count, :null => false, :default => 0
      t.boolean   :is_active, :null => false, :default => true
      t.boolean   :post_with_full_name, :null => false, :default => true
      t.timestamp :created_at, :null => false
      t.timestamp :updated_at, :null => false
    end
    
    Fixtures.create_fixtures('test/fixtures', File.basename("users.yml", '.*'))  
  end

  def self.down
    drop_table :users
  end
end
