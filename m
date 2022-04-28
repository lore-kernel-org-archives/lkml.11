Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29F1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Apr 2022 20:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351792AbiD1Uae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Apr 2022 16:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiD1Uad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 16:30:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819129F3BF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2114E61E9E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 20:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B040C385A9;
        Thu, 28 Apr 2022 20:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651177636;
        bh=YKrkZHxqYNC4b47dzEJd7QF/x5JY1uUrl+Y3fepaybc=;
        h=From:To:Cc:Subject:Date:From;
        b=kwq8nLA3r2WP3nULA1nKkx5pLAHhJqFXhF6P8nAIuEbSSlwcaEL7ukk1oXB0+0tyg
         JKuI0u79uz41rcI71LnK5EH9spwnKjJ/Qb/oF/ti0Tn4SPizAzwx2WYj+3uw96po/T
         9yMkaxH3ADaiCTRE/MSBGTBzPm7YNogKCocu8h/rU/i4gMcfAsYvqKOjcrE/EoqqhH
         EZXnfS3zI3DEJ4AIcu1pDPyT7fbjz+3n11RW1KT09MFy7EnEaguCWi2kY5yvutp2Kn
         OoTnREW/82xjhELdHb9heLHM6xf4NimHnJFFZE7HjbmfPRU0GI9SSg0Z6XKx9ITaqq
         g6W+WYfg04YKQ==
From:   kbusch@kernel.org
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     willy@infradead.org, kernel-team@fb.com,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/2] dmapool performance enhancements
Date:   Thu, 28 Apr 2022 14:27:12 -0600
Message-Id: <20220428202714.17630-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Allocating and freeing blocks from the dmapool iterates a list of all
allocated pages. We can save time removing the per-alloc/free list
traversal for a constant time lookup, so this series does that.

Compared to current kernel, perf record from running io_uring benchmarks
on nvme reports dma_pool_alloc() cost reduction cut in half from 0.81% to
0.41%.

Keith Busch (2):
  mm/dmapool: replace linked list with xarray
  mm/dmapool: link blocks across pages

 mm/dmapool.c | 107 +++++++++++++++++++++++++++------------------------
 1 file changed, 56 insertions(+), 51 deletions(-)

-- 
2.30.2

