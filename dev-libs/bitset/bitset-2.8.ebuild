# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit git-2 autotools-utils

EGIT_REPO_URI="git@github.com:chriso/bitset.git"
EGIT_COMMIT="${PV}"
DESCRIPTION="A compressed bitset with supporting data structures and algorithms"
HOMEPAGE="http://github.com/chriso/bitset"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="debug jemalloc tcmalloc"
KEYWORDS="~amd64 ~x86"

RDEPEND="tcmalloc? ( dev-util/google-perftools )
	jemalloc? ( >=dev-libs/jemalloc-3.0 )"
DEPEND="${RDEPEND}"
REQUIRED_USE="tcmalloc? ( !jemalloc )
	jemalloc? ( !tcmalloc )"

S="${WORKDIR}/${PN}"

src_prepare() {
	eautoreconf
	autotools-utils_src_prepare
}

src_configure() {
	local EXTRA_ECONF=""
	if use jemalloc; then
		EXTRA_ECONF="--with-jemalloc-prefix=j"
	fi
 	econf \
		$(use_with jemalloc) \
		$(use_with tcmalloc) \
		${EXTRA_ECONF}
}

src_compile() {
	AUTOTOOLS_IN_SOURCE_BUILD=1
	autotools-utils_src_compile
}
