Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1B4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 14:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244202AbiC1PAQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 11:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244150AbiC1O76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:59:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B1FC22
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:58:16 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648479495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pv8dPye5wqKdpkd72Xtt1o/6g48q7qMfvkbKH0ypcdU=;
        b=yVW52wZDuAlUh2e5q5nj/MGD5g5xNYHDONO/qL5BPypPkzAweOQ0cUmy+agYZkaq8dKajR
        DbpDQRO6ECzhnCgcdK8s+KG/0vImpFXz9yVpzMAWWlo083Pp25F2OaSz+BLmu0IWIm2L4n
        3HaF9LqZo8ZzuKWthXvLrkgXRFcoZRVSYMG844URBKew4SVpLUfUJHDKlH9Lw2RmPao/+W
        /QiHWgFncCUDFlzczJo+RCvxN/gFoDifNYf9i3420XoaBERrU+gxV96FYC0PRirYSaRqK/
        FOSFpdH8l1lfr8BeGeTRviAQQeTI0Ca6mSY3VK3yvoR95206wEANcS94ZyhcwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648479495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pv8dPye5wqKdpkd72Xtt1o/6g48q7qMfvkbKH0ypcdU=;
        b=8jMiRFg7CoAsJEIe2nIseEoi7wD5R+VpjM7p87QuQMFqI0oDjFEYGjCQ/fVJMgdgJIefpB
        T1u+K41m8x8DVqAg==
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        boqun.feng@gmail.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH v2 3/3] Revert "mm/page_alloc: mark pagesets as __maybe_unused"
Date:   Mon, 28 Mar 2022 16:58:10 +0200
Message-Id: <20220328145810.86783-4-bigeasy@linutronix.de>
In-Reply-To: <20220328145810.86783-1-bigeasy@linutronix.de>
References: <CAHk-=wgcM9vUjGTdoCbX4DuBM+53FFmHFqYZdF8mNzATwj8z0A@mail.gmail.com>
 <20220328145810.86783-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local_lock() is now using a proper static inline function which is
enough for llvm to accept that the variable is used.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bdc8f60ae4622..634323b13cd2f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -128,7 +128,7 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
 struct pagesets {
 	local_lock_t lock;
 };
-static DEFINE_PER_CPU(struct pagesets, pagesets) __maybe_unused =3D {
+static DEFINE_PER_CPU(struct pagesets, pagesets) =3D {
 	.lock =3D INIT_LOCAL_LOCK(lock),
 };
=20
--=20
2.35.1

