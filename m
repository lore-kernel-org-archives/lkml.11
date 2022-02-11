Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CB7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Feb 2022 08:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347908AbiBKIDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Feb 2022 03:03:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346181AbiBKIDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:03:33 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0094BBF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:03:31 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V4890vr_1644566603;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V4890vr_1644566603)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Feb 2022 16:03:29 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] staging: r8188eu: remove useless if else
Date:   Fri, 11 Feb 2022 16:03:22 +0800
Message-Id: <20220211080322.80388-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow coccicheck warning:

./drivers/staging/r8188eu/hal/usb_halinit.c:1105:3-5: WARNING: possible
condition with no effect (if == else).

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 659e0f26db29..9bcbc275f043 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1102,11 +1102,7 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 				/* enable update TSF */
 				rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) & (~BIT(4)));
 			}
-			if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
-				rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_BCN);
-			} else {
-				rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_BCN);
-			}
+			rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_BCN);
 		}
 		break;
 	case HW_VAR_MLME_JOIN:
-- 
2.20.1.7.g153144c

