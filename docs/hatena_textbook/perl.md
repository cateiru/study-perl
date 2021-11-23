# Perl

link: [Perl によるプログラミングの基礎](https://github.com/cateiru/Hatena-Textbook/blob/master/foundation-of-programming-perl.md)

## `strict`, `warnings`

```perl
use strict;
use warnings;
```

[別解説](https://www.javadrive.jp/perl/ini/index4.html)

- `strict`
  - 文法を厳密にする。
  - JSでいうstrict mode
- `warnings`
  - より詳細な警告を出力
  - 例: [warnings.pl](../../src/warnings.pl)
    - printがnumではなくnunになっている
    - `use warnings`をつけないとなにも警告は出ない

## 文字コードの扱い

```perl
use utf8;
```

- Perlはデフォルトでマルチバイト文字をバイト列とみなす
  - lengthで長さを出力するときにおかしくなる
- →`use utf8;`を使用して明示する必要がある

```perl
$text = 'ほげ';
print length $text;
# ==> 6

use utf8;
$text2 = 'ほげ';
print length $text2;
# ==> 2
```

### エンコード

- Perlの世界の外に出ようとすると再びバイト列に変換してあげないと行けない

```perl
use utf8;
use Encode;

print encode_utf8 'ほげ';
```

[Perl/日本語処理](https://ja.wikibooks.org/wiki/Perl/%E6%97%A5%E6%9C%AC%E8%AA%9E%E5%87%A6%E7%90%86)

## データ型

### スカラ

- 1つの値
  - 文字列
  - 変数
  - リファレンス
- `$`: $calarと覚える

```perl
my $scalar1 = 'test';
my $scalar2 = 1000;
my $scalar3 = \@array;
```

### 配列

- `@`: @rrayと覚える

```perl
my @array = ('a', 'b', 'c');
```

#### 配列の操作

```perl
print $array[0]; # 取得した値がスカラなら$がつく→ $(array[b])みないなイメージ。記号は型とイメージする？

$array[0]; # get
$array[1] = 'hoge'; # set

my $length = scalar @array; # 長さ scalarは明示するものであるため、なくても動く
my $list_ids = $#array; # 最後の添字

my @slice = @array[1..4] # スライス

for my $e (@array) {
    print $e;
}
```

### ハッシュ

- `%`: %ashと覚える

```perl
my %hash = (
    perl => 'larry',
    ruby => 'matz',
)

print $hash{perl}; # 取得するvalueはスカラであるため$
print $hash{ruby};
```

#### ハッシュの操作

```perl
$hash{perl}; # get
$hash{perl} = 'larry'; # set

for (keys %hash) { # 全要素のkeyをforで回す
    my $value = $hash{$_}; # keyをインデックスとしてvalueを取得
}
```

## コンテキスト

```perl
my @x = (0, 1, 2);

my ($ans1) = @x; # 0
my $ans2 = @x; # 3
```

## ハマりポインt

### データ構造

```perl
my @matrix = (
    (0, 1, 2, 3),
    (4, 5, 6, 7)
);

# => (0, 1, 2, 3, 4, 5, 6, 7)
```

```perl
my %entry = (
    body => 'hello!',
    comments => ('good', 'bad', 'hey');
);

# => ('body' => 'hello!', 'comments' => 'good', 'bad' => 'hey')
# ()の中はリストコンテキスト
# リストコンテキスト内ではリストは展開される
```

## リファレンス

- 要はポインタ
- スカラの中にアドレスが入る

### 取得/作成

- 配列

  ```perl
  my @x = (1, 2, 3);
  my $ref_x1 = \@x; # @で配列のxを取り出し\でポインタに変換

  # 略記法
  my $ref_x2 = [1, 2, 3]; # 角括弧[] でポインタを簡単に作れる

  # 組み合わせ
  my $ref_x3 = [@x];
  ```

- ハッシュ

  ```perl
  my %y = (
      perl => 'larry',
      ruby => 'matz',
  );
  my $ref_y1 = \%y;

  # 略記法: 波括弧{}でポインタを簡単に作れる
  my ref_2 = {
      perl => 'larry',
      ruby => 'matz',
  };
  ```

### デリファレンス

- 配列

  ```perl
  my $ref_x = [1, 2, 3];

  my @x = map {$_ * 2} @$ref_x;

  print $ref_x->[0];

  my @new_x = @$ref_x; # ref_xはアドレスが入っているので$でスカラとして取り出してから@で入れつにしている
  print $new_x[0];
  ```

- ハッシュ

  ```perl
  my $ref_y = (
      perl => 'larry',
      ruby => 'matz',
  );

  my @keys = keys %$ref_y;

  print $ref_y->{perl}; # `->`で取り出せる

  my %new_f = %$ref_y;
  print $new_F{perl};
  ```

#### 複雑なデリファレンス

```perl
my $result = [
    map {
        $_->{bar};
    }
    @{ $foo->return_array_ref }
]
```

### リファレンスを使用したデータ構造

```perl
my $matrix = [
    [0, 1, 2, 3],
    [4, 5, 6, 7],
];

my $entry = {
    body => 'hello!',
    comments => ['good', 'bad', 'hay'],
};
```

## パッケージ

```perl
package Hoge;

our $PACKAGE_VAL = 10;
# $HOGE::PACKAGE_VAL で値を取得できる
# javaでいうstatic method

sub fuga {
    ...
}
# Hoge::fuga();で取得できる
```

### モジュールロードの仕組み

```perl
use My::File;
# => My/File.pmがロードされる
```

- `@NIC`に設定されたパスを検索

  ```perl
  use lib 'path/to/your/lib';
  ```

## サブルーチン

```perl
&hello() # 定義前に括弧なしでよぶには`&`がいる

sub hello {
    my ($name) = @_;
    return "Hello, $name";
}

hello();
hello; # 定義後であれば括弧は省略可能
```

### 引数処理イディオム

```perl
sub func1 {
    my ($arg1, $arg2, %args) = @_;
    my $opt1 = $args{opt1};
    my $opt2 = $args{opt2};
}
func1('hoge', 'fuga', opt1 => 1, opt2 => 2);
```

```perl
sub func2 {
    my $arg1 = shift; # 暗黙的に@_を処理（破壊的）
    my $arg2 = shift;
    my $args = shift;
    my $opt1 = $args->{opt1};
    my $opt2 = $args->{opt2};
}
func2('hoge', 'fuga', opt1 => 1, opt2 => 2);
```

```perl
sub func3 { shift->{arg1} }
func3 {arg1 => 'hoge'};
```

```perl
sub func4 { $_[0]->{arg1} } # @_の第0要素
func4 {arg1 => 'hoge'};
```

### 名前空間

- パッケージに定義される

  ```perl
  package Greetings;

  sub hello { }
  1;

  # hello は Greetings::hello(); として定義される
  ```

- 注意: ネストしてもパッケージに定義される

  ```perl
  package Greetings;

  sub hello {
      sub make_msg { }
      sub print { }
      print (make_msg());
  }
  1;

  # Greeting::hello();
  # Greeting::make_msg();
  # Greeting::print();
  ```

- packageがない場合は`main`パッケージになる

  ```perl
  sub hello { }

  # main::hello()
  ```
