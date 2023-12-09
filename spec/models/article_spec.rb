# frozen_string_literal: true

require "rails_helper"

RSpec.describe Article, type: :model do
  let!(:employee) { Employee.create(
    last_name: "佐々木",
    first_name: "太朗",
    last_name_furigana: "ササキ",
    first_name_furigana: "タロウ",
    department_id: Department.create(name: "営業部").id,
    birthdate: "1996-06-22",
    prefecture: "東京都",
    email: "example@example.com",
    password: "123456",
    is_active: true,
  ) }
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
    let(:send_tags1) { "タグ、保存、テスト".split("、").uniq }
    it "send_tags1のタグが記事に紐づけられる" do
      article.save_tags(send_tags1)
      expect(article.tags.pluck(:name)).to eq ["タグ", "保存", "テスト"]
    end
  end
  describe "#update_tags(send_tags)" do
    before { article.save }
    let(:send_tags1) { "タグ、保存、テスト".split("、").uniq }
    let(:send_tags2) { "タグ、更新".split("、").uniq }
    before { article.save_tags(send_tags1) }
    it "記事に紐づくsend_tags1のタグをsend_tags2のタグが上書きする" do
      article.update_tags(send_tags2)
      expect(article.tags.pluck(:name)).to eq ["タグ", "更新"]
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
