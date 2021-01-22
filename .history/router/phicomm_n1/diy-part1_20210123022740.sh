#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/op
# Description: Automatically Build OpenWrt for Phicomm-N1
# Function: Diy script (Before Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Copyright (C) 2020 https://github.com/P3TERX/Actions-OpenWrt
# Copyright (C) 2020 https://github.com/ophub/op
#========================================================================================================================

# Uncomment a feed source
sed -i 's/#src-git helloworld/src-git helloworld/g' ./feeds.conf.default
# sed -i 's/\"#src-git\"/\"src-git\"/g' feeds.conf.default

# Add a feed source
# sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
# sed -i '$a src-git sirpdboy-package https://github.com/siropboy/sirpdboy-package' ./feeds.conf.default

# other
# 删除samba、原有的argon主题、luci-lib-docker,替换最新的主题和lib-docker
rm -rf package/lean/{samba4,luci-app-samba4,luci-theme-argon,luci-lib-docker}
