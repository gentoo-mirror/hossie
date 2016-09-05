# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3

DESCRIPTION="Vulkan loader and validation layers"
HOMEPAGE="https://vulkan.lunarg.com"
EGIT_REPO_URI="https://github.com/KhronosGroup/Vulkan-LoaderAndValidationLayers.git"

LICENSE="Apache-2.0"
IUSE="wayland"
SLOT="0"

KEYWORDS="~amd64"

RDEPEND="x11-libs/libX11:=
	x11-libs/libxcb:=
	wayland? ( dev-libs/wayland:* )"
DEPEND="dev-util/cmake:*
	${RDEPEND}"

src_unpack() {
	git-r3_fetch "${EGIT_REPO_URI}" "refs/tags/sdk-${PV}.0"
	git-r3_checkout "${EGIT_REPO_URI}"

	GLSLANG_REV=$(cat "${S}/glslang_revision")
	SPIRVTOOLS_REV=$(cat "${S}/spirv-tools_revision")
	SPIRVHEADERS_REV=$(cat "${S}/spirv-headers_revision")

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

src_prepare() {
	sed -i -e 's#./libVk#libVk#g' "${S}"/layers/linux/*.json || die
	eapply_user
}

src_compile() {
	einfo "Building glslang"
	cd "${S}"/external/glslang
	cmake -H. -Bbuild
	cd "${S}"/external/glslang/build
	emake || die "cannot build glslang"
	make install || die "cannot install glslang"

	einfo "Building SPIRV-Tools"
	cd "${S}"/external/spirv-tools
	cmake -H. -Bbuild
	cd "${S}"/external/spirv-tools/build
	emake || die "cannot build SPIRV-Tools"

	cd "${S}"
	cmake	\
		-DCMAKE_SKIP_RPATH=True \
		-DBUILD_WSI_XCB_SUPPORT=ON	\
		-DBUILD_WSI_XLIB_SUPPORT=ON	\
		-DBUILD_WSI_WAYLAND_SUPPORT=$(usex wayland ON OFF) \
		-DBUILD_WSI_MIR_SUPPORT=OFF	\
		-DBUILD_VKJSON=OFF \
		-DBUILD_LOADER=ON \
		-DBUILD_LAYERS=ON \
		-DBUILD_DEMOS=ON \
		-DBUILD_TESTS=OFF \
		-H. -Bbuild
	cd "${S}"/build
	emake || die "cannot build Vulkan Loader"
}

src_install() {
	mkdir -p "${D}"/etc/vulkan/{icd.d,implicit_layer.d,explicit_layer.d}
	mkdir -p "${D}"/usr/share/vulkan/{icd.d,implicit_layer.d,explicit_layer.d,demos}
	mkdir -p "${D}"/usr/$(get_libdir)/vulkan/layers
	mkdir -p "${D}"/usr/include
	mkdir -p "${D}"/etc/env.d

	#rename the tri and cube examples
	mv "${S}"/build/demos/cube "${S}"/build/demos/vulkancube
	mv "${S}"/build/demos/tri "${S}"/build/demos/vulkantri
	insinto /usr/share/vulkan/demos
	doins "${S}"/build/demos/*.spv
	doins "${S}"/build/demos/lunarg.ppm
	exeinto /usr/share/vulkan/demos
	doexe "${S}"/build/demos/vulkan{info,cube,tri}

	insinto /usr/include
	cp -R "${S}"/include/vulkan "${D}"/usr/include

	dolib.so "${S}"/build/loader/lib*.so*

	exeinto /usr/$(get_libdir)/vulkan/layers
	doexe "$S"/build/layers/lib*.so*

	insinto /usr/share/vulkan/explicit_layer.d
	doins "${S}"/layers/linux/*.json

	docinto /
	dodoc "${S}"/LICENSE.txt

	# create an entry for the newly created vulkan libs
	cat << EOF > "${D}"/etc/env.d/89vulkan
LDPATH="/usr/$(get_libdir)/vulkan;/usr/$(get_libdir)/vulkan/layers"
PATH="/usr/share/vulkan/demos"
EOF
}
