Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE03C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 17:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348082AbiEJR3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 13:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239763AbiEJR3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:29:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A3E274A17;
        Tue, 10 May 2022 10:24:39 -0700 (PDT)
Message-ID: <20220510171254.404209482@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652203477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=9ZBYMn5JK9NT2hXnoRLG41C7P6wsZJcG6P5zJpEcwcc=;
        b=ZrF35wz3d1IwjqnW8hvsTLFJIp0UVR4JKmJN7aGCPwfAnHO3zIC4KlLnxDhUE5ZIPGu823
        IMbAretMTPr4yiC4f7hJIZo2+EqGWNhuaboLbTYLbJmz5YreZPb/8nI7MBkHYCMI4x+wHc
        kqacTLz0jy9cc9+E/aHoP9zap6HuE5qSAv4ZDbAIisZlGGnqD7orbssL3lsZMmGYvaBhjL
        09gvoyrJN5OjVUfcW8bn5Y2mGmyrwb0ZTXaQ9dcgMr4I/54ayZnfSkKwAcLYmhUIobgIeo
        g0MGOfTdbGRti83T8N+G/D4o0K4n1N86mLcOxTIDbOez6ZRT5Hhv4FTaVGFwaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652203477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=9ZBYMn5JK9NT2hXnoRLG41C7P6wsZJcG6P5zJpEcwcc=;
        b=4m8KuB/iijC4gAnMT9YrUI4kvS86rf4kJH/bDhk35WfeANF3hexuH9Mz/oxcQd7GA3BXsN
        7/r25WVKRZ2SLIBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
Subject: [patch 01/10] clocksource/drivers/bcm_kona: Convert to SPDX identifier
References: <20220510171003.952873904@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 10 May 2022 19:24:37 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The license information clearly states GPL version 2 only. The extra text
which excludes warranties is a transcript of the corresponding GPLv2 clause
11, which is explicitely referenced for details.

So the SPDX identifier covers it completely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-spdx@vger.kernel.org
---
 drivers/clocksource/bcm_kona_timer.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

--- a/drivers/clocksource/bcm_kona_timer.c
+++ b/drivers/clocksource/bcm_kona_timer.c
@@ -1,15 +1,5 @@
-/*
- * Copyright (C) 2012 Broadcom Corporation
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2012 Broadcom Corporation
 
 #include <linux/init.h>
 #include <linux/irq.h>

