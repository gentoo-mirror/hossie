# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils linux-info versionator

DESCRIPTION="Capable and Ergonomic Java IDE (Ultimate Edition)"
HOMEPAGE="https://www.jetbrains.com/idea/"
SRC_URI="http://download.jetbrains.com/cpp/CLion-${PV}.tar.gz"

LICENSE="IDEA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#gdb 7.8 is not in tree anymore, so we keep the bundled version
RDEPEND=">=virtual/jdk-1.8
    dev-util/cmake"

RESTRICT="strip"
QA_PREBUILT="opt/${PN}-2016.1.2/*"

CONFIG_CHECK="~INOTIFY_USER"

S="${WORKDIR}/${PN}-2016.1.2"

src_prepare() {
	if ! use amd64; then
		rm -rf lib/libpty/linux/x86_64
		rm -f bin/fsnotifier64 bin/libbreakgen64.so bin/idea64.vmoptions
	fi
	if ! use x86; then
		rm -rf lib/libpty/linux/x86
		rm -f bin/fsnotifier bin/libbreakgen.so bin/idea.vmoptions
	fi
	rm -f bin/fsnotifier-arm
	rm -rf lib/libpty/{win,macosx}
	rm Install-Linux-tar.txt
	rm -rf bin/cmake
	rm -rf plugins/tfsIntegration/lib/native/linux/{arm,ppc}
	rm -rf plugins/tfsIntegration/lib/native/{aix,freebsd,hpux,macosx,solaris,win32}
}

src_install() {
	local dir="/opt/${PN}-2016.1.2"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}/bin/${PN}.sh" "${dir}/bin/inspect.sh" "${dir}/bin/gdb/bin/gdb"

	if use amd64; then
		fperms 755 "${dir}/bin/fsnotifier64"
	fi
	if use x86; then
		fperms 755 "${dir}/bin/fsnotifier"
	fi

	newicon "bin/${PN}.svg" "${PN}.svg"
	make_wrapper "${PN}" "${dir}/bin/${PN}.sh"

	#https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
	mkdir -p "${D}/etc/sysctl.d/"
	echo "fs.inotify.max_user_watches = 524288" > "${D}/etc/sysctl.d/30-${PN}-inotify-watches.conf"

	make_desktop_entry "${PN}" "CLion" "${PN}" "Development;IDE;"
}

pkg_postinst() {
	/sbin/sysctl fs.inotify.max_user_watches=524288 >/dev/null
}