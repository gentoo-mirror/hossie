# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils java-pkg-2

DESCRIPTION="MediathekView searches the online portals of public broadcasting services"
HOMEPAGE="https://mediathekview.de/"
SRC_URI="https://github.com/${PN}/MediathekView/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/jdk:1.8
	dev-java/gradle-bin:*"
RDEPEND="|| ( virtual/jre:1.8 virtual/jdk:1.8 )
	dev-java/commons-lang:3.3
	dev-java/jackson:2
	dev-java/jchart2d:0
	dev-java/jgoodies-common:1.8
	dev-java/jgoodies-forms:1.8
	dev-java/jide-oss:0
	dev-java/mlib:2
	dev-java/swingx:1.6
	dev-java/xz-java:0
	media-video/flvstreamer
	media-video/vlc
	virtual/ffmpeg"

S="${WORKDIR}/MediathekView-${PV}"

src_compile() {
	gradle -g "${WORKDIR}" --no-daemon jar || die
}

src_install() {
	java-pkg_dojar build/libs/MediathekView.jar

	java-pkg_register-dependency commons-lang-3.3
	java-pkg_register-dependency jackson-2
	java-pkg_register-dependency jchart2d
	java-pkg_register-dependency jgoodies-common-1.8
	java-pkg_register-dependency jgoodies-forms-1.8
	java-pkg_register-dependency jide-oss
	java-pkg_register-dependency mlib-2
	java-pkg_register-dependency swingx-1.6
	java-pkg_register-dependency xz-java

	java-pkg_dolauncher "${PN}" --main mediathek.Main

	newicon -s scalable res/Info/MediathekView.svg "${PN}.svg"
	make_desktop_entry "${PN}" "MediathekView" mediathekview
}