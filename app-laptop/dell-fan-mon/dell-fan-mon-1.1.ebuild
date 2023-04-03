# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

DESCRIPTION="Fan monitor for some Dell laptops"
HOMEPAGE="https://github.com/ru-ace/dell-fan-mon"
SRC_URI="https://github.com/ru-ace/dell-fan-mon/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	sed -e '/^CFLAGS/s@=.*@+=-fstack-protector-strong@' -i Makefile || die

	default
}

src_install() {
	dobin "${PN}"
	doman "${PN}.1"

	newinitd "${FILESDIR}/${PN}.init" "${PN}"
	systemd_dounit "${PN}.service"

	insinto /etc
	doins "${PN}.conf"
}

pkg_postinst() {
	einfo "If you want i8k methods working, you need"
	einfo "CONFIG_I8K in your kernel"
}
