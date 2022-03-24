Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCB8C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 18:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352503AbiCXSKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 14:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbiCXSKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:10:14 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EE93B003
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:08:42 -0700 (PDT)
Message-ID: <737c7c2b-cdab-63ee-be90-cb33316c9657@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648145320; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=g8l9sjTGMmNyhr9mKMtee0/RGOsqgD0c2Wh8d+UQVOE=;
        b=dHsXE8jlt5dFwwHK/yIiUIvNmrwuEllAf1e2SH3RT+Z8xpXIzAVcaQiA+LT5CTtJJxEaM4
        sAGUlWggNKETV+DVoD/L811QWV83xEGJBqzZjpCEgc+l7NNPzxleOh5P1paWCf7Rzs9hbL
        9KsSj8Ys7PeCbjPQV0CJxcQjVxd75IM=
Date:   Thu, 24 Mar 2022 21:08:39 +0300
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
Subject: [PATCH RESEND] mailmap: update Vasily Averin's email address
Reply-To: vasily.averin@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm moving to a @linux.dev account. Map my old addresses.

Signed-off-by: Vasily Averin <vasily.averin@linux.dev>
---
resend, in previous patch Thunderbird added format=flowed
---
 .mailmap | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.mailmap b/.mailmap
index 97ccdf147111..d3a8eea4ac0c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -389,6 +389,10 @@ Uwe Kleine-König <ukleinek@strlen.de>
 Uwe Kleine-König <ukl@pengutronix.de>
 Uwe Kleine-König <Uwe.Kleine-Koenig@digi.com>
 Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
+Vasily Averin <vasily.averin@linux.dev> <vvs@virtuozzo.com>
+Vasily Averin <vasily.averin@linux.dev> <vvs@openvz.org>
+Vasily Averin <vasily.averin@linux.dev> <vvs@parallels.com>
+Vasily Averin <vasily.averin@linux.dev> <vvs@sw.ru>
 Vinod Koul <vkoul@kernel.org> <vinod.koul@intel.com>
 Vinod Koul <vkoul@kernel.org> <vinod.koul@linux.intel.com>
 Vinod Koul <vkoul@kernel.org> <vkoul@infradead.org>
-- 
2.25.1

