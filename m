Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798E7C00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 23:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiHOXeB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 19:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346406AbiHOX1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 19:27:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF843BA17C;
        Mon, 15 Aug 2022 13:07:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAED16068D;
        Mon, 15 Aug 2022 20:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D33C433C1;
        Mon, 15 Aug 2022 20:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660594027;
        bh=RDj5KPfi2DGB835dglTgPaPt8BgMLgpCXvMGM1nKy5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EJj2YeTiohuzD8LhKevfl7RSSX63LGzqIW0kX/CuUxJJP6CkY/1f/Q4pauFl9/0qz
         INYouWvdPhKkB7rM0f5DKBFT3h84IvvGgWPIN9PjIegrApHGTSEZz3wcv0ExG1UiUN
         o8yDVNYWV+NZEAikYNVKigPNpIn1nafocKdr0gTw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianglei Nie <niejianglei2021@163.com>,
        SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 1044/1095] mm/damon/reclaim: fix potential memory leak in damon_reclaim_init()
Date:   Mon, 15 Aug 2022 20:07:23 +0200
Message-Id: <20220815180512.274821489@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180429.240518113@linuxfoundation.org>
References: <20220815180429.240518113@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianglei Nie <niejianglei2021@163.com>

[ Upstream commit 188043c7f4f2bd662f2a55957d684fffa543e600 ]

damon_reclaim_init() allocates a memory chunk for ctx with
damon_new_ctx().  When damon_select_ops() fails, ctx is not released,
which will lead to a memory leak.

We should release the ctx with damon_destroy_ctx() when damon_select_ops()
fails to fix the memory leak.

Link: https://lkml.kernel.org/r/20220714063746.2343549-1-niejianglei2021@163.com
Fixes: 4d69c3457821 ("mm/damon/reclaim: use damon_select_ops() instead of damon_{v,p}a_set_operations()")
Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/reclaim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index e34c4d0c4d93..11982685508e 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -384,8 +384,10 @@ static int __init damon_reclaim_init(void)
 	if (!ctx)
 		return -ENOMEM;
 
-	if (damon_select_ops(ctx, DAMON_OPS_PADDR))
+	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
+		damon_destroy_ctx(ctx);
 		return -EINVAL;
+	}
 
 	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
 
-- 
2.35.1



