# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  name       :string(255)
#  email      :string(255)
#  deleted    :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base

  validates :provider,
    length: { maximum: 255 }
  validates :name,
    length: { maximum: 255 }
  validates :email,
    length: { maximum: 255 }

  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    user = create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
    end
    Tag.create_default_tags(user)
    user
  end
end
