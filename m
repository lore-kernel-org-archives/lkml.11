Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A00C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Apr 2022 10:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446592AbiDVKa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Apr 2022 06:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446552AbiDVKal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:30:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4814054F82;
        Fri, 22 Apr 2022 03:27:47 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:27:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6S7DPv5g3fBjlWzfZSasYVatav/Lw7mLO2QUF6FBsfs=;
        b=0MyG9/CkTC0184JVa6iEM4gvewE2FDKR5XjJgTQpZVH1Pawx56jy4upf7cjGRywzkgBbGd
        1VKRya30aF49bE9VVwcv8nMNR1ahrFI3dBnPdggqMBNC0Gksssi08sznm1QcW1Q+2oq4Jf
        OJFkLE+DVDUOyH4z54r0EneeozoWaM6JQbGxlHJuOZs8p/GR7ol72YY6Hia8f83sffWMIz
        uMVPGQ353LKMneBl4M/Z5hNRQwcG6P50rvKFB0jOd9Dn0AWU5CvvuSI48b3DmcyG3WTeQ7
        qFaCOe+PxLxfMABv0GPVW1qmekx/mknn3lMb19htZmWv1BbzXkPYHfbu6mvnHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6S7DPv5g3fBjlWzfZSasYVatav/Lw7mLO2QUF6FBsfs=;
        b=L8rK0ZC3E7EAi3z2dtAJCmgU792+4gnF41UI6HxbcsdXPWJFMCWFe1sSPgvEoZb4de199q
        DJmHSVCVQRoUwxAQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] mailmap: Update my email address to @redhat.com
Cc:     Valentin Schneider <vschneid@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220406141315.732473-3-vschneid@redhat.com>
References: <20220406141315.732473-3-vschneid@redhat.com>
MIME-Version: 1.0
Message-ID: <165062326467.4207.12492414048611182586.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e3f73ece75a88b79d14a811cec38a350a694c69d
Gitweb:        https://git.kernel.org/tip/e3f73ece75a88b79d14a811cec38a350a69=
4c69d
Author:        Valentin Schneider <vschneid@redhat.com>
AuthorDate:    Wed, 06 Apr 2022 15:13:15 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:14:07 +02:00

mailmap: Update my email address to @redhat.com

I've brok^D contributed to a few different files in my time at Arm, so
get_maintainer.pl spits out my name from time to time when it's using the
git stats. Make that show an email address that's actually in use.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220406141315.732473-3-vschneid@redhat.com
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index b9d3582..b76882f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -391,6 +391,7 @@ Uwe Kleine-K=C3=B6nig <ukleinek@strlen.de>
 Uwe Kleine-K=C3=B6nig <ukl@pengutronix.de>
 Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
 Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
+Valentin Schneider <vschneid@redhat.com> <valentin.schneider@arm.com>
 Vinod Koul <vkoul@kernel.org> <vinod.koul@intel.com>
 Vinod Koul <vkoul@kernel.org> <vinod.koul@linux.intel.com>
 Vinod Koul <vkoul@kernel.org> <vkoul@infradead.org>
