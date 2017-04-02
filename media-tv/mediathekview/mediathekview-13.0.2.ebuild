# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="MediathekView searches the online portals of public broadcasting services"
HOMEPAGE="https://mediathekview.de/"
SRC_URI="https://github.com/${PN}/MediathekView/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-java/oracle-jdk-bin:1.8[javafx]
	dev-java/gradle-bin:*"
RDEPEND="|| ( dev-java/oracle-jdk-bin:1.8[javafx] dev-java/oracle-jre-bin:1.8[javafx] )
	media-video/flvstreamer
	media-video/vlc
	virtual/ffmpeg"

S="${WORKDIR}/MediathekView-${PV}"

src_compile() {
	gradle -g "${WORKDIR}" --no-daemon jar
}