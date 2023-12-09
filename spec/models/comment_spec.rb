# frozen_string_literal: true

require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "バリデーションテスト" do
    let!(:employee) { create(:employee) }
    let!(:article) { create(:article, employee_id: employee.id) }
    let!(:comment) { Comment.new(
      employee_id: employee.id,
      article_id: article.id,
      comment: "正しい内容"
    )}
    it "正しい内容は保存される" do
      expect(comment.save).to be_truthy
    end

    it "commentカラムが空の場合は保存されない" do
      comment.comment = ""
      expect(comment.save).to be_falsey
    end
  end
end
