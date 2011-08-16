# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/arora/arora-0.11.0.ebuild,v 1.2 2011/01/26 16:20:15 darkside Exp $

EAPI=3
inherit cmake-utils

DESCRIPTION="Qt3D binding for qml"
HOMEPAGE="http://labs.qt.nokia.com/2011/05/20/qt-quick-3d-downloads-available/"
SRC_URI="http://launchpad.net/appmenu-qt/trunk/0.2.1/+download/${P}.tar.bz2"

LICENSE="|| ( GPL-3 GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="debug doc"

RDEPEND="x11-libs/qt-gui:4"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S="${WORKDIR}"/"${P}"
