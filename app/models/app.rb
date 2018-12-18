class App < ApplicationRecord
  belongs_to :user

  has_secure_token :client_id
  has_secure_token :client_secret

  scope :active, -> {where(expired_at: nil)}
end
