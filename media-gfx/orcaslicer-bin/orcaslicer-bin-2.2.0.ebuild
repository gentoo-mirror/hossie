# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils

DESCRIPTION="G-code generator for 3D printers"
HOMEPAGE="https://github.com/SoftFever/OrcaSlicer"
SRC_URI="https://github.com/SoftFever/OrcaSlicer/releases/download/v${PV}/OrcaSlicer_Linux_V${PV}.AppImage -> ${P}.AppImage"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="!media-gfx/orcaslicer"
RDEPEND="${DEPEND}
	dev-libs/expat
	dev-libs/glib
	dev-libs/wayland
	media-libs/fontconfig
	media-libs/gstreamer
	media-libs/libglvnd
	net-libs/webkit-gtk:4
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/pango"
BDEPEND="app-admin/chrpath"

S="${WORKDIR}/squashfs-root"

src_unpack() {
	cp "${DISTDIR}/${A}" "${T}"
	chmod +x "${T}/${A}"
    "${T}/${A}" --appimage-extract || die
}

src_prepare() {
	sed -i 's|Exec=AppRun|Exec=orcaslicer|g' OrcaSlicer.desktop || die

	chrpath -d bin/orca-slicer || die

	default
}

src_install() {
	dobin "${FILESDIR}/orcaslicer"

	insinto "/opt/orcaslicer"
	doins -r bin resources
	fperms +x /opt/orcaslicer/bin/orca-slicer

	domenu OrcaSlicer.desktop
	doicon -s 192 usr/share/icons/hicolor/192x192/apps/OrcaSlicer.png
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
