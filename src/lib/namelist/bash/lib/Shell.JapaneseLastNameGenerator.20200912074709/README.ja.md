[en](./README.md)

# Shell.JapaneseLastNameGenerator.20200912074709

　日本人の名字（苗字・氏・姓・家名）をランダム生成・指定抽出する。

# デモ

```sh
$ ./jln.sh
もとのみ	元呑
ながどおり	長通
おくだ	億田
いしとり	石鳥
いまはやし	今林
いひ	伊比
つゆさき	露崎
いえじま	家島
いどむら	井戸村
しげしま	重嶋
うおち	魚地
むつい	六井
みぞぞえ	溝添
くぐみや	久々宮
むらかく	村角
えのせ	榎瀬
まえつじ	前辻
さいはた	才畑
かいふ	海部
むかいはたけ	向畑
しおつ	潮津
みょうかわ	妙川
えなり	江成
ししど	宍戸
かみふくもと	上福元
えびかわ	海老川
とうべ	東部
うえうち	上内
ささぬき	笹貫
すえつ	末津
```

# 特徴

* 出力件数を指定できる
* 一度に出力される名字は重複しない
* 条件を指定して抽出できる

# 開発環境

* <time datetime="2020-09-12T07:46:22+0900">2020-09-12</time>
* [Raspbierry Pi](https://ja.wikipedia.org/wiki/Raspberry_Pi) 4 Model B Rev 1.2
* [Raspbian](https://ja.wikipedia.org/wiki/Raspbian) buster 10.0 2019-09-26 <small>[setup](http://ytyaru.hatenablog.com/entry/2019/12/25/222222)</small>
* bash 5.0.3(1)-release

```sh
$ uname -a
Linux raspberrypi 4.19.97-v7l+ #1294 SMP Thu Jan 30 13:21:14 GMT 2020 armv7l GNU/Linux
```

# インストール

```sh
git clone https://github.com/ytyaru/Shell.JapaneseLastNameGenerator.20200912074709
```

# 使い方

```sh
cd Shell.JapaneseLastNameGenerator.20200912074709/src
./jln.sh
```

* [help.txt](https://raw.githubusercontent.com/ytyaru/Shell.JapaneseLastNameGenerator.20200912074709/master/src/doc/help.txt)

## サブコマンド

サブコマンド|概要
------------|----
generator [-n NUM]|ランダム生成する。（デフォルト）
yomi 値|指定した「表記」の全「読み」を取得する。
kaki 値|指定した「読み」の全「表記」を取得する。
selector 値 ...|曖昧な条件指定で抽出する。
extractor [-fbperFBPER COND] ...|正確な条件指定で抽出する。

　ヘルプやバージョンを表示する。

```sh
./jln.sh -h
./jln.sh -v
```

　名字をランダムに出力する。

```sh
./jln.sh
./jln.sh g
./jln.sh g -n 5
```

　名字の「読み」や「表記」の全パターンを出力する。

```sh
./jln.sh y '𠮷越'
./jln.sh k 'あいうち'
```

　名字の「読み」や「表記」から部分一致で検索する。

```sh
./jln.sh s 'あか'
./jln.sh s '赤'
./jln.sh s 'あか' '赤'
```

　名字の「読み」や「表記」に対して、前方一致、後方一致、部分一致、完全一致、正規表現を指定して検索する。

```sh
./jln.sh e -f 'あか'
./jln.sh e -b 'さき'
./jln.sh e -p 'かさ'
./jln.sh e -e 'あかさき'
./jln.sh e -r '^あか[さざ]き$'
./jln.sh e -f '赤'
./jln.sh e -b '崎'
./jln.sh e -p '々'
./jln.sh e -e '佐々木'
./jln.sh e -r '^赤.{1,}$'

./jln.sh e -F 'あか'
./jln.sh e -B 'さき'
./jln.sh e -P 'かさ'
./jln.sh e -E 'あかさき'
./jln.sh e -R '^あか[さざ]き$'
./jln.sh e -F '赤'
./jln.sh e -B '崎'
./jln.sh e -P '々'
./jln.sh e -E '佐々木'
./jln.sh e -R '^赤.{1,}$'

  # 複数条件を指定するとAND
./jln.sh e -f 'あか' -B 'さき'
./jln.sh e -f '赤' -B '崎'
./jln.sh e -f 'あか' -B 'さき' -f '赤' -B '坂'```
```

# 注意

* [全件ランダム出力に3分以上かかる](https://github.com/ytyaru/Shell.JapaneseLastNameGenerator.20200912074709/blob/master/note/20200912134934_全件出力が遅い.md)

# 関連リポジトリ

* [Shell.LastNameGenerator.20200902095536](https://github.com/ytyaru/Shell.LastNameGenerator.20200902095536)
* [Shell.LastNameTsv.20200911141000](https://github.com/ytyaru/Shell.LastNameTsv.20200911141000)

# 著者

　ytyaru

* [![github](http://www.google.com/s2/favicons?domain=github.com)](https://github.com/ytyaru "github")
* [![hatena](http://www.google.com/s2/favicons?domain=www.hatena.ne.jp)](http://ytyaru.hatenablog.com/ytyaru "hatena")
* [![mastodon](http://www.google.com/s2/favicons?domain=mstdn.jp)](https://mstdn.jp/web/accounts/233143 "mastdon")

# ライセンス

　このソフトウェアはCC0ライセンスである。

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/deed.ja)

