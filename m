Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5F7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 11:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiBPLak (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 06:30:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiBPLag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:30:36 -0500
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94993E6DAA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1645011022;
        bh=LRvuA6zaN/7u+UfoBDNOpb1E0+Op5j/6aZVhnErHdTs=;
        h=From:To:Cc:Subject:Date;
        b=RYKaB7YJeDl4zeo9ul6XPav0gGyTeLD41x2qL/6VA1l/RIUJ1fRsjqBIVw4y9VBXv
         A1BK3tpiUiAJvbgw+9/81CaTMmVR2Xha8dpM71t2diLHQrf312KSTgtAU2ja8c+FB2
         FbK8JPbuKNT8en4oeSVBoQfZ0cwNYtAryF7E06Z4=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc11.qq.com (NewEsmtp) with SMTP
        id 7930C48A; Wed, 16 Feb 2022 19:30:19 +0800
X-QQ-mid: xmsmtpt1645011019tdpb7iu80
Message-ID: <tencent_BD0AC737C546F88052FF7F11881D3350EE06@qq.com>
X-QQ-XMAILINFO: NOIkHYnr7VzdBovMCoZOh3Dyb6OXUHZGbeNuuwU1kCDUJH+GOLSJFY1cutzjhU
         3/nnF/y7yLMI04AWSWLj9CqusdbnzxWMwLwIuD4o6qTNR1duj/4mQG7kQu0VMh7kCqnIkMDSKPFi
         lUMiFhR4gVOm9B41FxabktomW2oD5subWh7kUvgUwzU44L00w3dfcwxAsKuAXNU4h1QoBWfGHu+K
         WDgyNokPNvlt6Tm9t3uDbvqlSmRfP9Dt8UNqNMSnG9nt3sjcKHzJXrhgPTSGAAW8KNF4SWOldA71
         Ufufjsb4fenHa/egpuezFMY8XgFKly2Chj+wVIP0w+/iWzgM2UgY36qpr9n2dbhVhesoSm2OWHoF
         6YfUJExLK8kunN7T3Oi1OEv8nZLsuYTI1LbCZp2c8+OCx6WBVFmV7MyR9oLA5Zh73KMw654yk4N0
         9Xt07teQQYSAxoJLvvP2AtW80ZxWqBTShOxNI6Xe5fnztBV27wGAEuvvAh6JlStNKEnK//OPv+Tm
         9QQMWgYgQic7uSeyxmfVOLIzIaeJcGoT4gmfSI8CnUofN6IEDezJZrSjfJHFMhXYltUl9HBUN67F
         bNflc23eVNxXOx0cMT0pDCx9vSe1iryvz5Tanjv1i/dFzDu2rmFNGKNJqKY/Iq/zuXQQyeSzBNt3
         3TjFQZVm63+Ud50SZmDPyesaX9CKvn43fw9CbCgiBPiIWs9BP0RZ5S/PBBfMunE6/pHP4QoD4qkr
         kFFZfJiUSYB3/DRKxBUO+k1kTtdi68jxxPqvbWbstsG/i5Q8Uk6niYzstQ5YCnBzxePxMdLoT3lN
         atyK9KnV2rNtxnvRZl6Y4dlF1GpBlLLz4xRi55yl/fMHOUMux/xbt9dl18tYTFxtepf/K7J0PWPa
         BpBaXps6xpDS+V6ztbBW/MgYiw/4k9fg==
From:   xkernel.wang@foxmail.com
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] staging: wfx: check the return value of devm_kmalloc()
Date:   Wed, 16 Feb 2022 19:29:50 +0800
X-OQ-MSGID: <20220216112950.541-1-xkernel.wang@foxmail.com>
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
 drivers/staging/wfx/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index 4b9fdf9..0ef9225 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -294,6 +294,8 @@ struct wfx_dev *wfx_init_common(struct device *dev,
 	hw->wiphy->n_iface_combinations = ARRAY_SIZE(wfx_iface_combinations);
 	hw->wiphy->iface_combinations = wfx_iface_combinations;
 	hw->wiphy->bands[NL80211_BAND_2GHZ] = devm_kmalloc(dev, sizeof(wfx_band_2ghz), GFP_KERNEL);
+	if (!hw->wiphy->bands[NL80211_BAND_2GHZ])
+		return NULL;
 	// FIXME: also copy wfx_rates and wfx_2ghz_chantable
 	memcpy(hw->wiphy->bands[NL80211_BAND_2GHZ], &wfx_band_2ghz,
 	       sizeof(wfx_band_2ghz));
-- 
