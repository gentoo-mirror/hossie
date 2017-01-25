# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python3_{4,5} )

SRC_URI="https://github.com/KhronosGroup/Vulkan-LoaderAndValidationLayers/archive/sdk-${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/KhronosGroup/glslang.git"

inherit python-any-r1 cmake-multilib git-r3

DESCRIPTION="Vulkan Installable Client Driver (ICD) Loader"
HOMEPAGE="https://www.khronos.org/vulkan/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="wayland"

KEYWORDS="~amd64"

DEPEND="${PYTHON_DEPS}
	x11-libs/libX11:=
	wayland? ( dev-libs/wayland )
	!media-libs/vulkan-base"
RDEPEND="${DEPEND}"

DOCS=( README.md LICENSE.txt )

multilib_src_unpack() {
	GLSLANG_REV=$(cat "${S}/external_revisions/glslang_revision")
	SPIRVTOOLS_REV=$(cat "${S}/external_revisions/spirv-tools_revision")
	SPIRVHEADERS_REV=$(cat "${S}/external_revisions/spirv-headers_revision")

	git-r3_fetch "https://github.com/KhronosGroup/glslang.git" "${GLSLANG_REV}"
	git-r3_fetch "https://github.com/KhronosGroup/SPIRV-Tools.git" "${SPIRVTOOLS_REV}"
	git-r3_fetch "https://github.com/KhronosGroup/SPIRV-Headers.git" "${SPIRVHEADERS_REV}"

	git-r3_checkout https://github.com/KhronosGroup/glslang.git \
		"${S}"/external/glslang
	git-r3_checkout https://github.com/KhronosGroup/SPIRV-Tools.git \
		"${S}"/external/spirv-tools
	git-r3_checkout https://github.com/KhronosGroup/SPIRV-Headers.git \
		"${S}"/external/spirv-tools/external/spirv-headers
}

multilib_src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=True
		-DBUILD_TESTS=False
		-DBUILD_LAYERS=False
		-DBUILD_DEMOS=True
		-DBUILD_VKJSON=False
		-DBUILD_LOADER=True
		-DBUILD_WSI_MIR_SUPPORT=False
		-DBUILD_WSI_WAYLAND_SUPPORT=$(usex wayland)
	)
	cmake-utils_src_configure
}

multilib_src_install() {
	keepdir /etc/vulkan/icd.d

	cd "${BUILD_DIR}/loader"
	dolib libvulkan.so.1.*
	dosym libvulkan.so.1.* /usr/$(get_libdir)/libvulkan.so.1
	dosym libvulkan.so.1.* /usr/$(get_libdir)/libvulkan.so

	dobin "${S}"/build/demos/vulkaninfo

	insinto /usr/include/vulkan
	doins "${S}"/include/vulkan/{*.h,*.hpp}
	einstalldocs
}
