class CreatePosts < ActiveRecord::Migration
  
  def self.up
    
    create_table :posts do |t|
      t.string    :title, :null => false, :limit => 120
      t.text      :content, :null => false
      t.integer   :user_id, :null => false
      t.timestamp :created_at, :null => false
      t.timestamp :updated_at, :null => false
    end
    
    # TODO: Needs a foreign key to the USERS table.
  end
  

  def self.down
    drop_table :posts
  end
end