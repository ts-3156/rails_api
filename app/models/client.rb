class Client < ApplicationRecord
  belongs_to :app
  belongs_to :user

  has_secure_token :access_token

  scope :active, -> {where(expired_at: nil)}
end
