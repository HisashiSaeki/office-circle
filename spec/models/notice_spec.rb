# frozen_string_literal: true

require "rails_helper"

RSpec.describe Notice, type: :model do
  describe "バリデーションテスト" do
    let!(:group) { create(:group) }
    let!(:notice) { Notice.new(
      title: "お知らせタイトル",
      body: "活動詳細",
      group_id: group.id,
    )}
    it "正しい内容は保存される" do
      expect(notice.save).to be_truthy
    end
    it "titleカラムが空の場合は保存されない" do
      notice.title = ""
      expect(notice.save).to be_falsey
    end
    it "bodyカラムが空の場合は保存されない" do
      notice.body = ""
      expect(notice.save).to be_falsey
    end
    it "titleカラムが100文字以上の場合は保存されない: 100文字はOK" do
      notice.title = Faker::Lorem.characters(number: 200)
      expect(notice.save).to be_falsey
    end
  end
end
