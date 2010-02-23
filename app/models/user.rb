require 'digest/sha1'

class User < ActiveRecord::Base
  validates_presence_of     :login_name
  validates_uniqueness_of   :login_name
  
  attr_accessor             :password_confirmation
  validates_confirmation_of :password
  
  has_many :posts

  # Returns the unencrypted password for a user, but only if it has previously
  # been set for this instance. Only the encrypted password is stored in the
  # database.

  def password
    @password
  end

  # Defines a password for a user. As side effect, the method will encrypt
  # the password, which will result in the salt and hashed_password
  # values also being set for the User instance.

  def password=(pwd)
    @password = pwd
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  
  # Returns the full name of a user as "Last-Name, First-Name."
  
  def full_name
    last_name + ', ' + first_name
  end
  
  # Returns the full name of a user in regular form.
  
  def name
    first_name + ' ' + last_name
  end
  
  # Autenticates a user's login and password using the native login
  # mechanism (as opposed to a third-party login mechanism like OpenID).
  # If successful, a valid User object will be returned, otherwise nil 
  # will be returned.
   
  def self.authenticate(login_name, password)
    user = self.find_by_login_name(login_name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end
  
  # Increment a user's login count by one. Returns the updated User
  # object.
   
  def self.increment_login_count(id)
    user = self.find_by_id(id)
    if user
      user.login_count += 1
      user.save
    end
    user
  end
   
  private

  # Creates a salt value that is used in the password encryption process. A salt is
  # only needed for logins that use the native login system rather than an
  # authentication system like OpenID.

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  # Encrypts the password using the specified salt value.

  def self.encrypted_password(password, salt)
    string_to_hash = password + "weeble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

end
