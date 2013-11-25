# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)
#  deleted    :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
  has_many :todo

  scope :active, -> { where(deleted: false) }
  scope :user, ->(user) { where('user_id = ?', user.id) }

  def self.create_default_tags(user)
    Tag.create!(name: '仕事', user_id: user.id)
    Tag.create!(name: '趣味', user_id: user.id)
  end

  def self.build(params, user)
    tag = Tag.new(params)
    tag.user_id = user.id
    tag
  end

  def delete
    update_attributes(deleted: true)
    todo.update_all(tag_id: nil)
  end
end
