require 'test_helper'

describe 'TodoIntegrationTest' do
  before do
    login
    @current_user = User.find_by(name: 'Example User')
  end

  describe 'todoの新規作成を行ったとき' do
    before do
      Todo.delete_all
      visit todos_path
      fill_in('todo[detail]', with: '画面から作成するTodo')
      select('趣味', from: 'todo[tag_id]')
      click_button '作成!'
    end

    it '作成したtodoが表示されること', js: true do
      page.text.must_include '画面から作成するTodo'
    end

    it 'DBにデータが作成されていること' do
      Todo.active.where(user_id: @current_user.id, detail: '画面から作成するTodo').count.must_equal 1
    end
  end

  describe 'todoの削除行ったとき' do
    before do
      visit todos_path
      page.execute_script %($('.icon-trash').click())
    end

    it 'DBからデータが削除されていること', js: true do
      Todo.active.where(user_id: @current_user.id, detail: 'integration todo').count.must_equal 0
    end
  end
end
