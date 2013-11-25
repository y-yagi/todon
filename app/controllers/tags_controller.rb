class TagsController < ApplicationController
  before_action :set_tag, only: [:destroy]
  def index
    @tags = Tag.active.user(current_user)
    @tag = Tag.new
  end

  def create
    @tag = Tag.build(tag_params(params), current_user)
    @tag.save!
    redirect_to tags_url, notice: 'タグを作成しました！'
  end

  def destroy
    @tag.delete
    redirect_to tags_url, notice: 'タグを削除しました！'
  end

  private
    def set_tag
      @tag = Tag.user(current_user).find(params[:id])
    end

    def tag_params(params)
      params.require(:tag).permit(:name, :deleted)
    end
end
