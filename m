Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B41C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 06:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbiDGG0Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 02:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbiDGG0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:26:22 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984BA1F6361;
        Wed,  6 Apr 2022 23:24:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V9PYJ2X_1649312652;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V9PYJ2X_1649312652)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 07 Apr 2022 14:24:20 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] usb: gadget: u_audio: clean up some inconsistent indenting
Date:   Thu,  7 Apr 2022 14:24:10 +0800
Message-Id: <20220407062410.89214-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:

drivers/usb/gadget/function/u_audio.c:1182 g_audio_setup() warn:
inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/usb/gadget/function/u_audio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 2bb569895a90..c1f62e91b012 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -1179,8 +1179,8 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 	if (c_chmask) {
 		struct uac_rtd_params *prm = &uac->c_prm;
 
-    spin_lock_init(&prm->lock);
-    uac->c_prm.uac = uac;
+		spin_lock_init(&prm->lock);
+		uac->c_prm.uac = uac;
 		prm->max_psize = g_audio->out_ep_maxpsize;
 		prm->srate = params->c_srates[0];
 
-- 
2.20.1.7.g153144c

