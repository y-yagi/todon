require 'test_helper'

describe Todo do
  describe '#detail ' do
    valid_data = %w(あああ abc %-\!)
    valid_data.each do |dt|
      describe "detailが'#{dt}'のとき" do
        it 'validになること' do
          todo = build(:todo, detail: dt)
          todo.valid_attribute?(:detail).must_equal true
        end
      end
    end

    describe "タイトルが255文字のとき" do
      it 'validになること' do
        todo = build(:todo, detail: 'a' * 255)
        todo.valid_attribute?(:detail).must_equal true
      end
    end
    describe "タイトルが256文字のとき" do
      it 'invalidになること' do
        todo = build(:todo, detail: 'a' * 256)
        todo.valid_attribute?(:detail).must_equal false
      end
    end
  end
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
