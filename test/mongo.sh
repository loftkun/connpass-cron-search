#! /bin/sh
set -eu

CONTAINER=connpasscronsearch_store_1

USER=root
PASS=example
HOST=store
DB=connpass

# count all evnets
# mongo --eval "db.${DB}.find().count();" admin -u ${USER} -p ${PASS} --host ${HOST} --quiet

# search all event_id
# mongo --eval "db.${DB}.find().forEach(function(e){ print(e.event_id); });" admin -u ${USER} -p ${PASS} --host ${HOST} --quiet

# search one event
# mongo --eval "db.${DB}.find({event_id:135117});" admin -u ${USER} -p ${PASS} --host ${HOST} --quiet

# drop collection
# mongo --eval "db.${DB}.drop();" admin -u ${USER} -p ${PASS} --host ${HOST} --quiet


exec() {
    echo "exec > ${1}"
    sudo docker exec -it ${CONTAINER} sh -c "echo \"${1}\" | mongo admin -u ${USER} -p ${PASS} --host ${HOST} --quiet"
}

exec "show dbs"
exec "show collections"

# sudo docker exec -it ${CONTAINER} mongo admin -u ${USER} -p ${PASS} --host ${HOST} --quiet
# > db.connpass.drop()
# > db.connpass.find()
# > db.connpass.insert({"event_url":"https://dllab.connpass.com/event/141296/","event_type":"participation","owner_nickname":"TakutoHiguchi","series":{"url":"https://dllab.connpass.com/","id":3924,"title":"DEEP LEARNING LAB"},"updated_at":"2019-07-31T11:33:19+09:00","lat":"33.594817000000","started_at":"2019-08-20T18:30:00+09:00","hash_tag":"dllab","title":"みんなでAIアプリを作ってAzure AI Hackathon入賞を目指す会 @ 福岡","event_id":141296,"lon":"130.406833700000","waiting":0,"limit":45,"owner_id":256635,"owner_display_name":"TakutoHiguchi","description":"<h2>Deep Learning Lab（DLLAB）について</h2>\n<p>Deep Learning Labとは、Chainerを提供するPreferred Networksと、Azureクラウドを提供するMicrosoft による、深層学習に関する「最新技術をビジネスで活用している事例」や「最新の技術動向」を共有することで、深層学習技術者の裾野を広げ、実社会での利用拡大を図ることを目的としたコミュニティです。</p>\n<p>コミュニティご紹介資料は<a href=\"https://1drv.ms/b/s!ApdnOiBtVi9VlNoNnkNLWr9Oe89wAw\" rel=\"nofollow\">こちら</a>です。</p>\n<h2>みんなでAIアプリを作ってAzure AI Hackathon入賞を目指す会</h2>\n<p>Deep Learning Labは世の中で機械学習・深層学習を実装する人を徹底的に支援していきます。そのために2周年イベントでコンテストを行うことを発表しておりましたが、その第1弾の企画として、Azure AI Hackathon入賞を目指す企画を行います。AIを使ったサービス開発にチャレンジしたい皆様のご参加お待ちしております。</p>\n<h2>Microsoft Azure AI Hackathon って何⁈</h2>\n<ul>\n<li>マイクロソフトが主催する世界中のエンジニアを対象としたコンテストです!</li>\n<li>Azure Machine Learning, Cognitive Services, Azrue Searchの少なくとも1つを使ったソフトウェアを構築することが求められます。</li>\n<li>AIアプリ、チャットボット、MLモデルなど、Azure AIが使われていればどんなサービス・アプリでもOKです！</li>\n<li>アイディアの質、アイディアの実装、市場に対する影響力の3つで審査員が評価を行います。</li>\n<li>9/10(US東部時間)が締切です</li>\n<li>グローバルで1位になられた場合、なんと賞金は10,000$(約100万円) ！さらに、$1,500のAzure Creditを取得できます！グローバルの賞以外に、日本賞も用意する予定！</li>\n</ul>\n<p><a href=\"https://azureai.devpost.com/\" rel=\"nofollow\">こちらのWebsite</a>をご覧ください。<a href=\"https://azureai.devpost.com/rules\" rel=\"nofollow\">コンテストのルールはこちらです。</a></p>\n<h2>参加対象者 &amp; 当日は案をプレゼンして、チームを組む会です</h2>\n<p>当日はAIアプリ案をプレゼンテーションした後に皆で投票し、投票が多かった案を推進するためのチームを組む会です。下記のような人の参加を期待しております。</p>\n<ul>\n<li>機械学習得意な人</li>\n<li>バックエンドが得意な人</li>\n<li>フロントエンドが得意な人</li>\n<li>作りたいAIアプリの企画案がある人</li>\n</ul>\n<h2>当日までに必要な準備</h2>\n<ul>\n<li>企画案をスライド数枚にまとめてください。プレゼンテーション時間は2分です。（課題、作りたいアプリ、簡単なアーキテクチャ図など）</li>\n<li>スライドをSlideshareなどにあげて、この<a href=\"https://forms.office.com/Pages/ResponsePage.aspx?id=v4j5cvGGr0GRqy180BHbR5BOahkghxJEv3vuR8U0SjBUNVVMTUxKNUszUEhCVTRWVE9JMkYxNjE4OS4u\" rel=\"nofollow\">フォーム</a>に、発表者名、発表題名、URLをまとめて記載して、送信してください</li>\n</ul>\n<h2>イベント概要</h2>\n<table>\n<thead>\n<tr>\n<th>開始</th>\n<th>終了</th>\n<th>アジェンダ</th>\n<th>演者</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td>18:00</td>\n<td>18:30</td>\n<td>受付</td>\n<td></td>\n</tr>\n<tr>\n<td>18:30</td>\n<td>18:45</td>\n<td>Azure AI Hackathonの説明</td>\n<td>マイクロソフト横井さん、各都市オーガナイザー</td>\n</tr>\n<tr>\n<td>18:45</td>\n<td>19:25</td>\n<td>AIアプリ企画案の発表</td>\n<td>1人2分で参加者全員の企画案を説明します</td>\n</tr>\n<tr>\n<td>19:25</td>\n<td>19:35</td>\n<td>投票タイム</td>\n<td>1人3票で投票を行います</td>\n</tr>\n<tr>\n<td>19:35</td>\n<td>19:50</td>\n<td>上位チーム発表とチーム組成</td>\n<td></td>\n</tr>\n<tr>\n<td>19:50</td>\n<td>20:50</td>\n<td>懇親会</td>\n<td>チームの仲を深めましょう</td>\n</tr>\n</tbody>\n</table>\n<p>※会費は、軽食・飲み物代に充てさせていただきます。<br>\n※代金の徴収は、イベント運営を行う株式会社中外が代行いたします。</p>\n<h2>今後の流れ</h2>\n<ul>\n<li>9/10まであまり時間がありませんが、各地のオーガナイザー中心に集まる会を行います。マイクロソフト技術チームもそれを支援します</li>\n</ul>\n<h4>※本イベントで収集された個人情報の取り扱いについて</h4>\n<p>日本マイクロソフト株式会社の個人情報保護方針に準拠して取り扱います。\n<a href=\"https://www.microsoft.com/ja-jp/mscorp/privacy/default.aspx\" rel=\"nofollow\">https://www.microsoft.com/ja-jp/mscorp/privacy/default.aspx</a></p>","address":"福岡県福岡市博多区上川端町 12-20 ふくぎん博多ビル10 F","catch":"AIを使ったサービス開発にチャレンジしたい皆様のご参加お待ちしております。","accepted":0,"ended_at":"2019-08-20T21:00:00+09:00","place":"日本マイクロソフト株式会社"})
# > db.connpass.find()
