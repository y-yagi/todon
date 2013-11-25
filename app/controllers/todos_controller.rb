class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  def index
    @todos = Todo.active.user(current_user).order(:priority)
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
        format.json { render action: 'show', status: :created, location: @todo }
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @tags = Tag.active.current_user(current_user)
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to todos_url, notice: "新しいタスクを登録しました" }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
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
