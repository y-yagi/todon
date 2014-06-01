$(function() {
  var Todo;
  Todo = (function() {
    function Todo(detail, tag, priority, id) {
      this.detail = detail;
      this.tag = gon.tags[tag];
      this.id = id;
      this.priority = priority;
      this.delete_url = "/todos/" + id;
    }
    return Todo;
  })();

  var todos = new Array();
  for(l = gon.todos.length, i = 0; i < l; i++) {
    var todo = new Todo(gon.todos[i].detail, gon.todos[i].tag_id, gon.todos[i].priority, gon.todos[i].id);
    todos.push(todo);
  }

  Vue.filter('filterByTag', function (todos, tag) {
    if (!tag) {
      return todos;
    }

    var result = []
    for(var i = 0, l = todos.length; i < l; i++) {
      if (todos[i].tag == tag) {
        result.push(todos[i]);
      }
    }
    return result;
  })

  var app = new Vue({
    el: '#todoapp',
    data: { todos: todos, newDetail: '', newTag: ''},
    methods: {
      addTodo: function() {
        var value = this.newDetail && this.newDetail.trim();
        if (!value) {
          return;
        }
        var todo = new Todo(this.newDetail, this.newTag, '',  '');
        this.newDetail = '';
        return this.todos.push(todo);
      },
      removeTodo: function(todo) {
        return this.todos.$remove(todo.$parent.$data);
      }
    }
  })
});
