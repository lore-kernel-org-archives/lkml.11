Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7D7C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 12:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241429AbiGSMmG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 08:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240981AbiGSMif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:38:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E140F1021;
        Tue, 19 Jul 2022 05:15:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 997D36178A;
        Tue, 19 Jul 2022 12:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E65C341C6;
        Tue, 19 Jul 2022 12:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658232910;
        bh=m9gu0DjGRQ96LhVWoEcFTazZwPnxAlfRtFgoOVeM3uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D8vGCCRIF4knq2asgdjyu6uBlJRIzoBN9VTe0OHiTIPMRaC20R2jO3IZW9IsSRkJr
         HdoCrw1lGMHAfHXTzuDnBMaFPvTQmS8rQZjx/89rBtxdOftaHff6KPO2WQSTmbz8/e
         it5HjAQc+7yQdRHrFVFm8XPgZXk1T6wFBbOHfw1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 108/167] net/tls: Check for errors in tls_device_init
Date:   Tue, 19 Jul 2022 13:54:00 +0200
Message-Id: <20220719114706.905606070@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719114656.750574879@linuxfoundation.org>
References: <20220719114656.750574879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tariq Toukan <tariqt@nvidia.com>

[ Upstream commit 3d8c51b25a235e283e37750943bbf356ef187230 ]

Add missing error checks in tls_device_init.

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Maxim Mikityanskiy <maximmi@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://lore.kernel.org/r/20220714070754.1428-1-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tls.h    | 4 ++--
 net/tls/tls_device.c | 4 ++--
 net/tls/tls_main.c   | 7 ++++++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 1fffb206f09f..bf3d63a52788 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -707,7 +707,7 @@ int tls_sw_fallback_init(struct sock *sk,
 			 struct tls_crypto_info *crypto_info);
 
 #ifdef CONFIG_TLS_DEVICE
-void tls_device_init(void);
+int tls_device_init(void);
 void tls_device_cleanup(void);
 void tls_device_sk_destruct(struct sock *sk);
 int tls_set_device_offload(struct sock *sk, struct tls_context *ctx);
@@ -727,7 +727,7 @@ static inline bool tls_is_sk_rx_device_offloaded(struct sock *sk)
 	return tls_get_ctx(sk)->rx_conf == TLS_HW;
 }
 #else
-static inline void tls_device_init(void) {}
+static inline int tls_device_init(void) { return 0; }
 static inline void tls_device_cleanup(void) {}
 
 static inline int
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f3e3d009cf1c..4775431cbd38 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1394,9 +1394,9 @@ static struct notifier_block tls_dev_notifier = {
 	.notifier_call	= tls_dev_event,
 };
 
-void __init tls_device_init(void)
+int __init tls_device_init(void)
 {
-	register_netdevice_notifier(&tls_dev_notifier);
+	return register_netdevice_notifier(&tls_dev_notifier);
 }
 
 void __exit tls_device_cleanup(void)
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 62b1c5e32bbd..a947cfb100bd 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -910,7 +910,12 @@ static int __init tls_register(void)
 	if (err)
 		return err;
 
-	tls_device_init();
+	err = tls_device_init();
+	if (err) {
+		unregister_pernet_subsys(&tls_proc_ops);
+		return err;
+	}
+
 	tcp_register_ulp(&tcp_tls_ulp_ops);
 
 	return 0;
-- 
2.35.1



