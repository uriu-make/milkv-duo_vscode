# MilkV-Duo VSCode
MilkV-DuoのLinuxをC/C++で開発するための環境です。
動作環境はUbuntuを想定しています。

環境を使う場合は環境変数 `MILKV_DUO_SDK_PATH`にduo-sdkのパスを指定してください。(例: /home/user/duo-sdk)

ビルドしたファイルの配置はscpコマンドを使用しています。
デバッガは[duo-buildroot-sdk](https://github.com/milkv-duo/duo-buildroot-sdk)にある\
duo-buildroot-sdk/ramdisk/rootfs/public/gdbserver/riscv_musl/usr/bin/gdbserverをmilkv-duoの/usr/binに配置してください。

scpとsshを使用するため、公開鍵認証を使用することを推奨