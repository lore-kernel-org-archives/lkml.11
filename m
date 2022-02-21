Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0FAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 10:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245126AbiBUKFK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 05:05:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353499AbiBUJ53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:57:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3411DA43;
        Mon, 21 Feb 2022 01:26:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36883B80EB9;
        Mon, 21 Feb 2022 09:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648EFC340E9;
        Mon, 21 Feb 2022 09:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645435582;
        bh=NlYiKCzMphCEljHl8byhWKGsGFsOAvjFrsw6xUZdgSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DTjbeO7u7bfkFWk0p1luxbIJD5KDZl08mh2ekwIxtBJSjm6aQhokeC5n+SnS1DsUM
         o4YMmEjVmTIejcnOtCOWWAXZiZ+CZ3avWoEdpIsfgJ2qAJeaw6B0Dg1l6Yno9A3fC0
         x25Uj7I2mwKSCiAtKkRDv45V9ycauXnJ6Kj6djbM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 213/227] mm: io_uring: allow oom-killer from io_uring_setup
Date:   Mon, 21 Feb 2022 09:50:32 +0100
Message-Id: <20220221084941.900619489@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084934.836145070@linuxfoundation.org>
References: <20220221084934.836145070@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shakeel Butt <shakeelb@google.com>

[ Upstream commit 0a3f1e0beacf6cc8ae5f846b0641c1df476e83d6 ]

On an overcommitted system which is running multiple workloads of
varying priorities, it is preferred to trigger an oom-killer to kill a
low priority workload than to let the high priority workload receiving
ENOMEMs. On our memory overcommitted systems, we are seeing a lot of
ENOMEMs instead of oom-kills because io_uring_setup callchain is using
__GFP_NORETRY gfp flag which avoids the oom-killer. Let's remove it and
allow the oom-killer to kill a lower priority job.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Link: https://lore.kernel.org/r/20220125051736.2981459-1-shakeelb@google.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 698db7fb62e06..a92f276f21d9c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -8872,10 +8872,9 @@ static void io_mem_free(void *ptr)
 
 static void *io_mem_alloc(size_t size)
 {
-	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_COMP |
-				__GFP_NORETRY | __GFP_ACCOUNT;
+	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN | __GFP_COMP;
 
-	return (void *) __get_free_pages(gfp_flags, get_order(size));
+	return (void *) __get_free_pages(gfp, get_order(size));
 }
 
 static unsigned long rings_size(unsigned sq_entries, unsigned cq_entries,
-- 
2.34.1



