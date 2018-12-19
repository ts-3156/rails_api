class User < ApplicationRecord
  has_secure_password

  # Virtual attribute for authenticating by either phone or something else
  # This is in addition to a real persisted field like 'email'
  attr_accessor :login

  has_many :apps
  has_many :clients

  validates :name, uniqueness: true

  validates_specific :name

  class << self
    def create_with_access_token!(email, name, password, verification_code, options = {})
      user = User.new(email: email, name: name, password: password)

      client = nil

      transaction do
        # TODO Use verification_code!
        user.save!
        client = user.clients.create!
      end

      [user, client]
    end

    def find_for_database_authentication(conditions)
      if conditions.has_key?(:login) && !conditions[:login].blank?
        where('email = :value OR name = :value', {value: login}).first
      elsif conditions.has_key?(:email) && !conditions[:email].blank?
        find_by(email: conditions[:email])
      elsif conditions.has_key?(:name) && !conditions[:name].blank?
        find_by(name: conditions[:name])
      else
        nil
      end
    end
  end
end
