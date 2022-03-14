Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE02C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 09:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbiCNJbM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 05:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238041AbiCNJ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A4944765;
        Mon, 14 Mar 2022 02:28:35 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250114;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJB+YTzoPziF4G82UaT4gwWZMTEZwEBNJf312BitiSc=;
        b=qJtbrnkvR9b5YPRPzR9s8pM30tROEFnptB55MlkO5EjzHyH1VJqI2X9+Z7ni4PBqInFWPW
        YWY7S+yfxumYnZBeZtGe7HiUTzrmJHYA8gAmnXsaYsv5tZQpElgqtMJYe1h2oC7wLDTJIO
        F5NydmT2sEH4ZkkoTSnoyaeKe9jZ3amF0YqpFbwbaoRGBfWk/HpFZdTutJqpDDS5ZXQ6HL
        Kr7fqurDMwYFQqtDWQkN1I/eTvzU9D2i28jJOjhHxaXGRWGgyU9WqT4B6Ra0h6K0WOSWE4
        O/icW1beHbwWgL3LfcCVt3mnhobyeI2tjmFtjRimiczMAvx+6i7N3u15w/MqYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250114;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJB+YTzoPziF4G82UaT4gwWZMTEZwEBNJf312BitiSc=;
        b=VG6OSZcnaO3AEIN1qba/z/B7dq2CyCrbU+JiqjM6Q2tjf+qApYfcvHNK1z7ASjObmmksj1
        R1j3JyV4qo5hacBQ==
From:   "tip-bot2 for Peng Fan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/imx-tpm: Mark two variable
 with __ro_after_init
Cc:     Peng Fan <peng.fan@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211214120737.1611955-4-peng.fan@oss.nxp.com>
References: <20211214120737.1611955-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Message-ID: <164725011348.16921.10124176531066781245.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5b3c267506eba2972d53dafb8b988d5fd28d223d
Gitweb:        https://git.kernel.org/tip/5b3c267506eba2972d53dafb8b988d5fd28d223d
Author:        Peng Fan <peng.fan@nxp.com>
AuthorDate:    Tue, 14 Dec 2021 20:07:35 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 26 Jan 2022 10:00:50 +01:00

clocksource/drivers/imx-tpm: Mark two variable with __ro_after_init

counter_width and timer_base will not be updated after init, so mark
as __ro_after_init.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/20211214120737.1611955-4-peng.fan@oss.nxp.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-tpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 2c0b0d4..3afd9b0 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -32,8 +32,8 @@
 #define TPM_C0SC_CHF_MASK		(0x1 << 7)
 #define TPM_C0V				0x24
 
-static int counter_width;
-static void __iomem *timer_base;
+static int counter_width __ro_after_init;
+static void __iomem *timer_base __ro_after_init;
 
 static inline void tpm_timer_disable(void)
 {
