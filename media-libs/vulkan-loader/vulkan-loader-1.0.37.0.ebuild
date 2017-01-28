# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python3_{4,5} )

inherit python-any-r1 cmake-multilib

GLSLANG_REV="6a60c2f9ead58eb9040e47e3e2ada01488648901"
SPIRVHEADERS_REV="c470b68225a04965bf87d35e143ae92f831e8110"
SPIRVTOOLS_REV="945e9fc4b477ee55d2262249e5d1d886aa6ba679"

DESCRIPTION="Vulkan Installable Client Driver (ICD) Loader"
HOMEPAGE="https://www.khronos.org/vulkan/"
SRC_URI="https://github.com/KhronosGroup/Vulkan-LoaderAndValidationLayers/archive/sdk-${PV}.tar.gz -> ${P}.tar.gz
	https://api.github.com/repos/KhronosGroup/glslang/tarball/${GLSLANG_REV} -> vulkan-glslang-${PV}.tar.gz
	https://api.github.com/repos/KhronosGroup/SPIRV-Headers/tarball/${SPIRVHEADERS_REV} -> vulkan-spirvheaders-${PV}.tar.gz
	https://api.github.com/repos/KhronosGroup/SPIRV-Tools/tarball/${SPIRVTOOLS_REV} -> vulkan-spirvtools-${PV}.tar.gz"

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

S="${WORKDIR}/Vulkan-LoaderAndValidationLayers-sdk-${PV}"

src_unpack() {
	default

	multilib_src_unpack() {
		mkdir -p "${BUILD_DIR}/external"/{glslang,spirv-tools{,/external/spirv-headers}} || die
		cp -a "${WORKDIR}/KhronosGroup-glslang-6a60c2f"/* "${BUILD_DIR}/external/glslang"
		cp -a "${WORKDIR}/KhronosGroup-SPIRV-Tools-945e9fc"/* "${BUILD_DIR}/external/spirv-tools"
		cp -a "${WORKDIR}/KhronosGroup-SPIRV-Headers-c470b68"/* "${BUILD_DIR}/external/spirv-tools/external/spirv-headers"
	}

	multilib_foreach_abi multilib_src_unpack
}

multilib_src_configure() {
	einfo "Building glslang"
	cd "${BUILD_DIR}/external/glslang"
	cmake -H. -Bbuild || die
	cd "${BUILD_DIR}/external/glslang/build"
	emake || die "cannot build glslang"
	emake install || die "cannot install glslang"

	einfo "Building SPIRV-Tools"
	cd "${BUILD_DIR}/external/spirv-tools"
	cmake -H. -Bbuild || die
	cd "${BUILD_DIR}/external/spirv-tools/build"
	emake || die "cannot build SPIRV-Tools"

	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=True
		-DBUILD_TESTS=False
		-DBUILD_LAYERS=False
		-DBUILD_DEMOS=True
		-DBUILD_VKJSON=False
		-DBUILD_LOADER=True
		-DBUILD_WSI_MIR_SUPPORT=False
		-DBUILD_WSI_WAYLAND_SUPPORT=$(usex wayland)
		-DCUSTOM_GLSLANG_BIN_ROOT="${BUILD_DIR}/external/glslang/build/install"
	)
	cmake-utils_src_configure
}

multilib_src_compile(){
	cmake-utils_src_compile
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
