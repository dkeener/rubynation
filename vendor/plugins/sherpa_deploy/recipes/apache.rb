namespace :apache do

  task :start, :role => :app do 
    sudo "/sbin/service httpd start"
  end 

  task :stop, :role => :app do 
    sudo "/sbin/service httpd stop"
  end 

  task :restart, :role => :app do
    sudo '/sbin/service httpd restart'
  end

  
  after "deploy:cold", "apache:start"
end 