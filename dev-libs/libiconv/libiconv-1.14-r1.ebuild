# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libiconv/libiconv-1.14.ebuild,v 1.2 2012/02/09 00:16:30 vapier Exp $

EAPI="4"

inherit libtool toolchain-funcs

DESCRIPTION="GNU charset conversion library for libc which doesn't implement it"
HOMEPAGE="http://www.gnu.org/software/libiconv/"
SRC_URI="mirror://gnu/libiconv/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="mingw"
KEYWORDS="-*"
IUSE=""

DEPEND="!sys-libs/glibc
	!sys-apps/man-pages"
RDEPEND="${DEPEND}"

src_prepare() {
	# Make sure that libtool support is updated to link "the linux way"
	# on FreeBSD.
	elibtoolize
}

src_configure() {
	# Disable NLS support because that creates a circular dependency
	# between libiconv and gettext
	econf \
		--disable-shared \
		--enable-static
}
