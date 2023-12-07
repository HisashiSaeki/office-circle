# frozen_string_literal: true

require "rails_helper"

RSpec.describe Department, type: :model do
  describe "バリデーションテスト" do
    let(:department) { Department.new(**params) }
    let(:params) { { name: } }
    subject { department.save }
    context "正しい内容の場合" do
      let(:name) { "営業部" }
      it { is_expected.to be_truthy }
    end
    context "nameカラムの値が空である場合" do
      let(:name) { "" }
      it { is_expected.to be_falsey }
    end
    context "nameカラムの値が重複する場合" do
      before do
        Department.create(name: "営業部")
      end
      let(:name) { "営業部" }
      it { is_expected.to be_falsey }
    end
  end
end
