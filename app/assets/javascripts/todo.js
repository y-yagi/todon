$(function() {
  function Todo(data) {
    this.detail = ko.observable(data.detail);
    this.priority = ko.observable(data.priority);
    this.tag = ko.observable(gon.tags[data.tag]);
    this.end_date = ko.observable(data.end_date);
    this.id = ko.observable(data.id);
    this.delete_url = "/todos/" + this.id();
  }

  var TodoListViewModel = function() {
    self.todos = {};
    self.todos['all'] = ko.observableArray();
    for(tag in gon.tags) {
      self.todos[gon.tags[tag]] = ko.observableArray();
    }
    self.newTodoDetail = ko.observable();
    self.newTodoTag = ko.observable();
    self.addTodo = function() {
      var end_date = formatDate($('#todo_end_date_2i option:selected').val(), $('#todo_end_date_3i option:selected').val());
      var todo = new Todo({ detail: self.newTodoDetail(), tag: self.newTodoTag(), end_date: end_date});
      self.todos['all'].push(todo);
      if(todo.tag() && todo.tag().length > 0) {
        self.todos[todo.tag()].push(todo);
      }
    };

    self.removeTodo = function(todo) {
      self.todos['all'].remove(todo)
    };
  }.bind(this);

  ko.applyBindings(new TodoListViewModel());

  for(l = gon.todos.length, i = 0; i < l; i++) {
    if (gon.todos[i].end_date) {
      var d = new Date(gon.todos[i].end_date);
      var end_date = formatDate(d.getMonth() + 1,  d.getDate());
    } else {
      var end_date = "";
    }
    var todo = new Todo({ detail: gon.todos[i].detail, tag: gon.todos[i].tag_id, end_date: end_date, id: gon.todos[i].id})
    self.todos['all'].push(todo);
    if(todo.tag() && todo.tag().length > 0) {
      self.todos[todo.tag()].push(todo);
    }
  }
});

function formatDate(month, date) {
  if (month == "" || date == "") {
    return "";
  }
  d = new Date();
  d.setMonth(month - 1);
  d.setDate(date);
  return (d.getMonth() + 1) + "月" + d.getDate() +"日";
};

function sendSorData(ui, e) {
  var todoList = ui.sourceParent();
  var ids = new Array();
  for (i = 0, l = todoList.length; i < l; i++) {
    ids.push(todoList[i].id());
  }
  $.post("/todos/sort", { ids: ids } );
};
