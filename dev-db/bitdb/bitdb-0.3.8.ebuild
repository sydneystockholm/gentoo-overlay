# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit git-2 autotools-utils

EGIT_REPO_URI="https://github.com/sydneystockholm/bitdb.git"
EGIT_COMMIT="${PV}"
AUTOTOOLS_IN_SOURCE_BUILD=1

DESCRIPTION="A compressed bitset with supporting data structures and algorithms"
HOMEPAGE="http://github.com/sydneystockholm/bitdb"

LICENSE="MIT"
SLOT="0"
IUSE="single-thread test"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-libs/bitset-2.8.4
	dev-db/libzdb"
DEPEND="${RDEPEND}
	test? ( dev-db/libzdb[sqlite] )"

S="${WORKDIR}/${PN}"

src_prepare() {
	eautoreconf
	autotools-utils_src_prepare
}

src_configure() {
	econf \
		$(use_enable single-thread)
}

src_compile() {
	autotools-utils_src_compile
}
