class UserSerializer < ActiveModel::Serializer
  attributes(
      :id,
      :email,
      :name
  )
  attribute :access_token, if: :access_token?

  def access_token?
    !instance_options[:access_token].nil?
  end

  def access_token
    instance_options[:access_token]
  end
end
