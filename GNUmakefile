#!/usr/bin/gmake -f

### Script: makefile
##
## ファイルを作成する。
##
## Metadata:
##
##   id - fa81a0e9-4012-432d-9b89-046c3bed5a23
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 1.0.0
##   created - 2026-01-09
##   modified - 2026-01-09
##   copyright - Copyright (C) 2026-2026 qq542vev. All rights reserved.
##   license - <GPL-3.0-only at https://www.gnu.org/licenses/gpl-3.0.txt>
##   depends - docker, find, git, glab, mkdir, mv, rm, tar
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/build-yash>
##   * <Bag report at https://github.com/qq542vev/build-yash/issues>

# Sp Targets
# ==========

.PHONY: all clean rebuild update publish unpublish image help version

.SILENT: help version

# Macro
# =====

.SHELLFLAGS = -efu -c

VERSION = 1.0.0

DIR = build
ARCHS = 386 amd64 arm/v7 arm64 ppc64le s390x
#ARCHS = arm64
PARCHS != for arch in $(ARCHS); do echo "%/$${arch}"; done
UPSTREAM = https://github.com/magicant/yash.git

DOCKER = eval docker buildx bake --progress plain $${opts-} $(DOCKER_OPTS) | tar -xvC '$(@)'
CMD = { mkdir -p -- '$(@)' && $(DOCKER); }
YASH_V1 = $(CMD)
YASH_V2 = $(CMD)
YASH_CURR = $(YASH_V2)
SET = \
	trap '[ "$${?}" -ne 0 ] && rm -rf "$(@)"' EXIT HUP INT QUIT TERM; \
	set -- '$(@:$(DIR)/%=%)'; \
	export ARCH="$${1\#*/}" REV="$${1%%/*}"
#TAGS = 2.56 2.56.1 2.57 2.58 2.58.1 2.59 2.60
TAGS = 2.55 2.56 2.56.1 2.57 2.58 2.58.1 2.59 2.60
#TAGS = 2.59

# Build
# =====

all:
	$(MAKE) $(TAGS:%=$(DIR)/%/all)

$(DIR)/%/all:
	for target in $(ARCHS:%=$(@D)/%); do $(MAKE) "$${target}"; done

$(ARCHS:%=$(DIR)/%):
	$(SET); $(YASH_CURR)

$(PARCHS:%=$(DIR)/1.%):
	$(SET); $(YASH_V1)

$(PARCHS:%=$(DIR)/2.%):
	$(SET); $(YASH_V2)

clean:
	rm -rf -- '$(DIR)'

rebuild: clean
	$(MAKE)

update:
	git fetch --force '$(UPSTREAM)' 'master:master'

publish:
	for tag in $(TAGS); do \
		if [ -d "$(DIR)/$${tag}" ]; then \
			find "$(DIR)/$${tag}" ! -name '*.log' -type f -exec glab release create "$${tag}" --name "$${tag}" --notes "see: <https://github.com/magicant/yash/releases/tag/$${tag}>" --no-update --use-package-registry '{}' +; \
		fi; \
	done

unpublish:
	for tag in $(TAGS); do \
		if glab release view "$${tag}" >/dev/null 2>&1; then \
			glab release delete "$${tag}" -y; \
		fi; \
	done

image:
	for tag in $(TAGS); do \
		if [ -d "$(DIR)/$${tag}" ]; then \
			DIR="$(DIR)/$${tag}" docker buildx bake -f docker-sa-img.hcl; \
		fi; \
	done

# Message
# =======

help:
	echo 'ファイルを作成する。'
	echo
	echo 'USAGE:'
	echo '  make [OPTION...] [MACRO=VALUE...] [TARGET...]'
	echo
	echo 'MACRO:'
	echo '  DOCKER_OPTS   dockerコマンドへの追加オプション。'
	echo '  UPSTREAM      リモートリポジトリのアップストリーム用のURL。'
	echo
	echo 'TARGET:'
	echo '  all       全てのファイルを作成する。'
	echo '  clean     作成したファイルを削除する。'
	echo '  rebuild   cleanの実行後にallを実行する。'
	echo '  update    ローカルリポジトリを更新する。'
	echo '  publish   リリースページを作成する。'
	echo '  unpublish リリースページを削除する。'
	echo '  image     Dockerイメージを生成する。'
	echo '  help      このヘルプを表示して終了する。'
	echo '  version   バージョン情報を表示して終了する。'

version:
	echo '$(VERSION)'
