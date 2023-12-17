# frozen_string_literal: true

require "rails_helper"

RSpec.describe "[STEP2]社員ログイン後のテスト" do
  let!(:employee) { create(:employee) }
  before do
    visit new_employee_session_path
    fill_in "employee[email]", with: employee.email
    fill_in "employee[password]", with: employee.password
    click_on "ログイン"
  end

  describe "ヘッダーのテスト:ログインしている場合" do
    context "リンクの内容を確認: ※logoutは『ログアウト機能のテスト』でテスト済みになります。" do
      it "通知一覧を押すと通知一覧画面に移動する" do
        click_on "通知一覧"
        expect(current_path).to eq "/activities"
      end
      it "マイページへを押すとマイページに移動する" do
        click_on "マイページへ"
        expect(current_path).to eq "/employees/1"
      end
      it "新規投稿を押すと新規投稿画面に移動する" do
        click_on "新規投稿"
        expect(current_path).to eq "/articles/new"
      end
      it "社員一覧を押すと社員一覧画面に移動する" do
        click_on "社員一覧"
        expect(current_path).to eq "/employees"
      end
      it "投稿一覧を押すと投稿一覧画面に移動する" do
        click_on "投稿一覧"
        expect(current_path).to eq "/articles"
      end
      it "グループ一覧を押すとグループ一覧画面に移動する" do
        click_on "グループ一覧"
        expect(current_path).to eq "/groups"
      end
    end # context "リンクの内容を確認: ※logoutは『ログアウト機能のテスト』でテスト済みになります。"
  end # describe "ヘッダーのテスト:ログインしている場合"

  describe "マイページのテスト" do
    context "表示内容の確認" do
      it "URlが正しい" do
        expect(current_path).to eq "/employees/1"
      end
      it "プロフィール画像が表示されている" do
        expect(page).to have_selector "img"
      end
      it "「名前」が表示されている" do
        expect(page).to have_content "名前"
      end
      it "「フリガナ」が表示されている" do
        expect(page).to have_content "フリガナ"
      end
      it "「誕生日」が表示されている" do
        expect(page).to have_content "誕生日"
      end
      it "「出身地」が表示されている" do
        expect(page).to have_content "出身地"
      end
      it "「メールアドレス」が表示されている" do
        expect(page).to have_content "メールアドレス"
      end
      it "「部署」が表示されている" do
        expect(page).to have_content "部署"
      end
      it "「入社日」が表示されている" do
        expect(page).to have_content "入社日"
      end
      it "登録された社員の名前が表示されている" do
        expect(page).to have_content employee.full_name
      end
      it "登録された社員のフリガナが表示されている" do
        expect(page).to have_content employee.full_name_furigana
      end
      it "登録された社員の誕生日が表示されている" do
        expect(page).to have_content employee.birthdate.strftime("%-m月%-d日")
      end
      it "登録された社員の出身地が表示されている" do
        expect(page).to have_content employee.prefecture
      end
      it "登録された社員のメールアドレスが表示されている" do
        expect(page).to have_content employee.email
      end
      it "登録された社員の部署名が表示されている" do
        expect(page).to have_content employee.department.name
      end
      it "登録された社員の入社日が表示されている" do
        expect(page).to have_content employee.created_at.strftime("%Y年%m月%d日")
      end
      it "「自己紹介」が表示されている" do
        expect(page).to have_content "自己紹介"
      end
      it "introductionカラムが空の場合は、「登録内容変更ボタンから自己紹介文を設定しましょう！」が表示されている" do
        expect(page).to have_content "登録内容変更ボタンから自己紹介文を設定しましょう！"
      end
      it "登録内容を変更ボタンが存在する" do
        expect(page).to have_link "登録内容を変更"
      end
      it "タブメニューに(ログイン中の社員名)さんの投稿が表示されている" do
        expect(page).to have_field "#{employee.full_name}さんの投稿"
      end
      it "タブメニューにいいねした投稿が表示されている" do
        expect(page).to have_field "いいねした投稿"
      end
      it "タブメニューに参加中のグループが表示されている" do
        expect(page).to have_field "参加中のグループ"
      end
      it "タブメニューのうち、(ログイン中の社員名)さんの投稿がチェックされている" do
        expect(page).to have_checked_field "#{employee.full_name}さんの投稿"
      end
      it "タブメニューのうち、(ログイン中の社員名)さんの投稿がチェックされている時、 投稿がない場合、投稿はありませんが表示される" do
        expect(page).to have_content "投稿はありません"
      end
      it "タブメニューのうち、(ログイン中の社員名)さんの投稿がチェックされている時、 投稿がある場合、投稿が表示される" do
        Article.create(employee_id: employee.id, title: "自分の投稿テスト", body: "テスト", is_published: true)
        visit current_path
        expect(page).to have_link "自分の投稿テスト", href: article_path(Article.find_by(employee_id: employee))
      end
      it "タブメニューのうち、いいねした投稿がチェックされている時、 投稿にいいねしていない場合、いいねした投稿はありませんが表示される" do
        choose "いいねした投稿"
        expect(page).to have_content "いいねした投稿はありません"
      end
      it "タブメニューのうち、いいねした投稿がチェックされている時、 いいねした投稿がある場合、いいねした投稿が表示される" do
        Article.create(employee_id: employee.id, title: "いいねテスト", body: "テスト", is_published: true)
        Favorite.create(employee_id: employee.id, article_id: Article.find_by(employee_id: employee).id)
        visit current_path
        choose "いいねした投稿"
        expect(page).to have_link "いいねテスト", href: article_path(Article.find_by(employee_id: employee).id)
      end
      it "タブメニューのうち、参加中のグループがチェックされている時、 グループに参加していない場合、参加中のグループはありませんが表示される" do
        choose "参加中のグループ"
        expect(page).to have_content "参加中のグループはありません"
      end
      it "タブメニューのうち、参加中のグループがチェックされている時、 グループに参加している場合、参加中のグループが表示される" do
        Group.create(creater_id: employee.id, name: "テストグループ", description: "テスト" )
        visit current_path
        choose "参加中のグループ"
        expect(page).to have_link "テストグループ", href: group_path(Group.find_by(creater_id: employee).id)
      end
    end # context "表示内容の確認"
  end # describe "マイページのテスト"
  
  describe "社員編集画面のテスト" do
    let!(:department) {create(:department, name: "営業部")}
    before do
      click_on "登録内容を変更"
    end
    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/employees/#{employee.id}/edit"
      end
      it "「プロフィール画像」が表示されている" do
        expect(page).to have_content "プロフィール画像"
      end
      it "「氏名」が表示されている" do
        expect(page).to have_content "氏名"
      end
      it "「氏名(カナ)」が表示されている" do
        expect(page).to have_content "氏名(カナ)"
      end
      it "「生年月日」が表示されている" do
        expect(page).to have_content "生年月日"
      end
      it "「出身地」が表示されている" do
        expect(page).to have_content "出身地"
      end
      it "「部署」が表示されている" do
        expect(page).to have_content "部署"
      end
      it "「メールアドレス」が表示されている" do
        expect(page).to have_content "メールアドレス"
      end
      it "「自己紹介文」が表示されている" do
        expect(page).to have_content "自己紹介文"
      end
      it "登録された社員の苗字が表示されている" do
        expect(page).to have_field "employee[last_name]", with: employee.last_name
      end
      it "登録された社員の名前が表示されている" do
        expect(page).to have_field "employee[first_name]", with: employee.first_name
      end
      it "登録された社員の苗字(フリガナ)が表示されている" do
        expect(page).to have_field "employee[last_name_furigana]", with: employee.last_name_furigana
      end
      it "登録された社員の名前(フリガナ)が表示されている" do
        expect(page).to have_field "employee[first_name_furigana]", with: employee.first_name_furigana
      end
      it "登録された社員の生年月日が表示されている" do
        expect(page).to have_field "employee[birthdate]", with: employee.birthdate
      end
      it "登録された社員の出身地が表示されている" do
        expect(page).to have_field "employee[prefecture]", with: employee.prefecture
      end
      it "登録された社員の部署が表示されている" do
        expect(page).to have_select("部署", selected: employee.department.name, options: ["部署を選択してください", "営業部", "#{employee.department.name}"])
      end
      it "登録された社員のメールアドレスが表示されている" do
        expect(page).to have_field "employee[email]", with: employee.email
      end
      it "変更内容を保存ボタンが存在する" do
        expect(page).to have_button "変更内容を保存"
      end
    end # context "表示内容の確認"
    
    context "編集の成功テスト" do
      before do
        @old_last_name = employee.last_name
        @old_first_name = employee.first_name
        @old_last_name_furigana = employee.last_name_furigana
        @old_first_name_furigana = employee.first_name_furigana
        @old_birthdate = employee.birthdate
        @old_prefecture = employee.prefecture
        @old_department = employee.department.name
        @old_email = employee.email
        fill_in "employee[last_name]", with: "田中"
        fill_in "employee[first_name]", with: "太一"
        fill_in "employee[last_name_furigana]", with: "タナカ"
        fill_in "employee[first_name_furigana]", with: "タイチ"
        fill_in "employee[birthdate]", with: "2000-01-01"
        fill_in "employee[prefecture]", with: "北海道"
        select "#{department.name}"
        fill_in "employee[email]", with: "tanaka@example.com"
        fill_in "employee[introduction]", with: "自己紹介文"
        click_on "変更内容を保存"
      end
      it "苗字が正しく更新されている" do
        expect(page).to have_no_content @old_last_name
      end
      it "名前が正しく更新されている" do
        expect(page).to have_no_content @old_first_name
      end
      it "苗字のフリガナが正しく更新されている" do
        expect(page).to have_no_content @old_last_name_furigana
      end
      it "名前のフリガナが正しく更新されている" do
        expect(page).to have_no_content @old_first_name_furigana
      end
      it "生年月日が正しく更新されている" do
        expect(page).to have_no_content @old_birthdate
      end
      it "出身地が正しく更新されている" do
        expect(page).to have_no_content @old_prefecture
      end
      it "部署が正しく更新されている" do
        expect(page).to have_no_content @old_department
      end
      it "メールアドレスが正しく更新されている" do
        expect(page).to have_no_content @old_email
      end
      it "自己紹介文が正しく更新されている" do
        expect(page).to have_content "自己紹介文"
      end
      it "社員情報を編集完了後の遷移先がマイページになっている" do
        expect(current_path).to eq employee_path(employee)
      end
    end # context "編集の成功テスト"
  end # describe "社員編集画面のテスト"
  
  describe "社員一覧画面のテスト" do
    before do
      visit edit_employee_path(employee)
      fill_in "employee[introduction]", with: "自己紹介文"
      click_on "変更内容を保存"
      visit employees_path
    end
    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/employees"
      end
      it "検索フォームが存在する" do
        expect(page).to have_field "氏名を入力"
      end
      it "検索ボタンが存在する" do
        expect(page).to have_button "検索"
      end
      it "部署検索の見出しが存在する" do
        expect(page).to have_content "部署検索"
      end
      it "部署検索欄に登録済みの部署が表示されている" do
        within ".search-group" do
          expect(page).to have_content employee.department.name
        end
      end
      it "登録された社員のプロフィール画像が表示される" do
        expect(page).to have_selector "img"
      end
      it "登録された社員の名前が表示される" do
        expect(page).to have_content employee.full_name
      end
      it "登録された社員の部署名が表示される" do
        expect(page).to have_content employee.department.name
      end
      it "登録された社員の自己紹介文が表示される" do
        expect(page).to have_content "自己紹介文"
      end
    end # context "表示内容の確認"
    
    context "リンクの確認" do
      it "部署検索欄の部署名のリンクが正しい" do
        within ".search-group" do
          expect(page).to have_link employee.department.name, href: department_search_path(department_id: employee.department.id)
        end
      end
      it "登録された社員名のリンクが正しい" do
        expect(page).to have_link employee.full_name, href: employee_path(employee)
      end
    end # context "リンクの確認"
  end # describe "社員一覧画面のテスト"
  
  # describe "投稿一覧画面のテスト" do
  #   let!(:article) { create(:article, employee_id: employee.id) }
  #   let!(:comment) { Comment.create(employee_id: employee.id, article_id: article.id, comment: "テスト") }
  #   before do
  #     list_tags = ["公開中"]
  #     article.save_tags(list_tags)
  #     visit admin_articles_path
  #   end

  #   context "表示内容の確認" do
  #     it "URLが正しい" do
  #       expect(current_path).to eq "/admin/articles"
  #     end
  #     it "検索フォームが存在する" do
  #       expect(page).to have_field "keyword"
  #     end
  #     it "検索ボタンが存在する" do
  #       expect(page).to have_button "検索"
  #     end
  #     it "タグ検索の見出しが存在する" do
  #       expect(page).to have_content "タグ検索"
  #     end
  #     it "公開中の記事に紐づくタグがタグ検索欄に表示されている" do
  #       within ".search-group" do
  #         expect(page).to have_content "公開中"
  #       end
  #     end
  #     it "投稿した記事が存在する" do
  #       expect(page).to have_content "#{article.title}"
  #     end
  #     it "投稿した記事の作成日が表示される" do
  #       expect(page).to have_content "#{ Time.zone.today.strftime("%Y年%m月%d日")}"
  #     end
  #     it "投稿した記事の作者が表示される" do
  #       expect(page).to have_content "#{article.employee.full_name}"
  #     end
  #     it "投稿した記事のタイトルが表示される" do
  #       expect(page).to have_selector "h2", text: "#{article.title}"
  #     end
  #     it "投稿した記事に紐づくタグが表示される" do
  #       within ".article-record" do
  #         expect(page).to have_content "公開中"
  #       end
  #     end
  #     it "投稿した記事のコメントアイコンが表示される" do
  #       expect(page).to have_selector "i.fa-regular.fa-comments"
  #     end
  #     it "投稿した記事のコメント数が表示される" do
  #       expect(page).to have_selector ".horizontal-icon-list__item", text: "#{article.comments.size}"
  #     end
  #   end

  #   context "リンクの内容を確認" do
  #     it "投稿した記事のタイトルのリンクが正しい" do
  #       expect(page).to have_link article.title, href: admin_article_path(article)
  #     end
  #     it "タグ検索欄のタグのリンクが正しい" do
  #       within ".search-group" do
  #         expect(page).to have_link "公開中", href: admin_tag_search_path(tag_id: 1)
  #       end
  #     end
  #     it "投稿した記事に紐づくタグのリンクが正しい" do
  #       within ".article-record" do
  #         expect(page).to have_link "公開中", href: admin_tag_search_path(tag_id: 1)
  #       end
  #     end
  #   end
  # end # describe "投稿一覧画面のテスト"
end