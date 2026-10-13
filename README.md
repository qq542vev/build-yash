<!-- Document: README.md

「Build Yash」の日本語マニュアル。

Metadata:

	id - 2672a38d-da8c-4a11-af65-13191c9c8869
	author - <qq542vev at https://purl.org/meta/me/>
	version - 0.2.1
	created - 2026-02-05
	modified - 2026-10-12
	copyright - Copyright (C) 2026-2026 qq542vev. Some rights reserved.
	license - <GPL-3.0-only at https://www.gnu.org/licenses/gpl-3.0.txt>
	conforms-to - <https://spec.commonmark.org/current/>

See Also:

	* <Project homepage at https://github.com/qq542vev/build-yash>
	* <Bug report at https://github.com/qq542vev/build-yash/issues>
-->

# Build Yash

Build Yashは、Linux環境を前提として複数アーキテクチャ向けにビルドした
[Yash](https://magicant.github.io/yash/)の配布物を作成するプロジェクトです。
Docker環境で静的リンクを行い、次の環境でビルドを行っています。

* Yash 2.60以前 - Ubuntu 18.04
* Yash 2.61 - Debian 13

対応するアーキテクチャは次の通りです。

* 386
* amd64
* arm/v7
* arm64
* ppc64le
* s390x

ビルド済みの配布物は
[Releasesページ](https://gitlab.com/qq542vev/build-yash/-/releases)
からダウンロード可能です。

通常の利用者は、リリースされた配布物をダウンロードして使用してください。
配布物の作成方法や利用可能なターゲットについては、
[GNUmakefile](GNUmakefile)および`make help`の出力を参照してください。

## ライセンス

Build Yashに於いて作成したファイルは
[LICENSE.txt](LICENSE.txt)の記載に従います。
Yash自体のライセンスは
[COPYING](https://github.com/magicant/yash/blob/trunk/COPYING)
の記載に従います。
