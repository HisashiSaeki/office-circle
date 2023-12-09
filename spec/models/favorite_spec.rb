# frozen_string_literal: true

require "rails_helper"

RSpec.describe Favorite, type: :model do
  let!(:employee) { create(:employee) }
  let!(:article) { create(:article, employee_id: employee.id) }
  describe "バリデーションテスト" do
    it "同じ記事に同じ社員がいいねはできない" do
      Favorite.create(employee_id: employee.id, article_id: article.id)
      expect(Favorite.create(employee_id: employee.id, article_id: article.id)).to be_invalid
    end
  end
end
