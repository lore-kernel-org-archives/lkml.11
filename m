Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFBAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 18:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344562AbiEaSOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 14:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346879AbiEaSO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:14:26 -0400
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71FF8CCCE
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:14:25 -0700 (PDT)
X-ASG-Debug-ID: 1654020863-1cf43917f334b000001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id oOy2yfF6AsqWuHgq; Tue, 31 May 2022 14:14:23 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=RasPjcgW3MbjOYmk499B8lRQ6/y64Pgdc8ibAu0hQ94=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=Bt5vfluu/fRwhcrHUI+Q
        RP31wdoXrw1Y6q/RDhu8jjMvd8Xv/prWojQ2sBb93UI9yWCDk8+z3hJRHrqRB9Kyl/P33NDljwTGT
        6LP6dpwARPHNZ8W9RmxQn7ynBzURXdzx83Lam9kFm87wr8w+LJVJi4f0pmJ+NCuSFMASSmTsmw=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 11829197; Tue, 31 May 2022 14:14:23 -0400
Message-ID: <f418f3c5-32b7-31c1-c91a-1bdb64b44db3@cybernetics.com>
Date:   Tue, 31 May 2022 14:14:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH 03/10] dmapool: fix boundary comparison
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH 03/10] dmapool: fix boundary comparison
From:   Tony Battersby <tonyb@cybernetics.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, kernel-team@fb.com,
        Matthew Wilcox <willy@infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tony Lindgren <tony@atomide.com>
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
In-Reply-To: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1654020863
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1388
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the boundary comparison when constructing the list of free blocks
for the case that 'size' is a power of two.  Since 'boundary' is also a
power of two, that would make 'boundary' a multiple of 'size', in which
case a single block would never cross the boundary.  This bug would
cause some of the allocated memory to be wasted (but not leaked).

Example:

size       = 512
boundary   = 2048
allocation = 4096

Address range
   0 -  511
 512 - 1023
1024 - 1535
1536 - 2047 *
2048 - 2559
2560 - 3071
3072 - 3583
3584 - 4095 *

Prior to this fix, the address ranges marked with "*" would not have
been used even though they didn't cross the given boundary.

Fixes: e34f44b3517f ("pool: Improve memory usage for devices which can't cross boundaries")
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 mm/dmapool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index d7b372248111..782143144a32 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -210,7 +210,7 @@ static void pool_initialise_page(struct dma_pool *pool, struct dma_page *page)
 
 	do {
 		unsigned int next = offset + pool->size;
-		if (unlikely((next + pool->size) >= next_boundary)) {
+		if (unlikely((next + pool->size) > next_boundary)) {
 			next = next_boundary;
 			next_boundary += pool->boundary;
 		}
-- 
2.25.1

