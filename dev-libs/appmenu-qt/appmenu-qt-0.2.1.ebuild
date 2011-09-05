# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/arora/arora-0.11.0.ebuild,v 1.2 2011/01/26 16:20:15 darkside Exp $

EAPI=3
inherit cmake-utils

DESCRIPTION="Os x like global menu plugin for Qt"
HOMEPAGE="https://launchpad.net/appmenu-qt"
SRC_URI="http://launchpad.net/appmenu-qt/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="|| ( GPL-3 GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="debug"

RDEPEND=">x11-libs/qt-gui-4.7.4"

S="${WORKDIR}"/"${P}"
