# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/w32api/w32api-3.17.2.ebuild,v 1.3 2011/12/10 20:49:23 vapier Exp $

export CBUILD=${CBUILD:-${CHOST}}
export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi

inherit qt4-build

EAPI="3"

DESCRIPTION="The Qt toolkit is a comprehensive C++ application development
framework"
SLOT="4"

IUSE="+iconv +ssl optimized-qmake phonon multimedia webkit declarative opengl svg -qt3support"

# DEPEND="sys-libs/zlib
# 	ssl? ( dev-libs/openssl:mingw )
# 	dev-libs/libiconv:mingw"
# RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/fix_qtwebkit_test.patch"
)	

# qt_host_mkspecs_dir() {
# 	echo "linux-g++" #TODO
# }
# 
qt_target_mkspecs_dir() {
	echo "unsupported/win32-g++-cross"
}

pkg_setup() {
	qt4-build_pkg_setup
	QT4_TARGET_DIRECTORIES="."
}

src_unpack() {
    unpack ${A}
    cd "${S}"
}

src_prepare() {

# 	if use_if_iuse c++0x; then
# 		ewarn "You are about to build Qt4 using the C++11 standard. Even though"
# 		ewarn "this is an official standard, some of the reverse dependencies"
# 		ewarn "may fail to compile or link againt the Qt4 libraries. Before"
# 		ewarn "reporting a bug, make sure your bug is reproducible with c++0x"
# 		ewarn "disabled."
# 		append-flags -std=c++0x
# 	fi
	
	base_src_prepare
}

# src_configure() {
# 	QT_INSTALL_PREFIX=${EPREFIX}/usr/${CTARGET}/usr
# 	QTPREFIXDIR=${QT_INSTALL_PREFIX}
# 
# 	myconf+="
# 		-xplatform $(qt_target_mkspecs_dir)
# 		$(qt_use iconv)
# 		$(qt_use optimized-qmake)
# 		$(qt_use ssl openssl)
# 		$(qt_use exceptions exceptions)
# 		$(qt_use multimedia multimedia)
# 		$(qt_use phonon phonon)
# 		$(qt_use svg svg)
# 		$(qt_use opengl opengl)
# 		$(qt_use declarative declarative)
# 		$(qt_use qt3support qt3support)
# 		"
# 
# 	qt4-build_src_configure
# }


src_configure() {

	# Set up installation directories
	QT_INSTALL_PREFIX=${EPREFIX}/usr/${CTARGET}/usr
	QTPREFIXDIR=${QT_INSTALL_PREFIX}

	# debug/release
	if use debug; then
		conf+=" -debug"
	else
		conf+=" -release"
	fi

	conf+="
		-xplatform $(qt_target_mkspecs_dir)
		-fast
		-nomake examples -nomake demos
		-nomake tests
		-no-phonon-backend
		-opensource -confirm-license
		-prefix ${QTPREFIXDIR}
		$(qt_use iconv)
		$(qt_use optimized-qmake)
		$(qt_use ssl openssl)
		$(qt_use exceptions exceptions)
		$(qt_use multimedia multimedia)
		$(qt_use phonon phonon)
		$(qt_use svg svg)
		$(qt_use opengl opengl)
		$(qt_use declarative declarative)
		$(qt_use qt3support qt3support)
		"

	echo ./configure ${conf}
	./configure ${conf} || die "./configure failed"
}

src_compile() {
#	addwrite ${QTPREFIXDIR}
	emake || die "Make failed!"
}

src_install() {
	emake install || die "Install failed"
	
	into ${QT_INSTALL_PREFIX}
	dobin "${S}"/bin/{qmake,moc,rcc,uic,lrelease} || die "dobin failed"
	dodir ${QTPREFIXDIR} ${QT_INSTALL_PREFIX} || die "dodir failed"

	dosym ${QT_INSTALL_PREFIX}/bin/qmake ${EPREFIX}/usr/bin/${CTARGET}-qmake
	dosym ${QT_INSTALL_PREFIX}/bin/moc ${EPREFIX}/usr/bin/${CTARGET}-moc
	dosym ${QT_INSTALL_PREFIX}/bin/uic ${EPREFIX}/usr/bin/${CTARGET}-uic
	dosym ${QT_INSTALL_PREFIX}/bin/rcc ${EPREFIX}/usr/bin/${CTARGET}-rcc
}