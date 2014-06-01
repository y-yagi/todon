require 'test_helper'

describe "todo管理テストIntegration" do
  before do
    login
    @current_user = User.first
  end

  describe 'todoの新規作成を行ったとき' do
    before do
      visit todos_path
      fill_in('todo[detail]', with: 'テストtodo')
      select('趣味', from: 'todo[tag_id]')
      click_button '作成!'
    end

    it '作成したtodoが表示されること', js: true do
      sleep 0.1
      page.text.must_include 'テストtodo'
    end

    it 'DBにデータが作成されていること', js: true do
      sleep 0.1
      Todo.active.where(user_id: @current_user.id, detail: 'テストtodo').count.must_equal 1
    end
  end

  describe 'todoの削除行ったとき' do
    before do
      create(:todo, user_id: @current_user.id, detail: 'テスト用todo')
      visit todos_path
      page.execute_script %($('.icon-trash').click())
    end

    it 'DBからデータが削除されていること', js: true do
      sleep 0.1
      Todo.active.where(user_id: @current_user.id, detail: 'テスト用todo').count.must_equal 0
    end
  end
end
