Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23982C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 15:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242829AbiBQPtu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 10:49:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242848AbiBQPti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:49:38 -0500
X-Greylist: delayed 1130 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 07:49:11 PST
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D507816E7D5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1645112948;
        bh=FihfJldaJ6r2xVuFS8/jwCVqViJT/Juw+yF0fIUwbtQ=;
        h=From:To:Cc:Subject:Date;
        b=PyCiiiZPyT6dc5hTGVMfwN9D6nsF+uj5OZpluMuxCAoV0rRqt3/yen8FVcbXMPrJN
         tZ6jA/WmbJal6nTK3vbu6ytQ37l4O4swdqI3/UKxUnwEddCMsUpEdvmCmQ3/6MDLIG
         neUnxOhDzYMLrgs2v/4WnexJ8iS1pYciKheCMVcE=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id C45B0427; Thu, 17 Feb 2022 23:49:05 +0800
X-QQ-mid: xmsmtpt1645112945t18onsnd0
Message-ID: <tencent_8F1C1B14CFE19C4A05FF632068CCCBB92708@qq.com>
X-QQ-XMAILINFO: OLsBWtCIHsg697Kysr7zpcTjd0Mg8bLRDzZQyibbKfpYLc11O0ThEmPs+c8ocy
         JVD+O9Jy3tlGls7vsqwNZrYea7gkf9n+icTWah2Emuj9H84UsrRd6jnqF3o7EQ2VBJxzPwxl0GZa
         16y0aX9sAB3hophUTuMg/YkmPEpRzLWzvWgAZHKukE8zxk7aKUomASmvh9fZP/wc2Yy72wlRF9Z6
         k1LZgCmrr3ogvFTMJozE0IDKDjMxdXrzemUuCepk+WvfEp0EIFghUPLahPjM/48l0MHsvBqF4sN1
         lEu99Kp63p+eekWLUW8g/F3vlth4VyS9cCnbjZOWIyFGCshHeqtUATojGVw/e2kbn+iGiwUyDppM
         q2w3S887pJJgUgic6fEbFAVwbqowvg7nJx6roE6w3CNhg6w4OXlstXMnjuvR9cX9DYcmoJt/hcvT
         sGowFBiLg+j7Nxz/l9a2ndGzR2XebORDbANtoH6Kc/6a0FfEHkqSm9uwcxn5jDjWt1aFpAJ8O0GY
         BP94XWCqPu9dIHRviNa6REaYQR3XpAWXRccKhr1BwhR9Rbd3Tg4NpiJazDsIJ3fEt1NYu4hO0Zpd
         PwSuWNoGifLpRFs8LOTllpSHA3Rm4kStq2vXrzh1g2ApL9vjolhmQ7ugJf8KhViSnflNUUp6qbeW
         B9fmjKyhi6/Lf902hZPKp774X4lvMWQOD0tteWVodfM6LUq5YGcVcbktq/IHclH9tldEfQKil++j
         6cZ6fI8QUKQQsJW2T9O8QTnFKIw88anadllP1stEyFbqGK3M7xluZJj2qtKmIJs4qpTymqiwfSVl
         W3eJiP2ulwnsK3d6bINyLGJuR0PYtVgS7/JYj6jWdxlq5Ltf5GGbq4CgygSnElbMb+PtNiJySTqH
         8bk52Zrv9lGynKGPAz4R+jBhrDQ4ri2RcTsdipsqhF2HR6rPyf2c/ruFoMFobjvga0LetG7B+CWV
         iuw7rhTddLXS2VzDel75gZ2zuuczhZF/RLOsM7kbS4p6JvcyKsyg==
From:   xkernel.wang@foxmail.com
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH 1/2] staging: wfx: fix the error handling in wfx_init_common()
Date:   Thu, 17 Feb 2022 23:47:21 +0800
X-OQ-MSGID: <20220217154722.1226-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

All the error handlers of wfx_init_common() return without calling
ieee80211_free_hw(hw), which may result in memory leak. So I add
one err label to unify the error handlers.

Suggested-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/wfx/main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index 4b9fdf9..f83df9f 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -309,7 +309,8 @@ struct wfx_dev *wfx_init_common(struct device *dev,
 	wdev->pdata.gpio_wakeup = devm_gpiod_get_optional(dev, "wakeup",
 							  GPIOD_OUT_LOW);
 	if (IS_ERR(wdev->pdata.gpio_wakeup))
-		return NULL;
+		goto err;
+
 	if (wdev->pdata.gpio_wakeup)
 		gpiod_set_consumer_name(wdev->pdata.gpio_wakeup, "wfx wakeup");
 
@@ -325,9 +326,13 @@ struct wfx_dev *wfx_init_common(struct device *dev,
 	wdev->force_ps_timeout = -1;
 
 	if (devm_add_action_or_reset(dev, wfx_free_common, wdev))
-		return NULL;
+		goto err;
 
 	return wdev;
+
+err:
+	ieee80211_free_hw(hw);
+	return NULL;
 }
 
 int wfx_probe(struct wfx_dev *wdev)
-- 
