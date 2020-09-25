[ja](./README.ja.md)

# Shell.JapaneseLastNameGenerator.20200912074709

Randomly generate Japanese surnames.

# DEMO

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

# Features

* You can specify the number of outputs
* The surnames output at one time do not overlap
* Can be extracted by specifying conditions

# Requirement

* <time datetime="2020-09-12T07:46:22+0900">2020-09-12</time>
* [Raspbierry Pi](https://ja.wikipedia.org/wiki/Raspberry_Pi) 4 Model B Rev 1.2
* [Raspbian](https://ja.wikipedia.org/wiki/Raspbian) buster 10.0 2019-09-26 <small>[setup](http://ytyaru.hatenablog.com/entry/2019/12/25/222222)</small>
* bash 5.0.3(1)-release

```sh
$ uname -a
Linux raspberrypi 4.19.97-v7l+ #1294 SMP Thu Jan 30 13:21:14 GMT 2020 armv7l GNU/Linux
```

# Installation

```sh
git clone https://github.com/ytyaru/Shell.JapaneseLastNameGenerator.20200912074709
```

# Usage

```sh
cd Shell.JapaneseLastNameGenerator.20200912074709/src
./jln.sh
```

* [help.txt](https://raw.githubusercontent.com/ytyaru/Shell.JapaneseLastNameGenerator.20200912074709/master/src/doc/help.txt)

## Sub commands

Subcommands|Overview
-----------|--------
`generator [-n NUM]`|Randomly generated. (Default)
`yomi 値`|Gets all "readings" of the specified "notation".
`kaki 値`|Gets all "notations" of the specified "reading".
`selector 値 ...`|Extract with ambiguous condition specification.
`extractor [-fbperFBPER COND] ...`|Extract with accurate conditions.

Display help and version.

```sh
./jln.sh -h
./jln.sh -v
```

Randomly output surnames.

```sh
./jln.sh
./jln.sh g
./jln.sh g -n 5
```

Outputs all patterns of "reading" and "notation" of surnames.

```sh
./jln.sh y '𠮷越'
./jln.sh k 'あいうち'
```

Search by partial match from the surname "reading" or "notation".

```sh
./jln.sh s 'あか'
./jln.sh s '赤'
./jln.sh s 'あか' '赤'
```

Search by specifying prefix match, suffix match, partial match, exact match, and regular expression for the "reading" and "notation" of the surname.

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

# Note

* [Random output of all records takes 3 minutes or more](https://github.com/ytyaru/Shell.JapaneseLastNameGenerator.20200912074709/blob/master/note/20200912134934_全件出力が遅い.md)

# Related repositories

* [Shell.LastNameGenerator.20200902095536](https://github.com/ytyaru/Shell.LastNameGenerator.20200902095536)
* [Shell.LastNameTsv.20200911141000](https://github.com/ytyaru/Shell.LastNameTsv.20200911141000)

# Author

ytyaru

* [![github](http://www.google.com/s2/favicons?domain=github.com)](https://github.com/ytyaru "github")
* [![hatena](http://www.google.com/s2/favicons?domain=www.hatena.ne.jp)](http://ytyaru.hatenablog.com/ytyaru "hatena")
* [![mastodon](http://www.google.com/s2/favicons?domain=mstdn.jp)](https://mstdn.jp/web/accounts/233143 "mastdon")

# License

This software is CC0 licensed.

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/deed.en)

