# frozen_string_literal: true

require "rails_helper"

RSpec.describe Employee, type: :model do
  let!(:employee) { Employee.new(**params) }
  let(:params) {
    { last_name: "佐々木",
      first_name: "太朗",
      last_name_furigana: "ササキ",
      first_name_furigana: "タロウ",
      department_id: department.id,
      birthdate: "1996-06-22",
      prefecture: "東京都",
      email: "example@example.com",
      password: "123456",
      is_active: true,
    }
  }
  let(:department) { Department.create(name: "営業部") }
  subject { employee.save }
  describe "バリデーションテスト" do
    context "正しい内容を保存する場合" do
      it { is_expected.to be_truthy }
    end

    context "last_nameカラムの値が空である場合" do
      before do
        employee.last_name = ""
      end
      it { is_expected.to be_falsey }
    end

    context "first_nameカラムの値が空である場合" do
      before do
        employee.first_name = ""
      end
      it { is_expected.to be_falsey }
    end

    context "last_name_furiganaカラムの値が空である場合" do
      before do
        employee.last_name_furigana = ""
      end
      it { is_expected.to be_falsey }
    end

    context "first_name_furiganaカラムの値が空である場合" do
      before do
        employee.last_name_furigana = ""
      end
      it { is_expected.to be_falsey }
    end

    context "birthdateカラムの値が空である場合" do
      before do
        employee.birthdate = ""
      end
      it { is_expected.to be_falsey }
    end

    context "prefectureカラムの値が空である場合" do
      before do
        employee.prefecture = ""
      end
      it { is_expected.to be_falsey }
    end

    context "last_name_furiganaカラムの値がカナ文字でない場合" do
      before do
        employee.last_name_furigana = "ささき"
      end
      it { is_expected.to be_falsey }
    end

    context "first_name_furiganaカラムの値がカナ文字でない場合" do
      before do
        employee.last_name_furigana = "たろう"
      end
      it { is_expected.to be_falsey }
    end
  end

  describe "メソッドのテスト" do
    context "#full_name" do
      it "last_nameとfirst_nameの間に空白が空いている" do
        expect(employee.full_name).to eq "佐々木 太朗"
      end
    end
    context "#full_name_furigana" do
      it "last_name_furiganaとfirst_name_furiganaの間に空白が空いている" do
        expect(employee.full_name_furigana).to eq "ササキ タロウ"
      end
    end
    context "#self.search(keyword)" do
      it "キーワードで部分検索ができる" do
        employee.save
        keyword = "佐々木"
        expect(Employee.search(keyword)).to include(employee)
      end
    end
  end
end
