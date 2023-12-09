# frozen_string_literal: true

require "rails_helper"

RSpec.describe Group, type: :model do
  let!(:employee) { create(:employee) }
  let!(:group) { Group.new(
    name: "テストグループ",
    description: "活動内容",
    creater_id: employee.id,
  ) }
  describe "バリデーションテスト" do
    it "正しい内容は保存される" do
      expect(group.save).to be_truthy
    end
    it "nameカラムが空の場合は保存されない" do
      group.name = ""
      expect(group.save).to be_falsey
    end
    it "descriptionカラムが空の場合は保存されない" do
      group.description = ""
      expect(group.save).to be_falsey
    end
    it "nameカラムが100文字以上の場合は保存されない: 100文字はOK" do
      group.name = Faker::Lorem.characters(number: 200)
      expect(group.save).to be_falsey
    end
  end
  describe "#self.search(keyword)" do
    before { group.save }
    it "グループ名の部分検索ができる" do
      keyword = "テスト"
      expect(Group.search(keyword)).to include(group)
    end
    it "活動内容の部分検索ができる" do
      keyword = "活動"
      expect(Group.search(keyword)).to include(group)
    end
  end
end
