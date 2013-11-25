require 'test_helper'

describe Tag do
  describe '#name ' do
    valid_data = %w(あああ abc %-\!)
    valid_data.each do |dt|
      describe "nameが'#{dt}'のとき" do
        it 'validになること' do
          tag = build(:tag, name: dt)
          tag.valid_attribute?(:name).must_equal true
        end
      end
    end

    describe "タグ名が255文字のとき" do
      it 'validになること' do
        tag = build(:tag, name: 'a' * 255)
        tag.valid_attribute?(:name).must_equal true
      end
    end

    describe "タグ名が256文字のとき" do
      it 'invalidになること' do
        tag = build(:tag, name: 'a' * 256)
        tag.valid_attribute?(:name).must_equal false
      end
    end
  end
end
