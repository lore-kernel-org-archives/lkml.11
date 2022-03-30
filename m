Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C31C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 12:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344649AbiC3MB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 08:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344655AbiC3LxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:53:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A492D26B3B0;
        Wed, 30 Mar 2022 04:49:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39489B81ACC;
        Wed, 30 Mar 2022 11:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F17C36AE3;
        Wed, 30 Mar 2022 11:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648640960;
        bh=NgsPTeGkD8F8eAlsIyJJJaUVdluFyLTrmkEIT4kwEvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1YpLTg7xRhr7zFmGowusGlH6Ym+JRI1MbOGMNQUPCi4pc/kGBz9Or5u//zHWeXho
         3Sc5uLa2R7GyDbqFHZpItNKMRU56XTbBuoV+KKmdSg7MuZV+kS7fAdQ2GFdpol0f8s
         xWEmcr5lRor4uD/I+k2CzkgU0GuwGwXyj1fFSmDCp1XvA4He0sqOBSsiSBIQwHMSgD
         kgr+0yK3DGF9C+IzLNBnAsCucQLEam0XrtVSGoFP3YqfQtGI0wzgeaCoudZ05H8Tbi
         1aIspoaQa/5McFmgA7rcyFYF5JXRPpeckMfjzlElO1WwpWyk181ilE0bKWowl8pg/+
         dB5fslxH/LS3A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org,
        linux@roeck-us.net
Subject: [PATCH AUTOSEL 5.16 31/59] printk: Add panic_in_progress helper
Date:   Wed, 30 Mar 2022 07:48:03 -0400
Message-Id: <20220330114831.1670235-31-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330114831.1670235-1-sashal@kernel.org>
References: <20220330114831.1670235-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Brennan <stephen.s.brennan@oracle.com>

[ Upstream commit 77498617857f68496b360081dde1a492d40c28b2 ]

This will be used help avoid deadlocks during panics. Although it would
be better to include this in linux/panic.h, it would require that header
to include linux/atomic.h as well. On some architectures, this results
in a circular dependency as well. So instead add the helper directly to
printk.c.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20220202171821.179394-2-stephen.s.brennan@oracle.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 57b132b658e1..e3d986dd49a1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -256,6 +256,11 @@ static void __up_console_sem(unsigned long ip)
 }
 #define up_console_sem() __up_console_sem(_RET_IP_)
 
+static bool panic_in_progress(void)
+{
+	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
+}
+
 /*
  * This is used for debugging the mess that is the VT code by
  * keeping track if we have the console semaphore held. It's
-- 
2.34.1

