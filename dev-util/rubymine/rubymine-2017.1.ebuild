# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils linux-info versionator

MY_PV="$(get_version_component_range 1-2)"
MY_PN="RubyMine"

DESCRIPTION="The most intelligent Ruby on Rails IDE"
HOMEPAGE="https://www.jetbrains.com/idea"
SRC_URI="https://download.jetbrains.com/ruby/${MY_PN}-${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="JetBrainsToolbox"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="!custom-jdk? ( >=virtual/jdk-1.8:* )"

CONFIG_CHECK="~INOTIFY_USER"
IUSE="+custom-jdk"

QA_PREBUILT="opt/${MY_PN}-${MY_PV}/*"

S="${WORKDIR}/${MY_PN}-${MY_PV}"

src_prepare() {
	if ! use amd64; then
		rm -r lib/libpty/linux/x86_64 || die
		rm -f bin/fsnotifier64 bin/libyjpagent-linux64.so bin/rubymine64.vmoptions || die
	fi
	if ! use x86; then
		rm -r lib/libpty/linux/x86 || die
		rm -f bin/fsnotifier bin/libyjpagent-linux.so bin/rubymine.vmoptions || die
	fi
	rm -f bin/fsnotifier-arm || die
	rm Install-Linux-tar.txt || die

	if ! use custom-jdk; then
		rm -r jre || die
	fi
}

src_install() {
	local dir="/opt/${MY_PN}-${MY_PV}"

	insinto "${dir}"
	doins -r *

	fperms +x "${dir}/bin/format.sh" "${dir}/bin/printenv.py" "${dir}/bin/restart.py" \
		"${dir}/bin/rinspect.sh" "${dir}/bin/${PN}.sh"

	use amd64 && fperms +x "${dir}/bin/fsnotifier64"
	use x86 && fperms +x "${dir}/bin/fsnotifier"

	if use custom-jdk; then
		for jrefile in java jjs keytool orbd pack200 policytool rmid rmiregistry servertool tnameserv unpack200; do
			fperms +x "${dir}/jre/bin/${jrefile}"
		done
	fi

	doicon "bin/${PN}.png"
	newicon -s scalable "bin/RMlogo.svg" "${PN}.svg"
	make_wrapper "${PN}" "${dir}/bin/${MY_PN}.sh"

	#https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
	mkdir -p "${D}/etc/sysctl.d/"
	echo "fs.inotify.max_user_watches = 524288" > "${D}/etc/sysctl.d/30-${PN}-inotify-watches.conf"

	make_desktop_entry "${PN}" "${MY_PN}" "${PN}" "Development;IDE"
}

pkg_postinst() {
	sysctl fs.inotify.max_user_watches=524288 >/dev/null
}