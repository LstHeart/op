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
# echo "src-git sirpdboy-package https://github.com/siropboy/sirpdboy-package" >>./feeds.conf.default

# other
# 添加三方包，删除原有包、主题等
(
    cd package
    git clone https://github.com/siropboy/sirpdboy-package.git
    git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git
    git clone https://github.com/jerrykuku/luci-app-ttnode.git
    git clone https://github.com/jerrykuku/luci-theme-argon.git -b 18.06
    git clone https://github.com/jerrykuku/luci-app-argon-config.git
    git clone https://github.com/lisaac/luci-lib-docker.git
    git clone https://github.com/lisaac/luci-app-dockerman.git
    rm -rf lean/{samba4,luci-app-samba4,luci-theme-argon,luci-lib-docker}
)
