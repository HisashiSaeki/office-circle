# frozen_string_literal: true

require "rails_helper"

RSpec.describe Article, type: :model do
  let!(:employee) { create(:employee) }
  let!(:article) { Article.new(**params) }
  let(:params) { {
    employee_id: employee.id,
    title: "正しい内容",
    body: "正しい内容",
    is_published: true,
  } }
  describe "バリデーションテスト" do
    it "正しい内容の場合" do
      expect(article.save).to be_truthy
    end
    it "titleカラムが空白の場合" do
      article.title = ""
      expect(article.save).to be_falsey
    end
    it "bodyカラムが空白の場合" do
      article.body = ""
      expect(article.save).to be_falsey
    end
    it "titleカラムが100文字以上の場合: 100文字はOK" do
      article.title = Faker::Lorem.characters(number: 200)
      expect(article.save).to be_falsey
    end
  end
  describe "#save_tags(send_tags)" do
    before { article.save }
    let(:send_tag1) { "タグ,保存、テスト 成功" }
    it "send_tag1のタグが記事に紐づけられる" do
      article.save_tags(send_tag1)
      expect(article.tags.pluck(:name)).to eq ["タグ", "保存", "テスト", "成功"]
    end
  end
  describe "#update_tags(send_tags)" do
    before { article.save }
    let(:send_tag1) { "タグ,保存、テスト 成功" }
    let(:send_tag2) { "タグ、更新,複数 完了" }
    before { article.save_tags(send_tag1) }
    it "記事に紐づくsend_tag1のタグをsend_tag2のタグが上書きする" do
      article.update_tags(send_tag2)
      expect(article.tags.pluck(:name)).to eq ["タグ", "更新", "複数", "完了"]
    end
  end
  describe "#self.search(keyword)" do
    before { article.save }
    it "キーワードでtitleの部分検索ができる" do
      keyword = "正しい"
      expect(Article.search(keyword)).to include(article)
    end
  end
end
