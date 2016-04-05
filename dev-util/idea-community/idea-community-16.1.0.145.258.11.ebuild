# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils linux-info versionator

MY_PV="$(get_version_component_range 4-6)"
MY_PV_MAJ="$(get_version_component_range 1-3)"
MY_PN="idea"

DESCRIPTION="Capable and Ergonomic Java IDE (Community Edition)"
HOMEPAGE="https://www.jetbrains.com/idea/"
SRC_URI="${MY_PN}IC-${MY_PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#https://intellij-support.jetbrains.com/hc/en-us/articles/206544879-Selecting-the-JDK-version-the-IDE-will-run-under
RDEPEND=">=virtual/jdk-1.8"

RESTRICT="fetch strip"
QA_TEXTRELS="${PN}-IC-${MY_PV}/bin/libbreakgen.so
	${PN}-IC-${MY_PV}/bin/libbreakgen64.so"
QA_PRESTRIPPED="${PN}-IC-${MY_PV}/lib/libpty/linux/x86/libpty.so
	${PN}-IC-${MY_PV}/lib/libpty/linux/x86_64/libpty.so"

CONFIG_CHECK="~INOTIFY_USER"

S="${WORKDIR}/${MY_PN}-IC-${MY_PV}"

pkg_nofetch() {
	einfo "It seems JetBrains is deleting archives quickly and thus"
	einfo "are not accessible at all times via direct URL."
	einfo "Please download the community version from their main"
	einfo "website: https://www.jetbrains.com/idea/#chooseYourEdition"
	einfo "and name it ${MY_PN}IC-${MY_PV}.tar.gz"
	einfo "If the checksums dont match it means they probably updated"
	einfo "their tarball. Please open a ticket and I will update the"
	einfo "ebuild:"
	einfo "https://jira.hossie.de/secure/CreateIssue.jspa?pid=10000"
}

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
}

src_install() {
	local dir="/opt/${PN}-${MY_PV_MAJ}"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}/bin/${MY_PN}.sh" "${dir}/bin/inspect.sh"

	if use amd64; then
		fperms 755 "${dir}/bin/fsnotifier64"
	fi
	if use x86; then
		fperms 755 "${dir}/bin/fsnotifier"
	fi

	newicon "bin/idea.png" "${PN}.png"
	make_wrapper "${PN}" "${dir}/bin/${MY_PN}.sh"

	#https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
	mkdir -p "${D}/etc/sysctl.d/"
	echo "fs.inotify.max_user_watches = 524288" > "${D}/etc/sysctl.d/30-idea-inotify-watches.conf"

	make_desktop_entry ${PN} "IntelliJ IDEA (Community Edition)" "${PN}" "Development;IDE"
}

pkg_postinst() {
	/sbin/sysctl fs.inotify.max_user_watches=524288 >/dev/null
}