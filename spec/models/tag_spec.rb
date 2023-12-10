# frozen_string_literal: true

require "rails_helper"

RSpec.describe Tag, type: :model do
  describe "バリデーションテスト" do
    let!(:tag) { Tag.new(name: "正しい内容") }
    it "正しい内容は保存される" do
      expect(tag.save).to be_truthy
    end
    it "nameカラムが空の場合は保存されない" do
      tag.name = ""
      expect(tag.save).to be_falsey
    end
    it "同じ名前のタグは保存されない" do
      tag.save
      expect(Tag.create(name: "正しい内容")).to be_invalid
    end
  end
  describe "#self.published_article_tags" do
    let!(:employee) { create(:employee) }
    let!(:article) { create(:article, employee_id: employee.id) }
    before do
      article_is_private = Article.create(title: "非公開", body: "非公開", is_published: false, employee_id: employee.id)
      tag_list1 = ["公開中"]
      tag_list2 = ["非公開"]
      article.save_tags(tag_list1)
      article_is_private.save_tags(tag_list2)
    end
    it "公開中の記事に紐づくタグの一覧を取得する" do
      expect(Tag.published_article_tags.pluck(:name)).not_to include "非公開"
    end
  end
end
