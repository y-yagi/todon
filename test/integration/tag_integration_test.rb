require 'test_helper'

describe "タグ管理テストIntegration" do
  before do
    login
    @current_user = User.first
  end

  describe 'タグの新規作成を行ったとき' do
    before do
      visit tags_path
      fill_in('tag[name]', with: 'テスト用タグ')
      click_button '作成する'
    end

    it '作成したタグが表示されること', js: true do
      page.text.must_include 'テスト用タグ'
    end

    it 'DBにデータが作成されていること', js: true do
      sleep 0.1
      Tag.active.where(user_id: @current_user.id, name: 'テスト用タグ').count.must_equal 1
    end
  end

  describe 'タグの削除行ったとき' do
    before do
      create(:tag, user_id: @current_user.id, name: 'テスト用タグ')
      visit tags_path
      click_link('テスト用タグ')
    end

    it '作成したタグが表示されないこと', js: true do
      page.text.wont_include 'テスト用タグ'
    end

    it 'DBからデータが削除されていること', js: true do
      sleep 0.1
      Tag.active.where(user_id: @current_user.id, name: 'テスト用タグ').count.must_equal 0
    end
  end
end
