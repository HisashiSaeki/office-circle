# frozen_string_literal: true

require "rails_helper"

RSpec.describe "[STEP3]その他のテスト" do
  let!(:admin) { create(:admin) }
  let!(:employee) { create(:employee) }
  let!(:department) { create(:department) }
  before do
    visit new_admin_session_path
    fill_in "admin_email", with: admin.email
    fill_in "admin_password", with: admin.password
    click_on "ログイン"
  end
  describe "フラッシュメッセージのテスト:ログイン/ログアウトは実行済み" do
    it "部署の新規登録成功時" do
      visit admin_departments_path
      fill_in "department[name]", with: Faker::Lorem.characters(number: 5)
      click_on "登録"
      expect(page).to have_content "部署の登録が完了しました"
    end
    it "部署の変更完了時" do
      visit edit_admin_department_path(department)
      fill_in "department[name]", with: Faker::Lorem.characters(number: 5)
      click_on "登録"
      expect(page).to have_content "部署の変更が完了しました"
    end
    it "社員情報の変更完了時" do
      visit edit_admin_employee_path(employee)
      click_on "登録情報を変更"
      expect(page).to have_content "社員情報の変更が完了しました"
    end
  end
  describe "処理失敗時のメッセージテスト(保存されないことに関しては単体テストで実証済み)" do
    context "部署の新規登録失敗: nameを空にする" do
      before do
        visit admin_departments_path
        fill_in "department[name]", with: ""
        click_on "登録"
      end
      it "部署一覧/新規作成画面が表示されており、フォームの内容が正しい" do
        expect(page).to have_button "登録"
        expect(page).to have_field "department[name]", with: ""
      end
      it "バリデーションエラーが表示される" do
        expect(page).to have_content "部署名を入力してください"
      end
    end

    context "部署の変更失敗: nameを空にする" do
      before do
        visit edit_admin_department_path(department)
        fill_in "department[name]", with: ""
        click_on "登録"
      end
      it "部署編集画面が表示されており、フォームの内容が正しい" do
        expect(page).to have_field "department[name]", with: ""
      end
      it "バリデーションエラーが表示される" do
        expect(page).to have_content "部署名を入力してください"
      end
    end

    context "社員情報の変更失敗" do
      before do
        visit edit_admin_employee_path(employee)
        fill_in "employee[last_name]", with: ""
        fill_in "employee[last_name_furigana]", with: "たろう"
        click_on "登録情報を変更"
      end
      it "社員情報編集画面が表示されており、フォームの内容が正しい" do
        expect(page).to have_button "登録情報を変更"
        expect(page).to have_field "employee[last_name]", with: ""
        expect(page).to have_field "employee[last_name_furigana]", with: "たろう"
      end
      it "バリデーションエラーが表示される(空の場合のメッセージを検証)" do
        expect(page).to have_content "苗字を入力してください"
      end
      it "バリデーションエラーが表示される(カナ表記でない場合のメッセージを検証)" do
        expect(page).to have_content "苗字のフリガナは全角カタカナで入力してください"
      end
    end
  end

  describe "社員のアカウント停止〜ログイン無効テスト" do
    context "ログアウト状態の社員の場合" do
      before do
        visit edit_admin_employee_path(employee)
        choose "停止"
        click_on "登録情報を変更"
        click_on "ログアウト" # 管理者ログアウト
        click_on "ログイン" # トップ画面から社員ログイン画面へ
        fill_in "employee[email]", with: employee.email
        fill_in "employee[password]", with: employee.password
      end
      it "ログインできなかった場合、トップ画面に遷移する" do
        click_on "ログイン"
        expect(current_path).to eq "/"
      end
      it "ログインできなかった場合、メッセージが表示される" do
        click_on "ログイン"
        expect(page).to have_content "アカウント停止中です。管理者にご連絡ください。"
      end
    end

    context "ログイン中の社員の場合" do
      before do
        # 管理者と社員が同時にログインした状態で、管理者側からログイン中の社員ステータスを停止する
        click_on "OfficeCircle"
        click_on "ログイン" # トップ画面のログインボタン
        fill_in "employee[email]", with: employee.email
        fill_in "employee[password]", with: employee.password
        click_on "ログイン" # ログイン画面のログインボタン
        visit edit_admin_employee_path(employee)
        choose "停止"
      end
      it "強制的にログアウトされ、トップ画面に移動する" do
        click_on "登録情報を変更"
        expect(current_path).to eq new_employee_session_path
      end
      it "メッセージが表示される" do
        click_on "登録情報を変更"
        expect(page).to have_content "アカウントがロックされています。管理者にご連絡ください。"
      end
    end
  end
end
