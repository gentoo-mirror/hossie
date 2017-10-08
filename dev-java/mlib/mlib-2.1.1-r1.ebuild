# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit java-pkg-2

DESCRIPTION="Java library for mediathekview"
HOMEPAGE="https://github.com/mediathekview/MLib"
SRC_URI="https://github.com/mediathekview/MLib/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="2"
KEYWORDS="~x86 ~amd64"

DEPEND="virtual/jdk:1.8
	dev-java/gradle-bin:*"
RDEPEND="|| ( virtual/jre:1.8 virtual/jdk:1.8 )
	dev-java/commons-lang:3.3
	dev-java/jackson:2
	dev-java/jide-oss:0
	dev-java/xz-java:0"

S="${WORKDIR}/MLib-${PV}"

src_compile() {
	GRADLE="$(ls -1 ${EPREFIX}/usr/bin/gradle-* | sort | head -n1)"
	${GRADLE} -g "${WORKDIR}" --no-daemon jar || die
}

src_install() {
	java-pkg_newjar "build/libs/MSearch-${PV}.jar" msearch.jar

	java-pkg_register-dependency commons-lang-3.3
	java-pkg_register-dependency jackson-2
	java-pkg_register-dependency jide-oss
	java-pkg_register-dependency xz-java
}