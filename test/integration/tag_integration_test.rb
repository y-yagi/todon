require 'test_helper'

describe 'TagIntegrationTest' do
  before do
    login
    @current_user = User.find_by(name: 'Example User')
  end

  describe 'タグの新規作成を行ったとき' do
    before do
      visit tags_path
      fill_in('tag[name]', with: 'integration用タグ')
      click_button '作成する'
    end

    it '作成したタグが表示されること' do
      page.text.must_include 'integration用タグ'
    end

    it 'DBにデータが作成されていること' do
      Tag.active.where(user_id: @current_user.id, name: 'integration用タグ').count.must_equal 1
    end
  end

  describe 'タグの削除行ったとき' do
    before do
      Tag.create!(name: 'テスト用タグ', user_id: @current_user.id)
      visit tags_path
      click_link('テスト用タグ')
    end

    it '作成したタグが表示されないこと' do
      page.text.wont_include 'テスト用タグ'
    end

    it 'DBからデータが削除されていること' do
      Tag.active.where(user_id: @current_user.id, name: 'テスト用タグ').count.must_equal 0
    end
  end
end
