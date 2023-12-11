# frozen_string_literal: true

require "rails_helper"

RSpec.describe Department, type: :model do
  describe "バリデーションテスト" do
    let(:department) { Department.new(name: "営業部") }
    subject { department.save }
    it "正しい内容の場合" do
      expect(department.save).to be_truthy
    end
    it "nameカラムの値が空である場合" do
      department.name = ""
      expect(department.save).to be_falsey
    end
    it "nameカラムの値が重複する場合" do
      Department.create(name: "営業部") 
      expect(department.save).to be_falsey
    end
  end
end
