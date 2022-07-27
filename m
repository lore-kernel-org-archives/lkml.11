Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5A9C00144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jul 2022 02:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbiG0CU7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jul 2022 22:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiG0CUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 22:20:55 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3749563E4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 19:20:54 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.48:55216.2067824137
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-10.133.8.199 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id 2976C2800CD;
        Wed, 27 Jul 2022 10:20:50 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.48])
        by app0024 with ESMTP id 175b2623666c4036ae33b7804f7ee35b for rppt@kernel.org;
        Wed, 27 Jul 2022 10:20:53 CST
X-Transaction-ID: 175b2623666c4036ae33b7804f7ee35b
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     rppt@kernel.org, mawupeng1@huawei.com, jrdr.linux@gmail.com,
        david@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH v2] memblock tests: compiling error
Date:   Wed, 27 Jul 2022 10:20:38 +0800
Message-Id: <1658888438-20478-1-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memblock.o: In function `memblock_find_in_range.constprop.9':
memblock.c:(.text+0x4651): undefined reference to `pr_warn_ratelimited'
memblock.o: In function `memblock_mark_mirror':
memblock.c:(.text+0x7171): undefined reference to `mirrored_kernelcore'

Fixs: commit 902c2d91582 ("memblock: Disable mirror feature if kernelcore
is not specified") and commit 14d9a675fd0 ("mm: Ratelimited mirrored memory
related warning")

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
Tested-by: Ma Wupeng <mawupeng1@huawei.com>
---
 tools/testing/memblock/internal.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
index c2a492c..fdb7f5d 100644
--- a/tools/testing/memblock/internal.h
+++ b/tools/testing/memblock/internal.h
@@ -9,6 +9,10 @@
 static int memblock_debug = 1;
 #endif
 
+#define pr_warn_ratelimited(fmt, ...)    printf(fmt, ##__VA_ARGS__)
+
+bool mirrored_kernelcore = false;
+
 struct page {};
 
 void memblock_free_pages(struct page *page, unsigned long pfn,
-- 
1.8.3.1

