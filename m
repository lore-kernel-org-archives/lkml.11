Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5D7C47081
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 08:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbiDEITP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 04:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbiDEIAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:00:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B28F1B6;
        Tue,  5 Apr 2022 00:58:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC016B81B14;
        Tue,  5 Apr 2022 07:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5466DC340EE;
        Tue,  5 Apr 2022 07:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649145487;
        bh=nNs1tse4V7cKeod1E45I722hiSpOa7KRDfLhaBO2H64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sXvAsWyQkNI21CcW4bwJPQQV31y7iKvOhkuWcMdQv/U5nLR08o62chI/r/19Bj1ai
         5fTtZ1pWa16egeX1+U6IUvWhETazEekwjAVRbkyTN+hwJiC6+GyciHsK6K1dBweEcr
         HPJYnunQmjuk1HeTh4bekh87UpkFlOo9+CBqqBL0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0421/1126] ARM: configs: multi_v5_defconfig: re-enable DRM_PANEL and FB_xxx
Date:   Tue,  5 Apr 2022 09:19:28 +0200
Message-Id: <20220405070419.982404175@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Przywara <andre.przywara@arm.com>

[ Upstream commit 9c44d0805f949c56121b4ae6949fb064537bf198 ]

Commit 91185d55b32e ("drm: Remove DRM_KMS_FB_HELPER Kconfig option")
led to de-selection of CONFIG_FB, which was a prerequisite for
BACKLIGHT_CLASS_DEVICE, which CONFIG_DRM_PANEL_SIMPLE depended on.
Explicitly set CONFIG_FB, to bring DRM_PANEL_SIMPLE, DRM_PANEL_EDP,
FB_IMX and FB_ATMEL back into the generated .config.
This also adds some new FB related features like fonts and the
framebuffer console.

See also commit 8c1768967e27 ("ARM: config: mutli v7: Reenable FB
dependency"), which solved the same problem for multi_v7_defconfig.

This relies on [1], to fix a broken Kconfig dependency.

[1] https://lore.kernel.org/dri-devel/20220315084559.23510-1-tzimmermann@suse.de/raw

Fixes: 91185d55b32e ("drm: Remove DRM_KMS_FB_HELPER Kconfig option")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Link: https://lore.kernel.org/r/20220317183043.948432-4-andre.przywara@arm.com'
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/configs/multi_v5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index dac1db2e181f..3e3beb0cc33d 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -197,6 +197,7 @@ CONFIG_DRM_ATMEL_HLCDC=m
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_DRM_ASPEED_GFX=m
+CONFIG_FB=y
 CONFIG_FB_IMX=y
 CONFIG_FB_ATMEL=y
 CONFIG_BACKLIGHT_ATMEL_LCDC=y
-- 
2.34.1



