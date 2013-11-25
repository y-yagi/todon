class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  def index
    if params[:finished]
      @todos = Todo.finished.user(current_user).order(:priority)
    else
      @todos = Todo.active.user(current_user).order(:priority)
    end
    @tags = Tag.active.user(current_user)
    gon.tags, gon.todos = {}, @todos
    @tags.each{|t| gon.tags[t.id] = t.name}
    @todo = Todo.new
  end

  def show
  end

  def new
    @todo = Todo.new
    @tags = Tag.active.user(current_user)
  end

  def edit
  end

  def sort
    redirect_to todos_url unless params[:ids].present?
    Todo.sort(current_user, params[:ids])
    render nothing: true
  end

  def create
    @todo = Todo.build(current_user, todo_params)
    respond_to do |format|
      if @todo.save
        format.html { redirect_to todos_url, notice: "新しいタスクを登録しました" }
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @todo.update_attributes(deleted: true)
    render nothing: true
  end

  private
    def set_todo
      @todo = Todo.find(params[:id])
    end

    def todo_params
      params.require(:todo).permit(:user_id, :detail, :tag_id, :priority, :end_date, :deleted)
    end
end
