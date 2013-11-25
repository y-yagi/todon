$(function() {
  function Todo(data) {
    this.detail = ko.observable(data.detail);
    this.priority = ko.observable(data.priority);
    this.tag = ko.observable(gon.tags[data.tag]);
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
      var todo = new Todo({ detail: self.newTodoDetail(), tag: self.newTodoTag()});
      if (todo.detail() == undefined) return;
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
    var todo = new Todo({ detail: gon.todos[i].detail, tag: gon.todos[i].tag_id, id: gon.todos[i].id})
    self.todos['all'].push(todo);
    if(todo.tag() && todo.tag().length > 0) {
      self.todos[todo.tag()].push(todo);
    }
  }
});

function sendSorData(ui, e) {
  var todoList = ui.sourceParent();
  var ids = new Array();
  for (i = 0, l = todoList.length; i < l; i++) {
    ids.push(todoList[i].id());
  }
  $.post("/todos/sort", { ids: ids } );
};
