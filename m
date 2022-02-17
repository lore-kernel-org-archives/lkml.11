Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CD9C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 15:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbiBQPca (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 10:32:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiBQPc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:32:28 -0500
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3072B2C73
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1645111928;
        bh=uPF+2bN3BhUMtB3HE0L6AB4knqomSQEQRNJEz5GSk+U=;
        h=From:To:Cc:Subject:Date;
        b=NWkmuglYtF0q/vQQ4rgqKYAL/4HDC6sW8XgnShBjngYePiSIFkW4u2YZwJVC+cnBj
         LLiVvDbX+Ikk+4J8+HGklPn/hg+MBUAAgGF8o8ZTi9V3RCHXgVLOdFBlWjyWHUNb3q
         GU2NLk6lCTZHBqlck4oCJy7mTH02Pf9b+/JECsQU=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza9.qq.com (NewEsmtp) with SMTP
        id 7BA1B2BD; Thu, 17 Feb 2022 23:30:58 +0800
X-QQ-mid: xmsmtpt1645111858tfvj2j1uk
Message-ID: <tencent_9C9780638BA22F9C5709F0DF190480393905@qq.com>
X-QQ-XMAILINFO: MgQY1K25Ph0m5cskmfXkJHQq2KMd2PO7D8cRZg+ulKAEXYDg5DXRAcaR5T/MV/
         ShhKupnc5u8DkDw+dO7XV/E7ZUsVJYmRZgUBBvsZIUKCV3D4LGI8lvMZzM2UhgOHR/pRFmGS9YWZ
         lYgygRfxXDHhC2i+j7pBbMC64IK32zK/9+m6KLaxGd7vyvo4NNAehqYfnm894AlR0IIMRTkCNOGO
         sUkUpuuhYHEtXWCDPl5kvLf3i6Ic8/bniQy8k2wvy5lkJhD6nk8mEmvJ0t1mV5KYxsqH9VWto23J
         bv5GzGF+PWFgMqHqL5oEaWeZ4wW1lYfFxe6DbDn9MJbKXJdNWyo/f5yRGzUv2QDY8s1yIwvD78lG
         HXIc7HrYcX4XuCpCk4UFk8hkd562cIhGtmHEI5zml+XvkpaZn9IthDIIsYF7PA6uqjX5xtxs5D31
         wS0wb0s7FSvXVSVVIZq0yJhOA8oGPBkhokZlSSheS999InZ4G/QDxCeoOUYUkJP43ujRspP+FLIh
         k2mtvx60TSGpQgMDU1G4SKsTWSi0ynHrl6laKPDaV+Eu2AaGSR8fdI0e0MnRM/ogk5FP1GCiaQsa
         sHACIYEvyG1JUZCA9jMlPepYcw1+WqEN8u2cQApJpNRqu0RrBVxIvSUUpAKH372aFsoYfeGwFVYi
         afU9MI6igF8i0hEU5YGKyy8pnCzjB1XximbGNE5O91cm8Rujgd8LY+o6YlIcmO2NStm/VPHTGsJ8
         ZMWgmIh8AeFJquvlgL0gtb/R31XjE7YPZO13z3H953m4znmgZUHtJdyiIo3mVQS7HTk1q8qMeQig
         Dq2IrMfxbf3TtWiwsNY/W2n8iiv4nrkpSWFdc06lyNLUmbSSCgHhxFSCO8F2uaQOJCZhOVYu+bU1
         U3HPY7rVlB7yqUaARTytA21bP+frAAPdYI0d0W7x1qgHidQvQ5WwDFwz9E5gYxftXch5KhyPxL
From:   xkernel.wang@foxmail.com
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v3] staging: wfx: check the return value of devm_kmalloc()
Date:   Thu, 17 Feb 2022 23:30:23 +0800
X-OQ-MSGID: <20220217153023.1050-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

devm_kmalloc() returns a pointer to allocated memory on success, NULL
on failure. While there is a memory allocation of devm_kmalloc()
without proper check. It is better to check the return value of it to
prevent wrong memory access.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
Changelog:
v2-v3 use the err label.
 drivers/staging/wfx/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index f83df9f..5d4fcc3 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -294,6 +294,9 @@ struct wfx_dev *wfx_init_common(struct device *dev,
 	hw->wiphy->n_iface_combinations = ARRAY_SIZE(wfx_iface_combinations);
 	hw->wiphy->iface_combinations = wfx_iface_combinations;
 	hw->wiphy->bands[NL80211_BAND_2GHZ] = devm_kmalloc(dev, sizeof(wfx_band_2ghz), GFP_KERNEL);
+	if (!hw->wiphy->bands[NL80211_BAND_2GHZ])
+		goto err;
+
 	// FIXME: also copy wfx_rates and wfx_2ghz_chantable
 	memcpy(hw->wiphy->bands[NL80211_BAND_2GHZ], &wfx_band_2ghz,
 	       sizeof(wfx_band_2ghz));
-- 
