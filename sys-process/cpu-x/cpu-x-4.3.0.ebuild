# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake gnome2-utils xdg

MY_PN="CPU-X"

DESCRIPTION="A Free software that gathers information on CPU, motherboard and more"
HOMEPAGE="https://x0rg.github.io/CPU-X"
SRC_URI="https://github.com/X0rg/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="-* ~amd64"

IUSE="+glfw +gtk ncurses nls opencl"

DEPEND="
	gtk? ( x11-libs/gtk+:3 )
	ncurses? ( sys-libs/ncurses )
	opencl? ( virtual/opencl )
	media-libs/glfw
	sys-apps/pciutils
	sys-libs/libcpuid
	sys-process/procps
"

BDEPEND="
	nls? ( sys-devel/gettext )
	dev-lang/nasm
	dev-util/cmake
	virtual/pkgconfig
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_GTK=$(usex gtk)
		-DWITH_NCURSES=$(usex ncurses)
		-DWITH_GETTEXT=$(usex nls)
		-DWITH_LIBCPUID=ON
		-DWITH_LIBPCI=ON
		-DWITH_LIBPROCPS=ON
		-DWITH_LIBGLFW=$(usex glfw)
		-DWITH_OPENCL=$(usex opencl)
		-DWITH_LIBSTATGRAB=OFF
		-DWITH_DMIDECODE=ON
		-DWITH_BANDWIDTH=ON
		-DFORCE_LIBSTATGRAB=OFF
		-DGSETTINGS_LOCALINSTALL=OFF
	)

	cmake_src_configure
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
}
