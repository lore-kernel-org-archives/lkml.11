Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8745C46467
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 09:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiDEJaN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239511AbiDEIUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:20:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336FBEA7;
        Tue,  5 Apr 2022 01:15:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D125EB81BAC;
        Tue,  5 Apr 2022 08:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168D9C385A0;
        Tue,  5 Apr 2022 08:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649146499;
        bh=ryI4nmnWCITwgMxyxAhVGbPtmN7Hf4iB4cJjnuFKMfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iopx8INei4c97ZRq0jmjbQusfwN+PZVa6sbkN17rHABhuZDjhdLDoxyb0ioro8/OP
         7c8phafzlVS7LYgA3hSD5pUTS3dDfJsqjgIVJMEDreTccUB32s88RFwNfuwbeQRD5m
         i+Yh/c/HOXmym+WebJgDMDrlz7sFX1ZSh5IYlfiY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Julius Werner <jwerner@chromium.org>,
        David Gow <davidgow@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0785/1126] firmware: google: Properly state IOMEM dependency
Date:   Tue,  5 Apr 2022 09:25:32 +0200
Message-Id: <20220405070430.616764265@linuxfoundation.org>
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

From: David Gow <davidgow@google.com>

[ Upstream commit 37fd83916da2e4cae03d350015c82a67b1b334c4 ]

The Google Coreboot implementation requires IOMEM functions
(memmremap, memunmap, devm_memremap), but does not specify this is its
Kconfig. This results in build errors when HAS_IOMEM is not set, such as
on some UML configurations:

/usr/bin/ld: drivers/firmware/google/coreboot_table.o: in function `coreboot_table_probe':
coreboot_table.c:(.text+0x311): undefined reference to `memremap'
/usr/bin/ld: coreboot_table.c:(.text+0x34e): undefined reference to `memunmap'
/usr/bin/ld: drivers/firmware/google/memconsole-coreboot.o: in function `memconsole_probe':
memconsole-coreboot.c:(.text+0x12d): undefined reference to `memremap'
/usr/bin/ld: memconsole-coreboot.c:(.text+0x17e): undefined reference to `devm_memremap'
/usr/bin/ld: memconsole-coreboot.c:(.text+0x191): undefined reference to `memunmap'
/usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_section_destroy.isra.0':
vpd.c:(.text+0x300): undefined reference to `memunmap'
/usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_section_init':
vpd.c:(.text+0x382): undefined reference to `memremap'
/usr/bin/ld: vpd.c:(.text+0x459): undefined reference to `memunmap'
/usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_probe':
vpd.c:(.text+0x59d): undefined reference to `memremap'
/usr/bin/ld: vpd.c:(.text+0x5d3): undefined reference to `memunmap'
collect2: error: ld returned 1 exit status

Fixes: a28aad66da8b ("firmware: coreboot: Collapse platform drivers into bus core")
Acked-By: anton ivanov <anton.ivanov@cambridgegreys.com>
Acked-By: Julius Werner <jwerner@chromium.org>
Signed-off-by: David Gow <davidgow@google.com>
Link: https://lore.kernel.org/r/20220225041502.1901806-1-davidgow@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/google/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index 931544c9f63d..983e07dc022e 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -21,7 +21,7 @@ config GOOGLE_SMI
 
 config GOOGLE_COREBOOT_TABLE
 	tristate "Coreboot Table Access"
-	depends on ACPI || OF
+	depends on HAS_IOMEM && (ACPI || OF)
 	help
 	  This option enables the coreboot_table module, which provides other
 	  firmware modules access to the coreboot table. The coreboot table
-- 
2.34.1



