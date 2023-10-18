section .data
    filebuf times 4096 db 0

section .text
global _start
_start:
    ; int argc
    mov rdi, [rsp]
    ; char* argv[1] = [rsp+0x8]
    ; char* argv[2]
    mov rsi, [rsp+0x10]

    ; argc = 1 の場合 exit
    cmp rdi, 1
    jz .exit

    ; ファイルをオープンする
    mov rax, 2 ; sys_open のシステムコール番号
    mov rdi, rsi ; ファイル名のアドレス
    mov rsi, 0 ; O_WRONLY フラグ
    syscall
    mov r10, rax ; ファイルディスクリプタを保存

    ; ファイルを読み込む
    mov rax, 0 ; sys_read のシステムコール番号
    mov rdi, r10 ; ファイルディスクリプタ
    mov rsi, filebuf ; 読み込む先のアドレス
    mov rdx, 4096 ; 読み込む最大サイズ
    syscall

    ; ファイルを閉じる
    mov rax, 3 ; sys_close のシステムコール番号
    mov rdi, r10 ; ファイルディスクリプタ
    syscall

    ; カウント初期化
    xor rcx, rcx
    call .strlen

    ; コマンドライン引数表示
    call .print

; 終了
.exit:
    ; プログラムを終了する
    mov rax, 60 ; sys_exit のシステムコール番号
    xor rdi, rdi ; 終了コード 0
    syscall


; 文字数カウント
.strlen:
.loop:
    ; 1文字取得
    mov al, BYTE [filebuf+rcx]
    ; 0 かどうか
    cmp al, 0
    ; 0 (文字列の末尾) の場合 break
    jz .break
    ; インクリメント
    add rcx, 1
    ; ループ
    jmp .loop
.break:
    ret


; コマンドライン引数表示
.print:
    ; write の指定
    mov	rax, 1
    ; 第1引数を定義
    mov rdi, 1
    ; 第2引数を定義
    mov rsi, rsi
    ; 第3引数を定義
    mov rdx, rcx
    ; システムコールを実行
    syscall
    ret
