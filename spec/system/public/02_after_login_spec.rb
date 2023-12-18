# frozen_string_literal: true

require "rails_helper"

RSpec.describe "[STEP2]社員ログイン後のテスト" do
  let!(:department) { create(:department, name: "営業部") }
  let!(:employee) { create(:employee) }
  let!(:other_employee) { create(:employee) }
  let!(:group) { create(:group, creater_id: employee.id) }
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

  describe "社員詳細画面のテスト: マイページの場合" do
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
        Group.find_by(creater_id: employee.id).delete
        visit current_path
        choose "参加中のグループ"
        expect(page).to have_content "参加中のグループはありません"
      end
      it "タブメニューのうち、参加中のグループがチェックされている時、 グループに参加している場合、参加中のグループが表示される" do
        choose "参加中のグループ"
        expect(page).to have_link group.name, href: group_path(group)
      end
    end # context "表示内容の確認"
  end # describe "社員詳細画面のテスト: マイページの場合"

  describe "社員詳細画面のテスト: 他の社員の場合" do
    before do
      visit employee_path(other_employee)
    end
    context "表示内容の確認" do
      it "登録内容を変更ボタンが存在しない" do
        expect(page).to have_no_link "登録内容を変更"
      end
      it "記事の投稿ステータスが表示されない" do
        Article.create(employee_id: other_employee.id, title: "テスト", body: "テスト", is_published: true)
        expect(page).to have_no_selector ".status", text: "公開中"
      end
      it "下書き保存された記事は表示されない" do
        Article.create(employee_id: other_employee.id, title: "テスト", body: "テスト", is_published: false)
        expect(page).to have_no_link "テスト"
      end
      it "タブメニューにいいねした投稿が表示されていない" do
        expect(page).to have_no_field "いいねした投稿"
      end
    end # context "表示内容の確認"
  end # describe "社員詳細画面のテスト: 他の社員の場合"

  describe "社員編集画面のテスト" do
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
        expect(page).to have_select("部署", selected: employee.department.name, options: ["部署を選択してください", "営業部", "#{employee.department.name}", "#{other_employee.department.name}"])
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

  describe "投稿一覧画面のテスト" do
    let!(:article) { create(:article, employee_id: employee.id) }
    before do
      list_tags = ["公開中"]
      article.save_tags(list_tags)
      visit articles_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/articles"
      end
      it "検索フォームが存在する" do
        expect(page).to have_field "記事タイトルを入力"
      end
      it "検索ボタンが存在する" do
        expect(page).to have_button "検索"
      end
      it "タグ検索の見出しが存在する" do
        expect(page).to have_content "タグ検索"
      end
      it "公開中の記事に紐づくタグがタグ検索欄に表示されている" do
        within ".search-group" do
          expect(page).to have_content "公開中"
        end
      end
      it "投稿した記事が存在する" do
        expect(page).to have_content "#{article.title}"
      end
      it "投稿した記事の作成日が表示される" do
        expect(page).to have_content "#{ article.created_at.strftime("%Y年%m月%d日")}"
      end
      it "投稿した記事の作者が表示される" do
        expect(page).to have_content "#{article.employee.full_name}"
      end
      it "投稿した記事のタイトルが表示される" do
        expect(page).to have_selector "h2", text: "#{article.title}"
      end
      it "投稿した記事に紐づくタグが表示される" do
        within ".article-record" do
          expect(page).to have_content "公開中"
        end
      end
      it "投稿した記事のいいねアイコンが表示される" do
        expect(page).to have_selector "i.fa-regular.fa-thumbs-up"
      end
      it "投稿した記事のいいね数が表示される" do
        expect(page).to have_selector "#favorite_btn_#{article.id}", text: "#{article.favorites.size}"
      end
      it "投稿した記事のコメントアイコンが表示される" do
        expect(page).to have_selector "i.fa-regular.fa-comments"
      end
      it "投稿した記事のコメント数が表示される" do
        expect(page).to have_selector ".horizontal-icon-list__item", text: "#{article.comments.size}"
      end
    end # context "表示内容の確認"

    context "リンクの内容を確認" do
      it "投稿した記事のタイトルのリンクが正しい" do
        expect(page).to have_link article.title, href: article_path(article)
      end
      it "タグ検索欄のタグのリンクが正しい" do
        within ".search-group" do
          expect(page).to have_link "公開中", href: tag_search_path(tag_id: 1)
        end
      end
      it "投稿した記事に紐づくタグのリンクが正しい" do
        within ".article-record" do
          expect(page).to have_link "公開中", href: tag_search_path(tag_id: 1)
        end
      end
    end # context "リンクの内容を確認"
  end # describe "投稿一覧画面のテスト"

  describe "投稿詳細画面のテスト: 自分の投稿" do
    let!(:article) { create(:article, employee_id: employee.id) }
    let!(:other_article) { create(:article, employee_id: other_employee.id) }
    let!(:comment) { Comment.create(employee_id: employee.id, article_id: article.id, comment: "employeeのコメント") }
    let!(:other_comment) { Comment.create(employee_id: other_employee.id, article_id: article.id, comment: "other_employeeのコメント") }
    before do
      click_on "投稿一覧"
      list_tags = ["公開中"]
      article.save_tags(list_tags)
      visit articles_path
      click_on article.title
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/articles/#{article.id}"
      end
      it "投稿した記事のいいねアイコンが表示される" do
        expect(page).to have_selector "i.fa-regular.fa-thumbs-up"
      end
      it "投稿した記事のいいね数が表示される" do
        expect(page).to have_selector "#favorite_btn_#{article.id}", text: "#{article.favorites.size}"
      end
      it "作者のプロフィール画像が表示される" do
        within ".article-employee-image" do
          expect(page).to have_selector "img"
        end
      end
      it "作者の名前が表示される" do
        expect(page).to have_content article.employee.full_name
      end
      it "作者の部署名が表示される" do
        expect(page).to have_content "(#{article.employee.department.name})"
      end
      it "記事のタイトルが表示される" do
        expect(page).to have_content article.title
      end
      it "記事に紐づくタグが表示される" do
        expect(page).to have_content "公開中"
      end
      it "投稿日が表示される" do
        expect(page).to have_content "投稿日：#{article.created_at.strftime("%Y年%m月%d日")}"
      end
      it "最終更新日が表示される" do
        expect(page).to have_content "最終更新日：#{article.updated_at.strftime("%Y年%m月%d日 %H時%M分")}"
      end
      it "記事の本文が表示される" do
        expect(page).to have_content article.body
      end
      it "投稿編集ボタンが存在する" do
        expect(page).to have_link "投稿編集", href: edit_article_path(article)
      end
      it "投稿削除ボタンが存在する" do
        expect(page).to have_link "投稿削除"
      end
      it "コメントの見出しが表示される" do
        expect(page).to have_content "コメント"
      end
      it "コメントの作者のプロフィール画像が表示される" do
        within ".comment-#{comment.id}" do
          expect(page).to have_selector "img"
        end
      end
      it "コメントの作者の名前が表示される" do
        expect(page).to have_content employee.full_name
        expect(page).to have_content other_employee.full_name
      end
      it "コメントの作者の部署名が表示される" do
        expect(page).to have_content "(#{employee.department.name})"
        expect(page).to have_content "(#{other_employee.department.name})"
      end
      it "コメントの作成日が表示される" do
        expect(page).to have_content comment.created_at.strftime("%Y年%m月%d日 %H時%M分")
        expect(page).to have_content other_comment.created_at.strftime("%Y年%m月%d日 %H時%M分")
      end
      it "コメントの内容が表示される" do
        expect(page).to have_content comment.comment
        expect(page).to have_content other_comment.comment
      end
      it "自分のコメントの削除ボタンが表示される" do
        expect(page).to have_link "削除", href: article_comment_path(article_id: article.id, id: Comment.find_by(employee_id: employee.id))
      end
      it "別の社員のコメントの削除ボタンが表示されない" do
        expect(page).to have_no_link "削除", href: article_comment_path(article_id: article.id, id: Comment.find_by(employee_id: other_employee.id))
      end
      it "コメント入力フォームが存在する" do
        expect(page).to have_field "comment[comment]"
      end
      it "コメントを作成ボタンが存在する" do
        expect(page).to have_button "コメントを作成"
      end
    end # context "表示内容の確認"

    context "リンクの内容を確認" do
      it "作者の名前のリンクが正しい" do
        expect(page).to have_link article.employee.full_name, href: employee_path(employee)
      end
      it "記事に紐づくタグのリンクが正しい" do
        expect(page).to have_link "公開中", href: tag_search_path(tag_id: 1)
      end
    end # context "リンクの内容を確認"

    context "投稿削除テスト" do
      it "投稿削除ボタンを押すと投稿が削除される" do
        expect { click_on "投稿削除" }.to change { Article.count }.by(-1)
      end
      it "投稿を削除すると、投稿一覧画面に遷移する" do
        click_on "投稿削除"
        expect(current_path).to eq articles_path
      end
    end
    # context "いいねの登録テスト", js: true do
    #   it "いいねアイコンを押すと登録できる" do
    #     find(".favorite_link_#{article.id}").click
    #     expect{ article.favorites.all}.to change {article.favorites.count}.by(1)
    #   end
    #   it "いいねを登録するとアイコンが削除用のいいねアイコンに切り替わる" do
    #     find(".favorite_link_#{article.id}").click
    #     expect(page).to have_selector "i.fa-solid.fa-thumbs-up"
    #   end
    # end # context "いいねの登録テスト"

    # context "コメント作成成功テスト", js: true do
    #   before do
    #     fill_in "comment[comment]", with: "新規コメント"
    #     click_on "コメントを作成"
    #   end
    #   it "コメントが作成される" do
    #     expect {Comment.all}.to change {Comment.count}.by(1)
    #   end
    #   it "コメントを作成すると、コメント入力フォームが空になる" do
    #     expect(page).to have_field "comment[comment]", with: ""
    #   end
    #   it "コメント作成後、投稿詳細画面から遷移しない" do
    #     expect(current_path).to eq article_path(article)
    #   end
    # end # context "コメント作成成功テスト"

    # context "コメントの削除成功テスト", js: true do
    #   it "コメントが表示されない" do
    #     expect(Comment.find_by(employee_id: employee.id).delete).to have_no_content "employeeのコメント"
    #   end
    #   it "コメントを削除した後、他の画面に遷移しない" do
    #     Comment.find_by(employee_id: employee.id).delete
    #     expect(current_path).to eq article_path(article)
    #   end
    # end # context "コメントの削除成功テスト"
  end # describe "投稿詳細画面のテスト: 自分の投稿"

  describe "投稿詳細画面のテスト: 他の社員の投稿" do
    let!(:other_article) { create(:article, employee_id: other_employee.id) }
    before do
      visit article_path(other_article)
    end
    context "表示内容の確認" do
      it "投稿編集ボタンが存在しない" do
        expect(page).to have_no_link "投稿編集", href: edit_article_path(other_article)
      end
      it "投稿削除ボタンが存在しない" do
        expect(page).to have_no_link "投稿削除"
      end
    end # context "表示内容の確認"
  end # describe "投稿詳細画面のテスト: 他の社員の投稿"

  describe "新規投稿画面のテスト" do
    before do
      click_on "新規投稿"
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/articles/new"
      end
      it "1.タイトルを入力してくださいが表示される" do
        expect(page).to have_content "1.タイトルを入力してください"
      end
      it "2.本文を入力してくださいが表示される" do
        expect(page).to have_content "2.本文を入力してください"
      end
      it "3.タグを入力してくださいが表示される" do
        expect(page).to have_content "3.タグを入力してください"
      end
      it "タイトル入力フォームが存在する" do
        expect(page).to have_field "article[title]"
      end
      it "本文入力フォームが存在する" do
        expect(page).to have_field "article[body]"
      end
      it "タグ入力フォームが存在する" do
        expect(page).to have_field "article[tag]"
      end
      it "投稿するボタンが存在する" do
        expect(page).to have_button "投稿する"
      end
      it "下書き保存するボタンが存在する" do
        expect(page).to have_button "下書き保存する"
      end
    end # context "表示内容の確認"

    context "記事の投稿テスト: 成功ケースのみ" do
      before do
        fill_in "article[title]", with: "投稿テスト"
        fill_in "article[body]", with: Faker::Lorem.characters(number: 10)
        fill_in "article[tag]", with: "投稿タグ"
      end
      it "投稿するボタンを押すと投稿に成功する" do
        expect { click_on "投稿する" }.to change { Article.count }.by(1)
      end
      it "投稿に成功すると、記事詳細画面に遷移する" do
        click_on "投稿する"
        expect(current_path).to eq article_path(Article.find_by(employee_id: employee.id))
      end
      it "投稿した記事が投稿一覧画面に表示される" do
        click_on "投稿する"
        visit articles_path
        expect(page).to have_link "投稿テスト", href: article_path(Article.find_by(employee_id: employee.id))
      end
      it "投稿した記事のタグが投稿一覧画面のタグ検索欄に表示される" do
        click_on "投稿する"
        visit articles_path
        expect(page).to have_link "投稿タグ", href: tag_search_path(tag_id: 1)
      end
      it "マイページのタブメニュー(ログイン中の社員)さんの投稿に投稿した記事が表示される: 投稿するボタンで作成した場合、ステータスが公開中と表示される" do
        click_on "投稿する"
        visit employee_path(employee)
        expect(page).to have_link "投稿テスト", href: article_path(Article.find_by(employee_id: employee.id))
        expect(page).to have_selector ".status", text: "公開中"
      end
    end # context "記事の投稿テスト: 成功ケースのみ"

    context "記事の下書き保存成功テスト: 成功ケースのみ" do
      before do
        fill_in "article[title]", with: "下書き投稿テスト"
        fill_in "article[body]", with: Faker::Lorem.characters(number: 10)
        fill_in "article[tag]", with: "下書き投稿タグ"
      end
      it "下書き保存するボタンを押すと投稿に成功する" do
        expect { click_on "下書き保存する" }.to change { Article.count }.by(1)
      end
      it "下書き保存に成功すると、記事詳細画面に遷移する" do
        click_on "下書き保存する"
        expect(current_path).to eq article_path(Article.find_by(employee_id: employee.id))
      end
      it "下書き保存した記事は投稿一覧画面に表示されない" do
        click_on "下書き保存する"
        visit articles_path
        expect(page).to have_no_link "下書き投稿テスト", href: article_path(Article.find_by(employee_id: employee.id))
      end
      it "下書き保存した記事のタグが投稿一覧画面のタグ検索欄に表示されない" do
        click_on "下書き保存する"
        visit articles_path
        expect(page).to have_no_link "下書き投稿タグ", href: tag_search_path(tag_id: 1)
      end
      it "マイページのタブメニュー(ログイン中の社員)さんの投稿に下書き保存した記事が表示される: 下書き保存するボタンで作成した場合、ステータスが下書きと表示される" do
        click_on "下書き保存する"
        visit employee_path(employee)
        expect(page).to have_link "下書き投稿テスト", href: article_path(Article.find_by(employee_id: employee.id))
        expect(page).to have_selector ".status--non-actived", text: "下書き"
      end
    end # context "記事の下書き保存成功テスト: 成功ケースのみ"
  end # describe "新規投稿画面のテスト"

  describe "投稿編集画面のテスト" do
    let!(:article) { create(:article, employee_id: employee.id) }
    before do
      list_tags = ["タグ"]
      article.save_tags(list_tags)
      # 投稿編集画面まで遷移
      visit edit_article_path(article)
    end
    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/articles/#{article.id}/edit"
      end
      it "1.タイトルを入力してくださいが表示される" do
        expect(page).to have_content "1.タイトルを入力してください"
      end
      it "2.本文を入力してくださいが表示される" do
        expect(page).to have_content "2.本文を入力してください"
      end
      it "3.タグを入力してくださいが表示される" do
        expect(page).to have_content "3.タグを入力してください"
      end
      it "タイトル入力フォームが存在する" do
        expect(page).to have_field "article[title]", with: article.title
      end
      it "本文入力フォームが存在する" do
        expect(page).to have_field "article[body]", with: article.body
      end
      it "タグ入力フォームが存在する" do
        expect(page).to have_field "article[tag]", with: "タグ"
      end
      it "投稿するボタンが存在する" do
        expect(page).to have_button "投稿する"
      end
      it "下書き保存するボタンが存在する" do
        expect(page).to have_button "下書き保存する"
      end
    end # context "表示内容の確認"

    context "編集成功テスト" do
      before do
        @old_article_title = article.title
        @old_article_body = article.body
        @old_article_tags = "公開中"
        fill_in "article[title]", with: Faker::Lorem.characters(number: 10)
        fill_in "article[body]", with: Faker::Lorem.characters(number: 10)
        fill_in "article[tag]", with: "更新"
        click_on "投稿する"
      end

      it "編集に成功すると記事詳細画面に遷移する" do
        expect(current_path).to eq article_path(article)
      end
      it "タイトルが更新されている" do
        expect(page).to have_no_content @old_article_title
      end
      it "本文が更新されている" do
        expect(page).to have_no_content @old_article_body
      end
      it "タグが更新されている" do
        expect(page).to have_no_content @old_article_tags
      end
    end
  end # describe "投稿編集画面のテスト"

  describe "グループ一覧画面のテスト" do
    before do
      click_on "グループ一覧"
    end
    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/groups"
      end
      it "検索フォームが存在する" do
        expect(page).to have_field "キーワードを入力"
      end
      it "検索ボタンが存在する" do
        expect(page).to have_button "検索"
      end
      it "グループ新規作成ボタンが表示される" do
        expect(page).to have_link "グループ新規作成", href: new_group_path
      end
      it "グループ名が表示される" do
        expect(page).to have_link group.name
      end
      it "グループリーダー名が表示される" do
        expect(page).to have_content "グループリーダー: #{employee.full_name} (#{employee.department.name})"
      end
      it "グループ作成日が表示される" do
        expect(page).to have_content group.created_at.strftime("%Y年%m月%d日")
      end
      it "グループメンバー数が表示される" do
        expect(page).to have_content "メンバー数:#{group.group_members.count}人"
      end
    end # context "表示内容の確認"

    context "リンクの確認" do
      it "グループ新規作成ボタンを押すと、グループ新規作成画面に遷移する" do
        click_on "グループ新規作成"
        expect(current_path).to eq new_group_path
      end
      it "グループ名のリンクを押すと、グループ詳細画面に遷移する" do
        click_on group.name
        expect(current_path).to eq group_path(group)
      end
    end # context "リンクの確認"
  end # describe "グループ一覧画面のテスト"

  describe "グループ詳細画面のテスト" do
    before do
      visit group_path(group)
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/groups/#{group.id}"
      end
      it "グループリーダーのプロフィール画像が表示される" do
        within "#creater-#{group.creater_id}" do
          expect(page).to have_selector "img"
        end
      end
      it "グループリーダーが表示されている" do
        expect(page).to have_content "グループリーダー"
      end
      it "グループリーダーの氏名が表示されている" do
        expect(page).to have_link group.creater.full_name
      end
      it "グループリーダーの部署が表示されている" do
        expect(page).to have_content group.creater.department.name
      end
      it "グループ名が表示されている" do
        expect(page).to have_content group.name
      end
      it "グループ作成日が表示されている" do
        expect(page).to have_content "グループ作成日：#{group.created_at.strftime("%Y年%m月%d日")}"
      end
      it "グループ紹介/活動内容が表示されている" do
        expect(page).to have_content "グループ紹介/活動内容"
      end
      it "descriptionカラムの内容が表示されている" do
        expect(page).to have_content group.description
      end
      it "お知らせを作成するリンクが存在する" do
        expect(page).to have_link "お知らせを作成", href: new_group_notice_path(group_id: group.id)
      end
      it "グループを編集リンクが存在する" do
        expect(page).to have_link "グループを編集", href: edit_group_path(group)
      end
      it "グループを削除リンクが存在する" do
        expect(page).to have_link "グループを削除"
      end
      it "タブメニューにお知らせが表示されている" do
        expect(page).to have_field "お知らせ"
      end
      it "タブメニューにグループメンバーが表示されている" do
        expect(page).to have_field "グループメンバー"
      end
      it "タブメニューのうち、お知らせがチェックされている" do
        expect(page).to have_checked_field "お知らせ"
      end
      it "タブメニューのうち、お知らせがチェックされている時、 お知らせがない場合、お知らせはありませんが表示される" do
        expect(page).to have_content "お知らせはありません"
      end
      it "タブメニューのうち、グループメンバーがチェックされている時、 グループメンバーが表示される" do
        choose "グループメンバー"
        within "#employee-#{employee.id}" do
          expect(page).to have_content employee.full_name
        end
      end
    end # context "表示内容の確認"

    context "リンクの確認" do
      it "グループリーダーの氏名リンクを押すとグループリーダーの詳細画面に遷移する" do
        within "#creater-#{group.creater_id}" do
          click_on group.creater.full_name
          expect(current_path).to eq employee_path(id: group.creater_id)
        end
      end
      it "お知らせを作成リンクを押すと、お知らせ新規作成画面に遷移する" do
        click_on "お知らせを作成"
        expect(current_path).to eq new_group_notice_path(group)
      end
      it "グループを編集リンクを押すと、グループ編集画面に遷移する" do
        click_on "グループを編集"
        expect(current_path).to eq edit_group_path(group)
      end
    end # context "リンクの確認"

    context "グループ削除テスト" do
      it "グループを削除リンクからグループを削除できる" do
        expect { click_on "グループを削除" }.to change { Group.count }.by(-1)
      end
      it "グループを削除すると、グループ一覧画面に遷移する" do
        click_on "グループを削除"
        expect(current_path).to eq groups_path
      end
    end # context "グループ削除テスト"
  end # describe "グループ詳細画面のテスト"

  describe "グループ詳細画面のテスト: グループリーダー以外の場合" do
    let!(:other_group) { create(:group, creater_id: other_employee.id) }
    before do
      visit group_path(other_group)
    end
    context "表示内容の確認" do
      it "お知らせを作成するリンクが存在しない" do
        expect(page).to have_no_link "お知らせを作成", href: new_group_notice_path(group_id: other_group.id)
      end
      it "グループを編集リンクが存在しない" do
        expect(page).to have_no_link "グループを編集", href: edit_group_path(other_group)
      end
      it "グループを削除リンクが存在しない" do
        expect(page).to have_no_link "グループを削除"
      end
      it "参加ボタンが存在する: グループに参加していない場合" do
        expect(page).to have_link "参加"
      end
      it "退会ボタンが存在する: グループに参加している場合" do
        click_on "参加"
        visit current_path
        expect(page).to have_link "退会"
      end
    end # context "表示内容の確認"
  end # describe "グループ詳細画面のテスト: グループリーダー以外の場合"

  describe "グループ新規作成画面のテスト" do
    before do
      visit new_group_path
    end
    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/groups/new"
      end
      it "1.グループ名を入力してくださいが表示されている" do
        expect(page).to have_content "1.グループ名を入力してください"
      end
      it "2.活動内容や紹介文を入力してくださいが表示されている" do
        expect(page).to have_content "2.活動内容や紹介文を入力してください"
      end
      it "グループ名の入力フォームが存在する" do
        expect(page).to have_field "group[name]"
      end
      it "活動内容の入力フォームが存在する" do
        expect(page).to have_field "group[description]"
      end
      it "グループ作成ボタンが存在する" do
        expect(page).to have_button "グループ作成"
      end
    end # context "表示内容の確認"
    context "グループ新規作成テスト: 成功ケースのみ" do
      before do
        fill_in "group[name]", with: Faker::Lorem.characters(number: 10)
        fill_in "group[description]", with: Faker::Lorem.characters(number: 10)
      end
      it "グループ作成ボタンを押すと、グループを作成できる" do
        expect { click_on "グループ作成" }.to change { Group.count }.by(1)
      end
      it "グループを作成すると、グループ詳細画面に遷移する" do
        click_on "グループ作成"
        expect(current_path).to eq group_path(Group.find(2))
      end
    end # context "グループ新規作成テスト: 成功ケースのみ"
  end # describe "グループ新規作成画面のテスト"

  describe "グループ編集画面のテスト" do
    before do
      visit edit_group_path(group)
    end
    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/groups/#{group.id}/edit"
      end
      it "1.グループ名を入力してくださいが表示されている" do
        expect(page).to have_content "1.グループ名を入力してください"
      end
      it "2.活動内容や紹介文を入力してくださいが表示されている" do
        expect(page).to have_content "2.活動内容や紹介文を入力してください"
      end
      it "グループ名の入力フォームが存在する" do
        expect(page).to have_field "group[name]", with: group.name
      end
      it "活動内容の入力フォームが存在する" do
        expect(page).to have_field "group[description]", with: group.description
      end
      it "変更内容を保存ボタンが存在する" do
        expect(page).to have_button "変更内容を保存"
      end
    end # context "表示内容の確認"

    context "グループ編集成功テスト" do
      before do
        @old_group_name = group.name
        @old_group_description = group.description
        fill_in "group[name]", with: Faker::Lorem.characters(number: 10)
        fill_in "group[description]", with: Faker::Lorem.characters(number: 10)
        click_on "変更内容を保存"
      end
      it "グループの編集に成功すると、グループ詳細画面に遷移する" do
        expect(current_path).to eq group_path(group)
      end
      it "グループ名が編集されている" do
        expect(page).to have_no_content @old_group_name
      end
      it "グループの活動内容が編集されている" do
        expect(page).to have_no_content @old_group_description
      end
    end # context "グループ編集成功テスト"
  end # describe "グループ編集画面のテスト"

  describe "お知らせの新規作成画面のテスト" do
    before do
      visit new_group_notice_path(group)
    end
    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/groups/#{group.id}/notices/new"
      end
      it "1.件名を入力が表示されている" do
        expect(page).to have_content "1.件名を入力"
      end
      it "2.本文を入力が表示されている" do
        expect(page).to have_content "2.本文を入力"
      end
      it "件名入力フォームが存在する" do
        expect(page).to have_field "notice[title]"
      end
      it "本文入力フォームが存在する" do
        expect(page).to have_field "notice[body]"
      end
      it "送信ボタンが存在する" do
        expect(page).to have_button "送信"
      end
    end # context "表示内容の確認"
    context "お知らせの新規作成テスト: 成功ケースのみ" do
      before do
        visit new_group_notice_path(group)
        fill_in "notice[title]", with: "お知らせテスト"
        fill_in "notice[body]", with: "テスト本文"
      end
      it "送信ボタンを押すと、お知らせが作成される" do
        expect { click_on "送信" }.to change { Notice.count }.by(1)
      end
      it "お知らせを作成すると、お知らせ詳細画面に遷移する" do
        click_on "送信"
        expect(current_path).to eq group_notice_path(group_id: group.id, id: Notice.find_by(group_id: group))
      end
      it "お知らせを作成すると、グループ詳細画面にお知らせが追加される" do
        click_on "送信"
        visit group_path(group)
        expect(page).to have_link "お知らせテスト"
      end
    end # context "お知らせの新規作成テスト: 成功ケースのみ"
  end # describe "お知らせの新規作成画面のテスト"

  describe "お知らせ詳細画面のテスト" do
    let!(:notice) { Notice.create(group_id: group.id, title: "テスト", body: "テスト") }
    before do
      visit group_notice_path(group, notice)
    end
    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/groups/#{group.id}/notices/#{notice.id}"
      end
      it "お知らせの件名が表示されている" do
        expect(page).to have_content notice.title
      end
      it "お知らせの本文が表示されている" do
        expect(page).to have_content notice.body
      end
      it "戻るリンクが存在する" do
        expect(page).to have_link "戻る", href: group_path(group)
      end
      it "お知らせを削除リンクが存在する" do
        expect(page).to have_link "削除"
      end
    end # context "表示内容の確認"

    context "リンクの確認" do
      it "戻るリンクを押すとグループ詳細画面に遷移する" do
        click_on "戻る"
        expect(current_path).to eq group_path(group)
      end
      it "お知らせを削除リンクを押すと、お知らせが削除される" do
        expect { click_on "削除" }.to change { Notice.count }.by(-1)
      end
      it "お知らせを削除すると、グループ詳細画面に遷移する" do
        click_on "削除"
        expect(current_path).to eq group_path(group)
      end
    end
  end # describe "お知らせ詳細画面のテスト"

  describe "お知らせ詳細画面のテスト: グループリーダー以外の場合" do
    let!(:other_group) { create(:group, creater_id: other_employee.id) }
    let!(:other_group_notice) { Notice.create(group_id: other_group.id, title: "テスト", body: "テスト") }
    before do
      visit group_notice_path(other_group, other_group_notice)
    end

    context "表示内容の確認" do
      it "お知らせを削除リンクが存在しない" do
        expect(page).to have_no_link "削除"
      end
    end # context "表示内容の確認"
  end # describe "お知らせ詳細画面のテスト: グループリーダー以外の場合"
end # RSpec.describe "[STEP2]社員ログイン後のテスト"
