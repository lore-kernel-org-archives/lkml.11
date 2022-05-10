Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42EDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 17:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348021AbiEJR3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 13:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348061AbiEJR2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:28:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504AD28B684;
        Tue, 10 May 2022 10:24:40 -0700 (PDT)
Message-ID: <20220510171254.467236056@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652203479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Ii5RNlxvnDQQWuFN2s0B0+kpFe+q3is7tLWS3xPhC14=;
        b=x8W55BvxNKs8iD0cYzy0vUTpjgqF4elNYV6dcpLX47Zeno3VZvXXDO3TdXLSWWLuTfVmcW
        qCA/Zn4Qt9ViTVG0jgDP12zQf1yeKzgXCATdMBJDTZVVCUZdwC+IZFwR8msu3kHGPnnIYj
        Z3NTiiFUCS8y/UT+FE4Hz6PcAbVNefbMGC/q/VQUAk9Ekye0inFLH2N3NRBuKz8Xn1nYoa
        ERj99F4E+v6RN/UHtaW1iwO77Bh9c5Vhjlr2PVLna2RVnK0Yf5MyhYANj13Fc+f9lVsb39
        lg6C0BjnrJMHBQMaez5E/2jJD1hxq/ZrFtEpZQlB/OPVDzma0I7V2N4AL9Unig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652203479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Ii5RNlxvnDQQWuFN2s0B0+kpFe+q3is7tLWS3xPhC14=;
        b=Kp5Fk25m8qZkvlKHlqIxGzxRCn7HXbAjkS+Ck6z2riv3EKxcOr+ltJ96+X8GP/QeZxU9Lb
        kzvO3glDL+9r2WAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [patch 02/10] clocksource/drivers/jcore: Convert to SPDX identifier
References: <20220510171003.952873904@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 10 May 2022 19:24:38 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The licensing text references explicitely the COPYING file in the kernel
base directory, which is clearly GPL version 2 only.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Rich Felker <dalias@libc.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/jcore-pit.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/clocksource/jcore-pit.c
+++ b/drivers/clocksource/jcore-pit.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * J-Core SoC PIT/clocksource driver
  *
  * Copyright (C) 2015-2016 Smart Energy Instruments, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/kernel.h>

