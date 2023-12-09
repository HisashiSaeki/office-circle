# frozen_string_literal: true

require "rails_helper"

RSpec.describe GroupMember, type: :model do
  let!(:employee) { create(:employee) }
  let!(:group) { create(:group, creater_id: employee.id) }
  describe "#after_create_commit :create_group_members" do
    it "グループ作成時にグループリーダーがグループに参加している" do
      expect(GroupMember.where(employee_id: employee).pluck(:employee_id)).to include(employee.id)
    end
  end
  describe "バリデーションテスト" do
    it "同じグループに同じ社員は参加できない" do
      expect(GroupMember.create(employee_id: employee.id, group_id: group.id)).to be_invalid
    end
  end
end
