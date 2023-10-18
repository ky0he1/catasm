# catasm

## 概要
cat コマンドを x86_64 のアセンブリで実装。

コマンドライン引数に指定したファイルを読み込み、内容を表示。

1ファイルしか対応していない。

ファイル容量の許容は 4096 バイト。

## デモ

下記は、WSLで実行。

```
$ arch
x86_64

$ cat hello.txt
Hello, world.
This is a "catasm" test.

$ ./build.sh catasm.asm

$ ./catasm hello.txt
Hello, world.
This is a "catasm" test.
```