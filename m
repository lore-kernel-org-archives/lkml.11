Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C8EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 09:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351716AbiDOJWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 05:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbiDOJWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:22:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C881A3AD
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:19:37 -0700 (PDT)
Message-ID: <20220415091920.956045162@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650014375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=noWWiVLpEJoThugg8Q2sCmImgY4XdCfFhEBVel656pk=;
        b=R+xxBPeZnUu0Sr99Y+kIAv5+gNnFVafzMvgCt0b+0Zf9VZjHK906ZcpZ8wvegz25nRYY89
        6TjPIaVpWwp9/e4zExnjsGyOawokOVF8KoheErZVkuYKWikNhEzhw7YMAqx0PBM+x4IGCP
        /kJvVtVMpt1AsPIUeoPDWdEepcA1zt/xUDwa7nVfDBNtDrG5mTPHkKGBdScb0xIyILflvS
        gQXgrmESjxu6qCX3h0ctEKcjDB4RBP/aliP6kDubNMz3cRc0G/lymIx3UWZgnS4B2P1/dn
        jN2VIe7bRlvDbIvBZmX3aSe20iqc8bgxtKICuHfY2LZboPH7imoxEccxysuXOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650014375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=noWWiVLpEJoThugg8Q2sCmImgY4XdCfFhEBVel656pk=;
        b=4uaoWYVBWKwpB2oDj7eU0kUNuQuDmfn4t9+DRjlqOOA2tmKQayum2Aryrd93/1Ql2iuSLy
        aWOVbbjdp9JI95Aw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [patch 1/3] timekeeping: Annotate ktime_get_boot_fast_ns() with data_race()
References: <20220415091223.187169221@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 15 Apr 2022 11:19:35 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accessing timekeeper::offset_boot in ktime_get_boot_fast_ns() is an
intended data race as the reader side cannot synchronize with a writer and
there is no space in struct tk_read_base of the NMI safe timekeeper.

Mark it so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -528,7 +528,7 @@ u64 notrace ktime_get_boot_fast_ns(void)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 
-	return (ktime_get_mono_fast_ns() + ktime_to_ns(tk->offs_boot));
+	return (ktime_get_mono_fast_ns() + ktime_to_ns(data_race(tk->offs_boot)));
 }
 EXPORT_SYMBOL_GPL(ktime_get_boot_fast_ns);
 

