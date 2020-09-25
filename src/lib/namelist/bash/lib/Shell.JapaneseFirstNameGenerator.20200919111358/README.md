[ja](./README.ja.md)

# Shell.JapaneseFirstNameGenerator.20200919111358

Names other than Japanese surnames are randomly generated without duplication. Gender is also output.

# DEMO

```sh
$ jfn.sh
しげまさ	重誠	M
あさはる	朝晴	M
れんいちろう	錬一郎	M
しょうぞう	章三	M
かいま	貝真	M
あきたか	明謙	M
とうし	桃志	M
のりと	慰翔	M
あおや	青矢	M
てんが	天雅	M
せいたろう	誠多郎	M
ゆきよ	幸代	M
かいき	加衣貴	M
しんり	心琉	M
のりお	法男	M
うみの	うみの	F
てるこ	耀子	F
かなみ	佳並	F
あきね	諒寧	F
ゆあら	由明羅	F
ほづき	步月	F
すずほ	珠々帆	F
みきほ	美祈歩	F
りさ	鈴桜	F
ゆうあ	宥亜	F
ふきえ	富貴惠	F
きょうな	杏那	F
りい	莉惟	F
のこ	乃瑚	F
おとえ	音絵	F
```
```sh
$ time jfn.sh
...
real	0m1.421s
user	0m1.389s
sys	0m0.585s
```

# Features

* Output in `reading \n notation \n gender` format
* You can specify the number of outputs
* There is a subcommand to extract by specifying conditions

# Requirement

* <time datetime="2020-09-19T11:13:55+0900">2020-09-19</time>
* [Raspbierry Pi](https://ja.wikipedia.org/wiki/Raspberry_Pi) 4 Model B Rev 1.2
* [Raspbian](https://ja.wikipedia.org/wiki/Raspbian) buster 10.0 2019-09-26 <small>[setup](http://ytyaru.hatenablog.com/entry/2019/12/25/222222)</small>
* bash 5.0.3(1)-release

```sh
$ uname -a
Linux raspberrypi 4.19.97-v7l+ #1294 SMP Thu Jan 30 13:21:14 GMT 2020 armv7l GNU/Linux
```

# Installation

```sh
git clone https://github.com/ytyaru/Shell.JapaneseFirstNameGenerator.20200919111358
```

# Usage

```sh
cd Shell.JapaneseFirstNameGenerator.20200919111358/src
./jfn.sh
```

## Subcommand

Subcommands|Overview
-----------|--------
generate [-n NUM] [-s SEX] [-r RATE]|Randomly generate. (Default)
select value ... |Extract with ambiguous condition specification.
extract [-s SEX] [-fbperFBPER COND] ...|Extract with accurate conditions.

Display help and version.

```sh
./jfn.sh -h
./jfn.sh -v
```

### `generate`

Output the name randomly.

Arguments|Default values|Overview
---------|--------------|--------
`-n`|`30`|Number of outputs
`-s`|`*`|Gender. `m`,`f`,`c`,`mc`,`fc`,`cm`,`cf`, <br>`M`(`m`+`mc`+`cm`+`c` ),<br>`F`(`f`+`fc`+`cf`+`c`),<br>`C`(`c`+`cm`+`mc`+`cf`+`fc`),<br>`*`(`m`+`f`+`c`+`mc`+`fc`+`cm`+`cf`)<br>`c` is the gender of all cases Is randomly decided for either men or women.
`-r`|`E`|Percentage of output by gender. Valid only when `-n` is` * `. <br> `e` and` E` should have a male-female ratio of 1:1. When odd, add 1 `c`. <br> `e`(`m`+`f`+`c`), `E`(`M`+`F`+`C`)

```sh
./jfn.sh
./jfn.sh g
./jfn.sh g -n 5
./jfn.sh g -s m
./jfn.sh g -r e
./jfn.sh g -n 5 -r e
```

### `select`

Search by partial match from the "reading" and "notation" of the name.

```sh
./jfn.sh s 'あか'
./jfn.sh s '赤'
./jfn.sh s 'あか' '赤'
```

### `extract`

Search by specifying prefix match, suffix match, partial match, exact match, and regular expression for the "reading" and "notation" of the name.

Arguments|Default values|Overview
---------|--------------|--------
`-s`|`*`|Gender。`m`,`f`,`c`,`mc`,`fc`,`cm`,`cf`,<br>`M`(`m`+`mc`+`cm`+`c`),<br>`F`(`f`+`fc`+`cf`+`c`),<br>`C`(`c`+`cm`+`mc`+`cf`+`fc`),<br>`*`(`m`+`f`+`c`+`mc`+`fc`+`cm`+`cf`)
`-f`||Match prefix.
`-b`||End match.
`-p`||Partial match.
`-e`||Exact match.
`-r`||Regular expression.
`-F`||Prefix match (negation).
`-B`||End match (negative).
`-P`||Partial match (negative).
`-E`||Exact match (negation).
`-R`||Regular expression (negative).

```sh
./jfn.sh -f 'たろ'
./jfn.sh -b 'ろう'
./jfn.sh -p 'ろ'
./jfn.sh -e 'たろう'
./jfn.sh -r '.*(すけ|たろう|へい|べい|ぺい|へえ|べえ|ぺえ)$'
./jfn.sh -f '太'
./jfn.sh -b '郎'
./jfn.sh -p '々'
./jfn.sh -e '太郎'
./jfn.sh -r '^太.{1,}$'

./jfn.sh -F 'たろ'
./jfn.sh -B 'ろう'
./jfn.sh -P 'かさ'
./jfn.sh -E 'たろう'
./jfn.sh -R '.*(すけ|たろう|へい|べい|ぺい|へえ|べえ|ぺえ)$'
./jfn.sh -F '太'
./jfn.sh -B '郎'
./jfn.sh -P '々'
./jfn.sh -E '太郎'
./jfn.sh -R '^太.{1,}$'

./jfn.sh -f 'たろ' -B 'ろう'
./jfn.sh -f '太' -B '郎'
./jfn.sh -f 'たろ' -B 'ろう' -f '太' -B '郎'
```

# Note

## Bugs

* If the value of `-n` is set to` 2938` or more, an invalid line such as `-e F` will be output: [note](https://github.com/ytyaru/Shell.JapaneseFirstNameGenerator.20200919111358/blob/master/note/bug/1.md)

## Specification change

* Removed random gender ratio
    * Removed the value `r` of the argument` -r` of the subcommand `g` from the [previous version](https://github.com/ytyaru/Shell.JapaneseFirstNameGenerator.20200918080000): [note](https://github.com/ytyaru/Shell.JapaneseFirstNameGenerator.20200919111358/blob/master/note/change_spec/1.md)

# Author

ytyaru

* [![github](http://www.google.com/s2/favicons?domain=github.com)](https://github.com/ytyaru "github")
* [![hatena](http://www.google.com/s2/favicons?domain=www.hatena.ne.jp)](http://ytyaru.hatenablog.com/ytyaru "hatena")
* [![mastodon](http://www.google.com/s2/favicons?domain=mstdn.jp)](https://mstdn.jp/web/accounts/233143 "mastdon")

# License

This software is CC0 licensed.

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/deed.en)

