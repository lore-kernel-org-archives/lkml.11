Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896BDC4167B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 02:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453847AbiDFBs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 21:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573546AbiDETUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:20:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A225FEBBB9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 12:18:07 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649186285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o3JRgukglMmO5KG3MTHtMXTTOxDO0zJlnl1KoXnVry4=;
        b=YH6idxI60PCa/Ey2nVrCbgvqNLDNJ+V8mohGLkppSSBpf1kqNil6BrxfjhOmRFj6gOwCyG
        S0ejbvrwI8EL3APznBQNKNtZ+7cVl0/O92lluAU3S6E+em3sgQJCnXcLQt6s7pix2CQ3HN
        jDVo8Qq12qJoDHKw6/OBoAT+k1MqpuiT8Crbd75roXAP2kGb5/3rBB9CCPdRIZY1vMCF8v
        rLkG5wruR4LgvAr7kexkSxKk+hAgwIA/hGOD4/TCw1t/IPjwm/yZZ8Hecs+mqNK4S3cvDb
        U2SEgxhB6oLOrKU7mlOAYJb8aGlA8VZqQLo2QM4RTMWYZRp6jcXSz7XF6AtBVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649186285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o3JRgukglMmO5KG3MTHtMXTTOxDO0zJlnl1KoXnVry4=;
        b=O95sE1pfZMxm9qMhxH3pYY95CAnLCkz3C1TjKlxn4+qucrRYKP5kCXziCPMyBboSuDmPij
        inTX/+tqhvGcyTBg==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 0/2] timers: Small fixes
Date:   Tue,  5 Apr 2022 21:17:30 +0200
Message-Id: <20220405191732.7438-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This short queue fixes a missing initialization and a warning in timer
code.

Thanks,
	Anna-Maria


Anna-Maria Behnsen (2):
  timers: Initialize base::next_expiry_recalc during prepare cpu
  timers: Fix warning in __run_timers()

 kernel/time/timer.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.20.1

