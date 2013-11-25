require 'test_helper'
require "minitest/autorun"

describe Todo do
  describe '.build' do
    describe 'paramsとuserが渡された場合' do
      before do
        @params =  ActionController::Parameters.new
        @params = {detail: "テスト"}
        @user = build(:user)
        @todo = Todo.build(@user, @params)
      end

      it '"Todo"クラスのインスタンスが返される事' do
        @todo.must_be_instance_of(Todo)
      end

      it 'paramsの値がtodoに設定されている事' do
        @todo.detail.must_equal(@params[:detail])
      end

      it 'userの値がtodoに設定されている事' do
        @todo.user_id.must_equal(@user.id)
      end
    end
  end
end
