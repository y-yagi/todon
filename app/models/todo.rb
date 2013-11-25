# == Schema Information
#
# Table name: todos
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  detail     :string(255)
#  tag_id     :string(255)
#  priority   :integer
#  end_date   :date
#  deleted    :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class Todo < ActiveRecord::Base

  belongs_to :tag
  scope :active, -> { where(deleted: false) }
  scope :user, ->(user) { where('user_id = ?', user.id) }
  scope :limit_by_tag, ->(tag) { where('tag_id = ?', tag) }

  def self.build(user, params)
    todo = Todo.new(params)
    todo.user_id = user.id
    todo.priority = Todo.active.user(user).maximum(:priority).to_i + 1
    todo
  end

  def self.sort(user, ids)
    priorities = Todo.active.user(user).where(id: ids).pluck(:priority)
    return false if priorities.count != ids.count

    begin
      Todo.transaction do
        ids.each_with_index do |id, i|
          Todo.update(id, priority: priorities[i])
        end
      end
    rescue => e
      logger.error(e.backtrace)
      return false
    end
    true
  end
end
