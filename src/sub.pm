my @city = qw/東京 大阪 名古屋/;

$" = "/";

# print "@city\n";

# ここ関数呼び出し(サブルーチン)
print_array(@city);

sub print_array {
    # 引数取得
    my @array = @_;

    print "@array\n";
}
