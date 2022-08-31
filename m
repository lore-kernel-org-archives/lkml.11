Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14A0ECAAA1
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 00:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiHaAtC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 20:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiHaAsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:48:53 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA394E601;
        Tue, 30 Aug 2022 17:48:51 -0700 (PDT)
Received: from localhost.localdomain (unknown [182.2.75.186])
        by gnuweeb.org (Postfix) with ESMTPSA id EF73580B61;
        Wed, 31 Aug 2022 00:48:47 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1661906930;
        bh=OvuSN9WlWf8PL/Y35ukpx0DjD7WXaKShXli1j8KSvhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fff4rn4OgixjfaN/v6w2QI6tzh7s4pE+GGScnaUGulPIWvh4ogOxbCW5OQHeWGybN
         3cg15BaZcwxDihi5q0lT5PEydcyFA+1XJeCJxDaujnDaB9bs7ouj7kQnUc5k6oPSHK
         AJ5aQgYTeLQdN8Fb1foRT1YAiiy4fDr149v/rVtFq0rvVFHXQDnSw3Ra4KGgfZwg8+
         zuAHzHc+iyDUsfj2fYQfjypanh5eORBopSAHvxgqLW5HpyePH1E14faFRe5uEBRnjE
         aPRA0Wf+z3Zvqz1Qpjcf+cfzTy/B8YxtIs7k9rbKiEUXJp94Mf58K3kWhtwHVDo155
         jELs2xHu41aNA==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        io-uring Mailing List <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [PATCH liburing v1 3/3] queue: Remove unnecessary goto and label
Date:   Wed, 31 Aug 2022 07:48:17 +0700
Message-Id: <20220831004449.2619220-4-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220831004449.2619220-1-ammar.faizi@intel.com>
References: <20220831004449.2619220-1-ammar.faizi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

This 'goto done' and 'done:' label are not needed, there is no cleanup
needed in this path. Simplify it. Just return 0 directly.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 src/queue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/queue.c b/src/queue.c
index 277cdcc..a670a8e 100644
--- a/src/queue.c
+++ b/src/queue.c
@@ -158,25 +158,24 @@ again:
 			cqes[i] = &ring->cq.cqes[(head & mask) << shift];
 
 		return count;
 	}
 
 	if (overflow_checked)
-		goto done;
+		return 0;
 
 	if (cq_ring_needs_flush(ring)) {
 		int flags = IORING_ENTER_GETEVENTS;
 
 		if (ring->int_flags & INT_FLAG_REG_RING)
 			flags |= IORING_ENTER_REGISTERED_RING;
 		__sys_io_uring_enter(ring->enter_ring_fd, 0, 0, flags, NULL);
 		overflow_checked = true;
 		goto again;
 	}
 
-done:
 	return 0;
 }
 
 /*
  * Sync internal state with kernel ring state on the SQ side. Returns the
  * number of pending items in the SQ ring, for the shared ring.
-- 
Ammar Faizi

