# Perlによるオブジェクト指向プログラミング

link: [Perlによるオブジェクト指向プログラミング](https://github.com/cateiru/Hatena-Textbook/blob/master/foundation-of-programming-perl.md#perl%E3%81%AB%E3%82%88%E3%82%8B%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E6%8C%87%E5%90%91%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0)

## Perlにおける概念

|   OOP概念    |                Perlでの実装                 |
| :----------: | :-----------------------------------------: |
|    クラス    |                 パッケージ                  |
|   メソッド   |        パッケージに定義された手続き         |
| オブジェクト | 特定のパッケージにbless()されたリファレンス |

```perl
package Parser; # クラス名
use strict;
use warnings;

# コンストラクタ
# my $parser = Parser->new; のように呼び出す
sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}

# メソッド
# $parser->parse(filename => 'hoge'); のように呼び出す
sub parse {
    my ($self, %args) = @_;
    my $filename = $args{filename};
}

1;
```

```perl
use Parser;

my $parser = Parser->new;
$parser->parse(filename => 'hoge');
```

### コンストラクタ

- 自分で定義する
  - RustとかGoのような感じ
- blessはデータと手続きを結びつける操作

  ```perl
  sub new {
      my $class = shift;
      my $self = bless { filename => 'hoge' }, $class;

      return $self;
  }
  ```

### クラスメソッド、インスタンスメソッド

- **定義時**: 第一引数を`$class`とみなすか`$self`とみなすか
- **呼び出し時**: クラスから呼び出すかインスタンスから呼び出すか

```perl
# 等価
Class->method($arg1, $arg2);
Class::method('Class', $arg1, $arg2);

# 等価
$object->method($arg1, $arg2);
Class::method($object, $arg1, $arg2);
```

### フィールド

- 1インスタンスにつき1データ
- 複数のデータを持ちたい場合はハッシュをblessする

```perl
my $self = bless {
    filed1 => $obj1,
    filed2 => [],
    filed3 => {},
}, $class
```

### カプセル化

- すべてがpublic（privateはない）（pythonみたいだね！）
- 命名規則などでゆるく隠蔽（`_`からはじまるやつはprivateにするとか）

### 継承

- `use parent`を使う

  ```perl
  package Me;
  use parent 'Father';

  ...

  1;
  ```

- SUPER

  ```perl
  sub new {
      my ($class) = @_;
      my $self = $class->SUPER::new();
      return $self;
  }
  ```

### 多重継承

- Mixinをやりたいときなどに使う
- 乱用厳禁

```perl
package Me;
use parent qw(Father Mother);

...

1;
```

## UNIVERSAL

- JavaでいうObjectのようなもの
- どのオブジェクトからも呼べる
- `isa()`

```perl
my $dog = Dog->new;

$dog->isa('Dog'); # true
$dog->isa('Animal'); # true
$dog->isa('Man'); # false
```

## 演算子のオーバーロード

- なるべく使わない
- URIとか

    ```perl
    my $url = URI->new('https:/example.com');

    $uri->path('hoge');
    print "URI is $uri"; # URI is https://example.com/hoge
    ```

## 例

- [Sample.pm](../../src/Sample.pm)
