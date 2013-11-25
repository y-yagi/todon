module ApplicationHelper
  def display_priorty(priority)
    priority_class = nil
    case priority
    when 1
      priority_class = 'danger'
      priority_str = '高'
    when 2
      priority_class = 'warning'
      priority_str = '中'
    when 3
      priority_class = 'info'
      priority_str = '低'
    end
    %Q|<button type="button" class="btn btn-xs btn-#{priority_class}">#{priority_str}</button>|.html_safe if priority_class
  end

  def get_root_url
    if current_user
      todos_url
    else
      root_url
    end
  end

  def todo_line_color(todo)
    if todo.priority == Todo::PRIORITY_HIGH
      'class="danger"'.html_safe
    elsif todo.priority == Todo::PRIORITY_MIDDLE
      'class="warning"'.html_safe
    end
  end

  def date_format(date)
    date.strftime("%1m月%d日")
  end
end
