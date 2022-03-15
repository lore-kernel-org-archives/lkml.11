Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51640C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 08:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346028AbiCOId4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 04:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345981AbiCOIcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:32:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546C44C419;
        Tue, 15 Mar 2022 01:31:08 -0700 (PDT)
Date:   Tue, 15 Mar 2022 08:31:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647333067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UAIRvPHhLICHuzpmGnHhZ3b8PdOAJg3TecYBKbJl/bw=;
        b=uhtsO7O82VpidByscYeyRbcKRoRnOLipgruFFSCtfM8zFxGDd1rEA1imrlQwermyHng2PW
        +UIqX7OCgvkgeAlDhxm2ZuJyL0nIH183wnYI39PQAZcXUzkU8SgoIZ5cHloSmRxh8il6RW
        L44GTYK5uHsKRXW4snIlDcmUsF5sOKWidj1DqKRG1taLG3B5EatN1UPuCFq8V5uzM8SHyc
        y0/UINX32zKNxppDSPTRxwg+A1LGNu1PzagYZChCS6BJ0Ymn2rTTgWgwNkRn0hFxZGb+Bw
        yJo+ou5r0QKrHDMyDAGuYT/Vuqu6DWFcPeaBIBDKwO9WZ9KbujgB3S57zExNLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647333067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UAIRvPHhLICHuzpmGnHhZ3b8PdOAJg3TecYBKbJl/bw=;
        b=6eJbi4iJ7YE62jVXojY7Zah86anL1HuzAqOBgw4vwOWlBo50BkdLz1yhaGwgw6uHQJdXPO
        x7//stMiiU9DOWAA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Fix header to build standalone:
 <linux/sched_clock.h>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164733306599.16921.3819732401528699569.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d0b9d6dcaa5ac480c272683919f387cc6d82b638
Gitweb:        https://git.kernel.org/tip/d0b9d6dcaa5ac480c272683919f387cc6d82b638
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 23 Sep 2021 20:42:44 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 23 Feb 2022 08:21:32 +01:00

sched/headers: Fix header to build standalone: <linux/sched_clock.h>

Uses various kernel types that don't build standalone.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/sched_clock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/sched_clock.h b/include/linux/sched_clock.h
index 835ee87..cb41c5e 100644
--- a/include/linux/sched_clock.h
+++ b/include/linux/sched_clock.h
@@ -5,6 +5,8 @@
 #ifndef LINUX_SCHED_CLOCK
 #define LINUX_SCHED_CLOCK
 
+#include <linux/types.h>
+
 #ifdef CONFIG_GENERIC_SCHED_CLOCK
 /**
  * struct clock_read_data - data required to read from sched_clock()
