Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A8DC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 08:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359495AbiDLIpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 04:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357328AbiDLHkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:40:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BAA2496B;
        Tue, 12 Apr 2022 00:15:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8351FB81A8F;
        Tue, 12 Apr 2022 07:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6257C385A1;
        Tue, 12 Apr 2022 07:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649747708;
        bh=X3n8AkFj/VbEyKyGxwnxLLTZbAzU7OGVumTbr82HbpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jggiz9jPox1VpuTwQixWEKz9LsvUidgGI+chUV3p4PSA7iKjzo9DT0nw/Aex56YAP
         Ug56NNATgyXvX3ZUufuA7sDp+lLI3zwpxkL77NXRBu78lmv1WsAuNRiPeR4iK5Jcwj
         Cc9KRTHnr6JiHJhH0ng+9gd/1EJi9K/ges0xHot8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 177/343] SUNRPC/xprt: async tasks mustnt block waiting for memory
Date:   Tue, 12 Apr 2022 08:29:55 +0200
Message-Id: <20220412062956.474609620@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062951.095765152@linuxfoundation.org>
References: <20220412062951.095765152@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.de>

[ Upstream commit a721035477fb5fb8abc738fbe410b07c12af3dc5 ]

When memory is short, new worker threads cannot be created and we depend
on the minimum one rpciod thread to be able to handle everything.  So it
must not block waiting for memory.

xprt_dynamic_alloc_slot can block indefinitely.  This can tie up all
workqueue threads and NFS can deadlock.  So when called from a
workqueue, set __GFP_NORETRY.

The rdma alloc_slot already does not block.  However it sets the error
to -EAGAIN suggesting this will trigger a sleep.  It does not.  As we
can see in call_reserveresult(), only -ENOMEM causes a sleep.  -EAGAIN
causes immediate retry.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprt.c               | 5 ++++-
 net/sunrpc/xprtrdma/transport.c | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 396a74974f60..75acde97d748 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1690,12 +1690,15 @@ static bool xprt_throttle_congested(struct rpc_xprt *xprt, struct rpc_task *task
 static struct rpc_rqst *xprt_dynamic_alloc_slot(struct rpc_xprt *xprt)
 {
 	struct rpc_rqst *req = ERR_PTR(-EAGAIN);
+	gfp_t gfp_mask = GFP_KERNEL;
 
 	if (xprt->num_reqs >= xprt->max_reqs)
 		goto out;
 	++xprt->num_reqs;
 	spin_unlock(&xprt->reserve_lock);
-	req = kzalloc(sizeof(struct rpc_rqst), GFP_NOFS);
+	if (current->flags & PF_WQ_WORKER)
+		gfp_mask |= __GFP_NORETRY | __GFP_NOWARN;
+	req = kzalloc(sizeof(*req), gfp_mask);
 	spin_lock(&xprt->reserve_lock);
 	if (req != NULL)
 		goto out;
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index ff78a296fa81..6b7e10e5a141 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -521,7 +521,7 @@ xprt_rdma_alloc_slot(struct rpc_xprt *xprt, struct rpc_task *task)
 	return;
 
 out_sleep:
-	task->tk_status = -EAGAIN;
+	task->tk_status = -ENOMEM;
 	xprt_add_backlog(xprt, task);
 }
 
-- 
2.35.1



