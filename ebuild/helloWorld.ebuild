# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Hello, world"
HOMEPAGE="https://github.com/nguyenphuminh/HelloWorld"
SRC_URI="https://raw.githubusercontent.com/nguyenphuminh/HelloWorld/main/ebuild/helloWorld.ebuild"

LICENSE="MIT-with-advertising"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
    echo "Hello, world"
}
