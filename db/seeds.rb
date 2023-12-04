# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "seedを実行"
puts "departmentを作成"

departments = [
  { name: "営業部" },
  { name: "開発部" },
  { name: "人事部" },
  { name: "企画部" },
  { name: "総務部" },
  ]

departments.each { |department| Department.find_or_create_by!(name: department[:name]) }

password = "123456"
puts "employeeを作成"



Employee.find_or_create_by!( email: "tanaka@example.com" ) do |employee|
  employee.department_id = Department.find_or_create_by!(name: "営業部").id
  employee.last_name = "田中"
  employee.first_name = "太朗"
  employee.last_name_furigana = "タナカ"
  employee.first_name_furigana = "タロウ"
  employee.introduction = 
  "田中太郎です。よろしくお願いします。
  人と話をすることが好きです。たくさんの人とお話しできればと思っています！"
  employee.birthdate = "1996-04-01"
  employee.prefecture = "東京都"
  employee.password = password
  employee.is_active = true
  employee.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-employee1.jpg"), filename:"sample-employee1.jpg")
end

Employee.find_or_create_by!( email: "satou@example.com" ) do |employee|
  employee.department_id = Department.find_or_create_by!(name: "営業部").id
  employee.last_name = "佐藤"
  employee.first_name = "由美"
  employee.last_name_furigana = "サトウ"
  employee.first_name_furigana = "ユミ"
  employee.introduction = 
  "佐藤由美です。よろしくお願いします。
  猫が好きです。たくさんの人と猫の話をしたいです！"
  employee.birthdate = "1996-04-02"
  employee.prefecture = "京都府"
  employee.password = password
  employee.is_active = true
  employee.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-employee2.jpg"), filename:"sample-employee2.jpg")
end

Employee.find_or_create_by!( email: "yamada@example.com" ) do |employee|
  employee.department_id = Department.find_or_create_by!(name: "開発部").id
  employee.last_name = "山田"
  employee.first_name = "花子"
  employee.last_name_furigana = "ヤマダ"
  employee.first_name_furigana = "ハナコ"
  employee.introduction = 
  "山田花子と申します。よろしくお願いします。
  犬が大好きで、毎日の生活に欠かせません。
  趣味は犬の訓練や散歩で、新しいトリックを教えたり、可愛いポーズを覚えさせることが好きです。
  仕事では誠実さと協力精神を大切にし、チームとの連携を重視しています。
  皆さんと楽しいひとときを過ごせることを楽しみにしています！"
  employee.birthdate = "1998-04-03"
  employee.prefecture = "大阪府"
  employee.password = password
  employee.is_active = true
  employee.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-employee2.jpg"), filename:"sample-employee2.jpg")
end

Employee.find_or_create_by!( email: "suzuki@example.com" ) do |employee|
  employee.department_id = Department.find_or_create_by!(name: "開発部").id
  employee.last_name = "鈴木"
  employee.first_name = "美香"
  employee.last_name_furigana = "スズキ"
  employee.first_name_furigana = "ミカ"
  employee.introduction = 
  "鈴木美香と申します。よろしくお願いします。
  特に好きなのは自然の中での散歩です。新しい場所を発見することが好きで、週末には友達と一緒に山や公園に出かけます。自然の美しさからインスピレーションを得て、仕事にも活かしています。
  また、趣味で写真を撮ることもあり、季節ごとの風景や可愛い動物たちをキャッチするのが楽しみです。
  皆さんともっと自然を感じながら交流できることを楽しみにしています！"
  employee.birthdate = "1998-10-10"
  employee.prefecture = "奈良県"
  employee.password = password
  employee.is_active = true
  employee.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-employee2.jpg"), filename:"sample-employee2.jpg")
end

Employee.find_or_create_by!( email: "takahashi@example.com" ) do |employee|
  employee.department_id = Department.find_or_create_by!(name: "人事部").id
  employee.last_name = "高橋"
  employee.first_name = "一郎"
  employee.last_name_furigana = "タカハシ"
  employee.first_name_furigana = "イチロウ"
  employee.introduction = 
  "高橋一郎と言います。
  バイクが大好きで、週末には友達とツーリングに出かけることが楽しみです。新しい場所を訪れることで、さまざまな景色や文化に触れ、リフレッシュしています。
  仕事ではチームプレーヤーとして協力し、新しいアイデアにも常にオープンです。一緒に働けることを楽しみにしています！"
  employee.birthdate = "1980-11-12"
  employee.prefecture = "北海道"
  employee.password = password
  employee.is_active = true
  employee.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-employee1.jpg"), filename:"sample-employee1.jpg")
end

Employee.find_or_create_by!( email: "watanabe@example.com" ) do |employee|
  employee.department_id = Department.find_or_create_by!(name: "人事部").id
  employee.last_name = "渡辺"
  employee.first_name = "太一"
  employee.last_name_furigana = "ワタナベ"
  employee.first_name_furigana = "タイチ"
  employee.introduction = 
  "渡辺太一と言います。ゲームが大好きで、特にRPGやアクションゲームがお気に入りです。休日には友達とオンラインで協力プレイを楽しむこともあります。
  仕事ではチームの一員としてコミュニケーションを大切にし、クリエイティブなアプローチで問題に取り組みます。
  一緒に新しいプロジェクトに挑戦できることを楽しみにしています！"
  employee.birthdate = "1997-1-1"
  employee.prefecture = "島根県"
  employee.password = password
  employee.is_active = true
  employee.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-employee1.jpg"), filename:"sample-employee1.jpg")
end

Employee.find_or_create_by!( email: "shimizu@example.com" ) do |employee|
  employee.department_id = Department.find_or_create_by!(name: "企画部").id
  employee.last_name = "清水"
  employee.first_name = "由美子"
  employee.last_name_furigana = "シミズ"
  employee.first_name_furigana = "ユミコ"
  employee.introduction = 
  "私は清水由美子です。
  趣味は読書とお菓子作りで、特に小説やパン作りが好きです。
  仕事ではチームプレーヤーとして、協力とコミュニケーションを大切にしています。
  一緒に素敵なプロジェクトを進められることを楽しみにしています！"
  employee.birthdate = "1998-2-2"
  employee.prefecture = "鳥取県"
  employee.password = password
  employee.is_active = true
  employee.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-employee2.jpg"), filename:"sample-employee2.jpg")
end

Employee.find_or_create_by!( email: "kawanaka@example.com" ) do |employee|
  employee.department_id = Department.find_or_create_by!(name: "企画部").id
  employee.last_name = "川中"
  employee.first_name = "雄太"
  employee.last_name_furigana = "カワナカ"
  employee.first_name_furigana = "ユウタ"
  employee.introduction = 
  "こんにちは、川中雄太と言います。
  趣味はアウトドア活動で、週末には山登りやキャンプに出かけることがあります。
  仕事では新しいアイデアを提案し、チーム全体を刺激することに貢献したいと考えています。
  よろしくお願いします。"
  employee.birthdate = "1995-4-14"
  employee.prefecture = "香川県"
  employee.password = password
  employee.is_active = true
  employee.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-employee1.jpg"), filename:"sample-employee1.jpg")
end

Employee.find_or_create_by!( email: "nakamura@example.com" ) do |employee|
  employee.department_id = Department.find_or_create_by!(name: "総務部").id
  employee.last_name = "中村"
  employee.first_name = "美香"
  employee.last_name_furigana = "ナカムラ"
  employee.first_name_furigana = "ミカ"
  employee.introduction = 
  "中村美佳です。
  趣味は音楽鑑賞で、特にクラシックやジャズが好きです。
  仕事ではクリエイティブな解決策を見つけ、チームと協力してプロジェクトを成功に導くことが得意です。
  一緒に成長し、素敵なプロジェクトに参加できることを楽しみにしています！"
  employee.birthdate = "1996-5-6"
  employee.prefecture = "徳島県"
  employee.password = password
  employee.is_active = true
  employee.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-employee2.jpg"), filename:"sample-employee2.jpg")
end

Employee.find_or_create_by!( email: "kobayashi@example.com" ) do |employee|
  employee.department_id = Department.find_or_create_by!(name: "総務部").id
  employee.last_name = "小林"
  employee.first_name = "大輝"
  employee.last_name_furigana = "コバヤシ"
  employee.first_name_furigana = "ダイキ"
  employee.introduction = 
  "こんにちは、小林大輝と申します。
  趣味はスポーツで、特にサッカーとランニングが好きです。
  仕事では目標に向かって効果的に取り組み、チームと協力して成果を上げることに注力しています。
  一緒に仕事を楽しんで、成功に向かって進んでいきましょう!"
  employee.birthdate = "1994-7-8"
  employee.prefecture = "高知県"
  employee.password = password
  employee.is_active = true
  employee.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-employee1.jpg"), filename:"sample-employee1.jpg")
end

puts "adminを作成"

Admin.find_or_create_by!( email: "admin@example.com" ) do |admin|
  admin.email = "admin@example.com"
  admin.password = "#{ENV['ADMIN_PASSWORD']}"
end

puts "articleを作成"

article_date_published = [
  { title: "猫の話で盛り上がりました", 
    body: "先日、ランチタイムに同僚と一緒に庭のベンチで座っていると、不意に近くにいた野良猫がやってきました。同僚も猫好きとのことで、お互いの愛猫について熱く語り合いました。彼女の家には4匹もの可愛い猫がいるそうで、それぞれの特徴やエピソードについて聞くのがとても楽しかったです。特に、一匹の猫がおもちゃで遊ぶ姿勢が面白いとの話には笑いが絶えませんでした。
  今度は彼女の家で、猫たちとのほっこりする時間を共有できることを楽しみにしています。" 
  },
  { title: "飼っているネコが増えました！", 
    body: "最近、我が家に新しい仲間が加わりました！これで家の中はもっとにぎやかになりました。
  新入りのネコちゃんは非常に好奇心旺盛で、どんな小さなものにも興味津々。先住猫との初対面は戦慄の時刻でしたが、すぐに打ち解けて遊び始めました。飼い主冥利につきます。
  日々のネコたちとの楽しいエピソードをここに綴ります。" 
  },
  { title: "自分の好きな犬種について", 
    body: "私の好きな犬種はゴールデン・レトリバーです。その明るくて愛らしい性格に一目惚れし、我が家に迎え入れたのは数年前のことです。
  最初に出会った瞬間、その愛くるしい笑顔に心を奪われました。以来、一緒に過ごす時間は多くの幸せな瞬間で満ちています。特に、散歩での楽しいエピソードは数えきれないほど。
  四季折々の風景を眺めながらの散歩や、彼とのボール遊び、水辺でのひととき。これらの瞬間が私にとって癒しであり、喜びの源となっています。
  犬との生活は、日常の中に潜む小さな幸せを見つける手助けとなっています。彼の存在がもたらす癒しと喜びは計り知れません。
  皆さんもぜひ、愛犬との特別な瞬間を感じてみてください。" 
  },
  { title: "おすすめの散歩コースを教えます！", 
    body: "私が心からおすすめする散歩コースは、季節ごとに変わる美しい風景が楽しめるところです。四季折々の自然の美しさを感じながら、健康を保ちつつ心もリフレッシュできる場所ばかりです。
  春には桜が咲き誇る桜並木が広がり、花見客で賑わいます。桜の花びらが風に舞う光景はまさに圧巻。夏には緑豊かな公園での散歩がおすすめ。木々の緑と鳥のさえずりが癒しを提供してくれます。
  秋になると、周囲が紅葉に染まるスポットもあり、まるで絵画の中を歩いているかのような感覚。これらの場所での散歩は、自然の美と共に新たなエネルギーをもらえることでしょう。
  これからの季節、ぜひ皆さんも私のおすすめ散歩コースで自然の美を感じ、心地よい時間を過ごしてみてください。"
  },
  { title: "僕のバイクの話",
    body: "バイクとの出会いは、まるで運命のようでした。ある日、中古バイク店を訪れていると、そこに一台のバイクが目に留まりました。そのバイクは、黒を基調としたシンプルなデザインで、一目見て心惹かれました。
  購入を決断したその日から、新しい冒険が始まりました。最初のツーリングでは、知らない風景や道を駆け抜けることで、まるで新たな世界に足を踏み入れたかのような感覚に包まれました。風を切る快感やエンジンの轟音が、日常の喧騒を一掃してくれるかのようでした。
  友達とのバイク仲間との出会いも、この新たなライフスタイルの魅力の一部。ツーリング先での楽しいひと時や、困難を共に乗り越える絆は、何よりも尊い宝物となりました。
  バイクメンテナンスやカスタマイズは、愛車を自分好みに仕上げるための大切な作業。その過程で知識を深めることで、愛車との絆も一層深まりました。
  これからバイクに乗りたい方には、ぜひこの魅力を伝えたくなります。風を感じながら、自分だけの冒険に挑戦してみてください。
  バイクとの出会いが、新たな人生のスタートを切るきっかけになることを願っています。"
  },
  { title: "新しいゲーム機を買いました!",
    body: "最新のゲーム機を手に入れてワクワクしています！新しいゲーム機との出会いは、まるで未知の世界への扉を開く瞬間。その先に広がる冒険や感動を求めて、新作ソフトを手に入れました。
  最初のプレイでは、グラフィックの進化や新機能の楽しさに驚きと興奮が入り混じります。オンラインプレイでの連携や対戦も、新しい友達との出会いが期待できる面白さ。
  このゲーム機は、忙しい日常を忘れさせてくれる心のオアシス。おすすめのソフトやアクセサリーなども紹介しながら、ゲーム愛好者やこれから新しいゲームを始めたい方に役立つ情報をお届けします。
  一緒にゲームの世界に浸り、新たな冒険に挑戦しましょう！"
  },
  { title: "資料作成のコツ！",
    body: "資料作成は、仕事やプロジェクトにおいて不可欠なスキルの一つです。しかし、ただ情報を詰め込むだけでは伝わりにくく、効果的な資料に仕上げるためにはいくつかのコツがあります。ここでは、プロの資料作成者が実践しているテクニックを紹介します。
  ---
  1. 目的を明確に設定する
  資料作成の最初にして最も重要なステップは、目的をはっきりさせることです。何を伝えたいのか、読者にどんな印象を残したいのかを考え、それに基づいて情報を整理しましょう。
  ---
  2. ターゲットオーディエンスを把握する
  資料の対象読者が誰なのかを理解することは至上のポイントです。読者の知識や関心に合わせて情報を選別し、適切な表現や用語を使います。
  ---
  3. 論理的な構造を考える
  資料は論理的な構造があることで読み手が理解しやすくなります。導入、本編、結論の流れを作り、それぞれのセクションでつながりを確保しましょう。
  ---
  4. 重要な情報に焦点を当てる
  情報が多すぎると逆に混乱を招きます。余計な情報を排除し、本質的なポイントに焦点を当てることが必要です。
  ---
  5. 視覚的な要素を活用する
  グラフ、図、表などの視覚的な要素を使うことで、情報の理解が助けられます。ただし、適度な使用が重要です。
  ---
  6. 分かりやすい表現を心がける
  専門用語や難解な表現は避け、できるだけ分かりやすい表現を心がけましょう。冗長な表現や複雑な文を避けることも大切です。
  ---
  7. プレゼンテーションに合わせて作成
  資料は単体で読まれるだけでなく、プレゼンテーション資料としても利用されることがあります。口頭での説明をサポートする要素を取り入れましょう。
  ---
  これらのコツを意識して、次回の資料作成に挑戦してみてください。伝えたいメッセージがクリアになり、読者に確実に伝わることでしょう。成功を祈っています！"
  },
  { title: "スケジュール管理におすすめのアプリ！",
    body: "現代の忙しい生活では、効率的なスケジュール管理が不可欠です。その中で頼りになるのが、スマートフォンやタブレットを活用したスケジュール管理アプリです。ここでは、おすすめのアプリとその特徴について紹介します。
  最初に挙げたいのは「Todoist」です。Todoistはシンプルで直感的なデザインが特徴で、タスクの追加や期限の設定が簡単に行えます。プロジェクトごとにタスクを整理し、重要な日付にアラートを設定することができ、日々の予定を見やすく管理できます。
  次におすすめなのが「Google カレンダー」です。Google カレンダーはシンクロ機能が充実しており、スマートフォン、パソコン、タブレットなど複数のデバイスで同じスケジュールを共有できます。また、通勤時間や会議のリマインダー、重要な日の自動表示など、便利な機能が満載です。
  さらに、「Any.do」もおすすめのアプリの一つです。Any.doはシンプルで使いやすいだけでなく、音声でのタスクの追加やスケジュールの作成が可能な点が特徴的です。特に、忙しいビジネスパーソンにとって、スムーズな操作が重要ですが、Any.doはその点において優れています。
  これらのアプリはそれぞれ特有の特徴を持っており、利用者の好みやライフスタイルによって選び方も異なります。
  スケジュール管理アプリは、自分の使いやすさや必要な機能に合わせて選ぶことが大切です。
  ぜひいくつか試してみて、自分に最適なアプリを見つけてみてください。
  時間の管理がより効果的になり、ストレスなくスケジュールをこなす手助けになることでしょう。"
  },
  { title: "今日の失敗談", 
    body: "人は誰でも失敗するもの。今日も私は、些細ながらもちょっとしたハプニングに見舞われました。この出来事を通して得た気づきや学びを、率直にお伝えします。
  朝、仕事に向かう準備を整える中での出来事。普段使っているはずの鍵がどこにあるのか分からず、焦りながら家中を探し回りました。思い出すには、前日の帰宅時に急いでいていい加減に置いてしまったことが原因でした。
  鍵を見つけて外に出たものの、電車の遅延や混雑などもあり、予定よりも遅れて会社に到着。仕事がスタートする前から、既に失敗という気分が漂っていました。これにはちょっとしたストレスもついてまわりますよね。
  そんな中、同僚との打ち合わせでは、前日のプロジェクトの進捗報告が求められていました。しかし、急いでいたこともあり、データを整理し忘れ、スライドの一部が未完成だったことに気づきました。プレゼン前に発覚したこのミス。焦りと申し訳なさの入り混じった気持ちで報告を行いました。
  この一連の出来事から気づいたのは、計画性と余裕の大切さです。鍵の置き場所や予定の確認、プロジェクトの進捗管理など、これらは計画を立て、余裕をもって行動することで防げることでした。忙しさに追われる中でも、冷静な判断と計画性を持ち、余裕をもって行動することが重要だと痛感しました。
  失敗はただのミスではなく、学びと成長の機会でもあります。
  今日の出来事を通して、日々の生活や仕事において、計画性や余裕を持つことの重要性を改めて実感しました。
  これからも失敗を恐れず、前向きに受け止め、成長につなげていきたいと思います。"
  },
  { title: "最近良かったこと",
    body: "最近、何気ない日常の中で嬉しいことがありました。この小さな幸せが私の心を温かく包んでくれ、日々の喧騒から一瞬解放されることができました。
  先日、友達との再会がありました。長らく会っていなかった友人たちと、久しぶりに顔を合わせ、笑い声や懐かしい話に包まれるひととき。彼らの存在は、忙しい日々の中で忘れかけていた温かな絆を思い起こさせてくれました。
  その日は晴れていて、カフェでゆっくりと過ごすことができました。美味しいコーヒーの香りや、気の置けない友達との談笑。何気ない風景や日常の中にこそ、幸せが隠れていることに気づかされました。
  また、最近始めた趣味が新しい喜びをもたらしています。日々の仕事や責任に追われがちな中、その時間は自分だけのもの。好きなことに没頭することで、心のリフレッシュが図れ、新たなエネルギーを感じています。
  そして、仕事での小さな成功もありました。一生懸命取り組んだプロジェクトが評価され、チームと共に達成感を分かち合う瞬間。努力が実り、成果が出たことで、やりがいを感じることができました。
  これらの小さな幸せが、私にポジティブなエネルギーを与えてくれています。何気ない日常の中で感じる喜びや成就感は、大きな幸せにつながっていくのだと実感しています。
  日々の喜びを見つけ、感謝の気持ちを忘れずに過ごしていくことが、より豊かな人生に繋がるのかもしれません。"
  }
]

article_date_private = [
  { title: "非公開記事", 
    body: "非公開用の記事です"
  }
  ]

10.times do |n|
  article_date_published.each do |date|
    Article.find_or_create_by!(title: "#{date[:title]}#{n + 1}", employee_id: n + 1) do |article|
      article.body = date[:body]
      article.is_published = true
    end
  end
end

10.times do |n|
  article_date_private.each do |date|
    Article.find_or_create_by!(title: "#{date[:title]}#{n + 1}", employee_id: n + 1) do |article|
      article.body = date[:body]
      article.is_published = false
    end
  end
end


puts "タグを作成"

tags = [
  { name: "猫"},
  { name: "家族"},
  { name: "犬"},
  { name: "散歩"},
  { name: "バイク"},
  { name: "ゲーム"},
  { name: "資料作成"},
  { name: "スケジュール管理"},
  { name: "失敗談"},
  { name: "良い話"},
  { name: "非公開"},
  ]
  
tags.each { |tag| Tag.find_or_create_by!(name: tag[:name]) }

puts "記事にタグ付け"

100.times { |n| ArticleTag.find_or_create_by!(article_id: "#{n + 1}", tag_id: "#{n % 10 + 1}") }

puts "コメントを作成"


text1 = "記事に関してのコメントを書きます"
text2 =  "感想や質問などを書くようにしましょう"

100.times { |n| Comment.find_or_create_by!(article_id: "#{n + 1}", employee_id: Employee.find_by(last_name: "田中").id, comment: text1) }
100.times { |n| Comment.find_or_create_by!(article_id: "#{n + 1}", employee_id: Employee.find_by(last_name: "佐藤").id, comment: text2) }

puts "groupを作成"

group_record = [
  { creater_id: Employee.find_by(last_name: "田中").id, 
    name: "色々なジャンルの勉強会をしましょう！", 
    description: "グループの主旨: さまざまなジャンルに興味を持つメンバーが集まり、共に学び合う場です。
活動内容: 定期的な勉強会やディスカッション、質問・回答セッションなど、様々な形式で知識の共有を行います。
活動頻度: 月に一度のペースでイベントを開催し、参加者同士の交流を深めます。",
  },
  { creater_id: Employee.find_by(last_name: "佐藤").id,
    name: "猫について話しましょう！",
    description: "グループの主旨: 猫好きが集まり、猫に関する情報やエピソードを共有するコミュニティです。
活動内容: 猫の飼い方や面白いエピソード、健康管理などに関するトピックでのディスカッションや情報交換を行います。
活動頻度: 月に２回、オンラインまたはオフラインでミーティングを開催し、メンバー同士が親睦を深めます。",
  },
  { creater_id: Employee.find_by(last_name: "山田").id,
    name: "犬について話しましょう！",
    description: "グループの主旨: 犬好きが集まり、犬に関する情報や経験を分かち合うコミュニティです。
活動内容: 犬のトレーニング方法や健康管理、可愛いエピソードについてのトークセッションや写真共有を行います。
活動頻度: 月に１回、リラックスした雰囲気で情報交換と交流を楽しむミーティングを開催します。",
  },
  { creater_id: Employee.find_by(last_name: "鈴木").id,
    name: "お昼休みに一緒に散歩する仲間募集！",
    description: "グループの主旨: お昼休みに散歩を楽しむ仲間を募集し、健康促進とリフレッシュを図るグループです。
活動内容: 毎週火曜日と木曜日のお昼休みに、周辺の公園や景色の良いエリアで散歩を行います。
活動頻度: 毎週２回、リーダーがコースを提案し、メンバー同士が気軽に参加できる散歩を実施します。",
  },
  { creater_id: Employee.find_by(last_name: "田中").id,
    name: "バイクについて話しましょう！",
    description: "グループの主旨: バイク愛好者が集まり、バイクに関する情報や体験を共有するコミュニティです。
活動内容: ツーリング計画やおすすめのバイクギアについての情報交換、バイクメンテナンスのノウハウを共有します。
活動頻度: 月に１回、オンラインでのミーティングや季節によるツーリングイベントを開催し、メンバー同士が親睦を深めます。",
  }
]

group_record.each { |record| Group.find_or_create_by!(creater_id: record[:creater_id], name: record[:name], description: record[:description]) } 


puts "グループメンバーを作成"

10.times { |n| GroupMember.find_or_create_by!( group_id: "#{n % 5 + 1}", employee_id: "#{n + 1}" ) }

puts "お知らせを作成"

notice_record = [
  { group_id: Group.find_by(name: "色々なジャンルの勉強会をしましょう！").id,
    title: "次回勉強会のお知らせ！",
    body: "次回の勉強会詳細:
日時: [日付と時間]
場所: [場所]
テーマ: [勉強会のテーマ]
この勉強会では、みんなで一緒に学び合いましょう！ディスカッションや質問・回答セッションも行いますので、気軽に参加してください。
注意事項:
イベントの変更がある場合は再度お知らせします。
次回の勉強会で皆さんにお会いできることを楽しみにしています！",
  },
  { group_id: Group.find_by(name: "猫について話しましょう！").id,
    title: "次回のグループ活動について!",
    body: "次回の活動詳細:
日時: [日付と時間]
場所: [場所]
活動内容:
猫の飼い方や面白いエピソード、健康管理などに関するトピックでのディスカッションや情報交換を行います。
皆さんの猫との素敵なエピソードもお待ちしています！
注意事項:
イベントの変更がある場合は再度お知らせします。
次回の活動で、新しい猫仲間との出会いや素敵な情報交換ができることを楽しみにしています。
みなさんにお会いできることを心待ちにしています！",
  },
  { group_id: Group.find_by(name: "犬について話しましょう！").id,
    title: "次回のグループ活動について!",
    body: "*次回の活動詳細:
日時: [日付と時間]
場所: [場所]
活動内容:
犬のトレーニング方法や健康管理、可愛いエピソードについてのトークセッションや写真共有を行います。みんなで犬にまつわる素敵な情報を交換しましょう！
注意事項:
参加希望の方はこのお知らせに返信してください。
イベントの変更がある場合は再度お知らせします。
次回の活動で、新しい犬友との出会いや素敵な情報交換ができることを楽しみにしています。みなさんにお会いできることを心待ちにしています！",
  },
  { group_id: Group.find_by(name: "お昼休みに一緒に散歩する仲間募集！").id,
    title: "次回の散歩コースについて!",
    body: "次回の散歩コース詳細:
日時: [日付と時間]
場所: [散歩のスタート地点]
活動内容:
毎週火曜日と木曜日のお昼休みに、周辺の公園や景色の良いエリアで散歩を行います。
リーダーが新しいコースを提案しますので、みなさんも楽しみにしていてください！
注意事項:
イベントの変更がある場合は再度お知らせします。
次回の散歩コースで、新しい発見や気分転換を一緒に楽しみましょう！",
  },
  { group_id: Group.find_by(name: "バイクについて話しましょう！").id,
    title: "次回のツーリングについて！",
    body: "次回ツーリング詳細情報:
日時: [日付と時間]
出発地点: [出発地点]
目的地: [ツーリングの目的地]
ツーリングルート: [予定されるツーリングコース]
特記事項: [その他の注意事項や特筆すべき情報]
注意事項:
参加希望の方はこのお知らせに返信してください。
イベントの変更がある場合は再度お知らせします。
次回のツーリングで、新しい景色とメンバーとの出会いを楽しんでください！",
  },
]

notice_record.each { |record| Notice.find_or_create_by!(group_id: record[:group_id], title: record[:title], body: record[:body]) } 

puts "seedを終了"
