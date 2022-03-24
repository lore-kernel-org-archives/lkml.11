Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF969C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 09:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349286AbiCXJfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 05:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349245AbiCXJfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:35:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F09B1D32B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB32B61857
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFCAC340F2;
        Thu, 24 Mar 2022 09:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648114443;
        bh=v78GSlOB0fD1Li7QJoWpafBJK+lD0+86JeasoYuYZuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h4H5MoC4ZJbyExCgElyCMB+HhkS274I0d5Q0lISnNoy90ViBE8mv40jyRoUsGjOLU
         Jkh994z+kTm3tYPsiU4SnIyExY6aZ1p9j8+0WhfQdfuS6PYWjDaMKhMI2tG6cWXXzf
         UioIucEzj/g5lecS1wYHUGSAqAXSWDnUjIbv7TJ0nJR5ThIhnBbxbW5ppTWHEvAjgv
         UN01JYMJ0Y0E0SPLKaI+jHS5PrZbGN+acghTDZqsgq9CSKaa5LtEiUZhFHo1QzZDXb
         +Al5r/Xp6ppfEdKT6u1hT/en/9E3HKwnRntN2cMoF0oFKfEXn7lfKIHPHvpbTbQZut
         DbFTJ55rNvHxg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 6/7] habanalabs: rephrase device out-of-memory message
Date:   Thu, 24 Mar 2022 11:33:48 +0200
Message-Id: <20220324093349.3245973-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324093349.3245973-1-ogabbay@kernel.org>
References: <20220324093349.3245973-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

The out of memory message is rephrased to more subtle expression as out
of memory may be caused by the user in case of, for example, greedy
allocation.

In addition the user is also being notified by an error code.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 5b09c15bff48..6bf5c4da99fb 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -117,7 +117,7 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 			paddr = (u64) (uintptr_t) gen_pool_alloc(vm->dram_pg_pool, total_size);
 		if (!paddr) {
 			dev_err(hdev->dev,
-				"failed to allocate %llu contiguous pages with total size of %llu\n",
+				"Cannot allocate %llu contiguous pages with total size of %llu\n",
 				num_pgs, total_size);
 			return -ENOMEM;
 		}
@@ -158,7 +158,7 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 										page_size);
 			if (!phys_pg_pack->pages[i]) {
 				dev_err(hdev->dev,
-					"Failed to allocate device memory (out of memory)\n");
+					"Cannot allocate device memory (out of memory)\n");
 				rc = -ENOMEM;
 				goto page_err;
 			}
-- 
2.25.1

