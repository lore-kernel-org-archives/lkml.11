Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C62C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 09:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbiDLJO7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 05:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358021AbiDLHk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:40:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5463D49F;
        Tue, 12 Apr 2022 00:17:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E8D46183C;
        Tue, 12 Apr 2022 07:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F83BC385AE;
        Tue, 12 Apr 2022 07:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649747833;
        bh=kShmUKhk7LeU0JYZ+RZnv3yHp8XfKe090h2Ncf9GveQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQ/0G5VyVOHwbSKw9TXBgiSQa/sNRKbj7iS2GN0x39s9rTYCO0maf/7n1jfIJDsK3
         Cng8jI39fM82Fl7ZmBFvHzhzVrGg/6y4npVZn346cNUwp2hJ4hXzbXBXYvXXRy7VGY
         SvX+bSA8PacUAZZXllBiYCMhu5aWWYqTqFBTOs18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 195/343] Drivers: hv: vmbus: Fix potential crash on module unload
Date:   Tue, 12 Apr 2022 08:30:13 +0200
Message-Id: <20220412062956.986128622@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062951.095765152@linuxfoundation.org>
References: <20220412062951.095765152@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guilherme G. Piccoli <gpiccoli@igalia.com>

[ Upstream commit 792f232d57ff28bbd5f9c4abe0466b23d5879dc8 ]

The vmbus driver relies on the panic notifier infrastructure to perform
some operations when a panic event is detected. Since vmbus can be built
as module, it is required that the driver handles both registering and
unregistering such panic notifier callback.

After commit 74347a99e73a ("x86/Hyper-V: Unload vmbus channel in hv panic callback")
though, the panic notifier registration is done unconditionally in the module
initialization routine whereas the unregistering procedure is conditionally
guarded and executes only if HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE capability
is set.

This patch fixes that by unconditionally unregistering the panic notifier
in the module's exit routine as well.

Fixes: 74347a99e73a ("x86/Hyper-V: Unload vmbus channel in hv panic callback")
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20220315203535.682306-1-gpiccoli@igalia.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/vmbus_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 0a05e10ab36c..4bea1dfa41cd 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2781,10 +2781,15 @@ static void __exit vmbus_exit(void)
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
 		kmsg_dump_unregister(&hv_kmsg_dumper);
 		unregister_die_notifier(&hyperv_die_block);
-		atomic_notifier_chain_unregister(&panic_notifier_list,
-						 &hyperv_panic_block);
 	}
 
+	/*
+	 * The panic notifier is always registered, hence we should
+	 * also unconditionally unregister it here as well.
+	 */
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &hyperv_panic_block);
+
 	free_page((unsigned long)hv_panic_page);
 	unregister_sysctl_table(hv_ctl_table_hdr);
 	hv_ctl_table_hdr = NULL;
-- 
2.35.1



