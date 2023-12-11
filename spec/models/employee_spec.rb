# frozen_string_literal: true

require "rails_helper"

RSpec.describe Employee, type: :model do
  let!(:department) { create(:department)}
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
  describe "バリデーションテスト" do
    it "正しい内容を保存する場合" do
      expect(employee.save).to be_truthy
    end

    it "last_nameカラムの値が空である場合" do
      employee.last_name = ""
      expect(employee.save).to be_falsey
    end

    it "first_nameカラムの値が空である場合" do
      employee.first_name = ""
      expect(employee.save).to be_falsey
    end

    it "last_name_furiganaカラムの値が空である場合" do
      employee.last_name_furigana = ""
      expect(employee.save).to be_falsey
    end

    it "first_name_furiganaカラムの値が空である場合" do
      employee.first_name_furigana = ""
      expect(employee.save).to be_falsey
    end

    it "birthdateカラムの値が空である場合" do
      employee.birthdate = ""
      expect(employee.save).to be_falsey
    end

    it "prefectureカラムの値が空である場合" do
      employee.prefecture = ""
      expect(employee.save).to be_falsey
    end

    it "last_name_furiganaカラムの値がカナ文字でない場合" do
      employee.last_name_furigana = "ささき"
      expect(employee.save).to be_falsey
    end

    it "first_name_furiganaカラムの値がカナ文字でない場合" do
      employee.last_name_furigana = "たろう"
      expect(employee.save).to be_falsey
    end
  end

  describe "#full_name" do
    it "last_nameとfirst_nameが結合し、間に空白が空いている" do
      expect(employee.full_name).to eq "佐々木 太朗"
    end
  end
  describe "#full_name_furigana" do
    it "last_name_furiganaとfirst_name_furiganaが結合し、間に空白が空いている" do
      expect(employee.full_name_furigana).to eq "ササキ タロウ"
    end
  end
  describe "#self.search(keyword)" do
    before { employee.save }
    it "キーワードでlast_nameの部分検索ができる" do
      keyword = "佐々木"
      expect(Employee.search(keyword)).to include(employee)
    end
    it "キーワードでfirst_nameの部分検索ができる" do
      keyword = "太朗"
      expect(Employee.search(keyword)).to include(employee)
    end
    it "キーワードでlast_name_furiganaの部分検索ができる" do
      keyword = "ササキ"
      expect(Employee.search(keyword)).to include(employee)
    end
    it "キーワードでfirst_name_furiganaの部分検索ができる" do
      keyword = "タロウ"
      expect(Employee.search(keyword)).to include(employee)
    end
  end
end
