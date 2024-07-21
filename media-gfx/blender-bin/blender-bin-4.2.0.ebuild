# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper xdg-utils

MY_SLOT="4.2"

DESCRIPTION="3D Creation/Animation/Publishing System"
HOMEPAGE="https://www.blender.org"
SRC_URI="https://ftp.halifax.rwth-aachen.de/blender/release/Blender${MY_SLOT}/blender-${PV}-linux-x64.tar.xz"

LICENSE="Apache-2.0 BSD FTL GPL-3 MIT MPL-2.0 openssl PYTHON"
SLOT="${MY_SLOT}"
KEYWORDS="~amd64"

IUSE="cuda hip oneapi"

DEPEND="!media-gfx/blender:${MY_SLOT}"
RDEPEND="${DEPEND}
	cuda? ( dev-util/nvidia-cuda-toolkit )
	hip? ( =dev-util/hip-6* )
	oneapi? ( dev-libs/level-zero )
	virtual/opengl"

RESTRICT="binchecks strip"

S="${WORKDIR}/blender-${PV}-linux-x64"

src_prepare() {
	sed \
		-e "s|Name=Blender|Name=Blender ${MY_SLOT}|" \
		-e "s|Exec=blender|Exec=blender-${MY_SLOT}|" \
		-e "s|Icon=blender|Icon=blender-${MY_SLOT}|" \
		-e "/X-KDE-RunOnDiscreteGpu/d" \
		-i blender.desktop || die
	mv blender.svg "blender-${MY_SLOT}.svg" || die
	mv blender-symbolic.svg "blender-symbolic-${MY_SLOT}.svg" || die
	mv blender.desktop "blender-${MY_SLOT}.desktop" || die

	default
}

src_install() {
	use cuda || rm -f lib/libOpenImageDenoise_device_cuda.so*
	use hip || rm -f lib/libOpenImageDenoise_device_hip.so*
	use oneapi || rm -f lib/libOpenImageDenoise_device_sycl.so* lib/libpi_level_zero.so*

	domenu "blender-${MY_SLOT}.desktop"
	doicon -s scalable "blender-symbolic-${MY_SLOT}.svg" "blender-${MY_SLOT}.svg"
	rm "blender-${MY_SLOT}.svg" "blender-symbolic-${MY_SLOT}.svg" "blender-${MY_SLOT}.desktop"

	insinto "/opt/blender-${MY_SLOT}"
	doins -r *

	fperms +x /opt/blender-${MY_SLOT}/blender{,-launcher,-softwaregl,-thumbnailer} /opt/blender-${MY_SLOT}/${MY_SLOT}/python/bin/python3.11

	make_wrapper "blender-${MY_SLOT}" "/opt/blender-${MY_SLOT}/blender" "/opt/blender-${MY_SLOT}"
}

pkg_pretend() {
	einfo "The blender download bouncer does not seem to work with portage downloads,"
	einfo "a mirror is hardcoded in SRC_URI, if the download is slow for you, download"
	einfo "blender-${PV}-linux-x64.tar.xz from"
	einfo "https://www.blender.org/download/release/Blender${MY_SLOT} (redirects you to a local mirror)"
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
