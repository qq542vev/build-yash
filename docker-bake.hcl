### File: docker-bake.hcl
##
## YASHを組み立てる。
##
## Usage:
##
## ------ Text ------
## docker buildx bake -f docker-bake.hcl
## ------------------
##
## Env variable:
##
##   ARCH - ビルド対象のアーキテクチャ。
##   DOCKERFILE - Dockerfile。
##   REV - Gitリポジトリのリビジョン識別子。
##
## Metadata:
##
##   id - a5fcfbac-d7ad-404f-808d-f36211691bd8
##   author - <qq542vev at https://purl.org/meta/me/>
##   version - 1.0.1
##   created - 2026-01-09
##   modified - 2026-01-17
##   copyright - Copyright (C) 2026-2026 qq542vev. All rights reserved.
##   license - <GPL-3.0-only at https://www.gnu.org/licenses/gpl-3.0.txt>
##   conforms-to - <https://docs.docker.com/build/bake/reference/>
##
## See Also:
##
##   * <Project homepage at https://github.com/qq542vev/build-yash>
##   * <Bag report at https://github.com/qq542vev/build-yash/issues>

variable "REV" {default = "2.60"}
variable "ARCH" {default = "386"}
variable "DOCKERFILE" {
  default = try("Dockerfile.${regex("^v[1-9][0-9]*", "${REV}")}", "Dockerfile")
}

target "default" {
  context = "."
  dockerfile = "${DOCKERFILE}"
  platforms = ["linux/${ARCH}"]
  args = {
    REV = REV
  }
  secret = [
    {
      type = "file"
      id = "attach"
      src = "attach.yaml"
    }
  ]
  output = [
    "type=tar,dest=-"
  ]
}
