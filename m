Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27D2C25B0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 23:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346398AbiHOXVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 19:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiHOXO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 19:14:26 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D948A1DD
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:01:28 -0700 (PDT)
X-QQ-mid: bizesmtp83t1660593663tpnp0wvf
Received: from harry-jrlc.. ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 16 Aug 2022 04:00:53 +0800 (CST)
X-QQ-SSF: 0100000000200050C000B00A0000020
X-QQ-FEAT: G46xFj+wOV8/RM5vlvGbCzRrhIGLyo2hKlMPZrEge2IifEkGss60w5+r4TXjx
        Zpl97RP/eYvnrD5vQZvkNrsUarz8q6noMGydnsjgYBVsdbnycVE5MOIphF1DKrF94nS5qSD
        8I9OQ84+AdxiPDDE/9hsAyJrEbLV14zVDXq2dwTsUldfxFNokQyuN3kuhCbSNIpZGe6AyCn
        xJA3xL6FBw6bSn2kKRGO9IHOzoUPxvUzaU7brgg90mY9WUQ7DYm3E6KVUGVibXJmveqA2p9
        WlnYw5Q5X4Lg6YBqqFsWhWtFJ3iUjOCicw8O4RdHYIht1hFVDxAijGRflrremZWThiom5X6
        rXUI0PM6VqTs0N23XjER2Thg5BrtMTb2DsRctugRZ0PwAyvBpM=
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] ARM: Fix double word in comments
Date:   Tue, 16 Aug 2022 04:00:51 +0800
Message-Id: <20220815200051.4001-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete repeated word "in" in comments.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 arch/arm/mach-pxa/palm27x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
index 1a8d25eecac3..116183859357 100644
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -160,7 +160,7 @@ void __init palm27x_lcd_init(int power, struct pxafb_mode_info *mode)
 #if	defined(CONFIG_USB_PXA27X) || \
 	defined(CONFIG_USB_PXA27X_MODULE)
 
-/* The actual GPIO offsets get filled in in the palm27x_udc_init() call */
+/* The actual GPIO offsets get filled in the palm27x_udc_init() call */
 static struct gpiod_lookup_table palm27x_udc_gpiod_table = {
 	.dev_id = "gpio-vbus",
 	.table = {
-- 
2.30.2

