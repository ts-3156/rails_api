class Client < ApplicationRecord
  belongs_to :user

  has_secure_token :access_token
  has_secure_token :access_secret

  scope :active, -> {where(expired_at: nil)}
end
