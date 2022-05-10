Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC033C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 17:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348115AbiEJRaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 13:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348089AbiEJR32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:29:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577B12BF337;
        Tue, 10 May 2022 10:24:53 -0700 (PDT)
Message-ID: <20220510171254.970933294@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652203492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5wPBSS0dvNKtoaInT+j4fosEMSHU8GyJQgW0+WITvfk=;
        b=P9+ZzEuOTL3gLxRU9Q5072qdMQnrzc+f0y37X5JqTESI+NB8pTHe3lnC5eAS1dWPgrKa8/
        L3ZZEFj3xveFrifS6Psv6pV1hjY5wds3Ke8abBX3LdocnqycuVf2+8N1dKyw979tmqGOqF
        zek8xogayZG3uF0SQh7L7g1C3Wt2cIfODzALYwYY/+wZAujL2UO6QGnYbFXOPCpAkDPZhJ
        EIHqql9OtyBCwwYl/F5BVEeTBb2SRysA21zz/sZTWAxj3NxlXIy8Tc2QMfBJ9OKZUG8R6p
        RnEBEwDkLBzmt5VodeEGRe1u/aNs8coXPOUMEzwnCaRYgkJHuM3/w3sy62eWKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652203492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5wPBSS0dvNKtoaInT+j4fosEMSHU8GyJQgW0+WITvfk=;
        b=HxI8j/ecXSusR76EqO9pBzf7i2CM3nrh4NsU32qZWLd5JO0gz4WDkRlc9H8wFtphqdYGbJ
        0mtFe2xlY8UxW6Dg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-sunxi@lists.linux.dev
Subject: [patch 10/10] clocksource/drivers/timer-sun5i: Convert to SPDX identifier
References: <20220510171003.952873904@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 10 May 2022 19:24:51 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The license information clearly states GPL version 2 only. The extra text
which excludes warranties is an excerpt of the corresponding GPLv2 clause
11.

So the SPDX identifier covers it completely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-sunxi@lists.linux.dev
---
 drivers/clocksource/timer-sun5i.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Allwinner SoCs hstimer driver.
  *
  * Copyright (C) 2013 Maxime Ripard
  *
  * Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/clk.h>

