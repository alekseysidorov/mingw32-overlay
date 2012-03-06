inherit qt4-build

EAPI="3"

DESCRIPTION="The Qt toolkit is a comprehensive C++ application development
framework"
SLOT="4"

IUSE="+iconv +ssl optimized-qmake"

DEPEND="sys-libs/zlib
	ssl? ( dev-libs/openssl:mingw )
	dev-libs/libiconv:mingw"
RDEPEND="${DEPEND}"

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
	echo "foo"
}

# src_configure() {
# 	myconf+="
# 		$(qt_use iconv)
# 		$(qt_use optimized-qmake)
# 		$(qt_use ssl openssl)
# 		"
# 
# 	qt4-build_src_configure
# }

src_configure() {

	# Set up installation directories
	QTPREFIXDIR=${EPREFIX}/usr
	QT_INSTALL_PREFIX=${EPREFIX}/usr/$(get_libdir)/qt4

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
		-no-qt3support
		-opensource -confirm-license
		-prefix ${QTPREFIXDIR}
		$(qt_use iconv)
		$(qt_use optimized-qmake)
		$(qt_use ssl openssl)
		"

	echo ./configure ${conf}
	./configure ${conf} || die "./configure failed"
}

src_compile() {
	 emake || die "Make failed!"
}