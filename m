Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ECDC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jul 2022 03:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbiGZDF1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jul 2022 23:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiGZDFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 23:05:24 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B16165CE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 20:05:22 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.188:56264.33888729
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-10.133.8.199 (unknown [172.18.0.188])
        by chinatelecom.cn (HERMES) with SMTP id EF4292800DA;
        Tue, 26 Jul 2022 11:05:17 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.188])
        by app0023 with ESMTP id b6cd79630166451ba79e0ecc82deb6c9 for rppt@kernel.org;
        Tue, 26 Jul 2022 11:05:19 CST
X-Transaction-ID: b6cd79630166451ba79e0ecc82deb6c9
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.188
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     rppt@kernel.org, linux-mm@kvack.org, david@redhat.com
Cc:     linux-kernel@vger.kernel.org, Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH] memblock tests: compiling error
Date:   Tue, 26 Jul 2022 11:05:05 +0800
Message-Id: <1658804705-16996-1-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memblock.o: In function `memblock_find_in_range.constprop.9':
memblock.c:(.text+0x4651): undefined reference to `pr_warn_ratelimited'
memblock.o: In function `memblock_mark_mirror':
memblock.c:(.text+0x7171): undefined reference to `mirrored_kernelcore'

Fixs: 902c2d91582 ("memblock: Disable mirror feature if kernelcore is not
specified")
Fixs: 14d9a675fd0 ("mm: Ratelimited mirrored memory related warning")

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
---
 tools/testing/memblock/internal.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
index c2a492c..cf67e6e 100644
--- a/tools/testing/memblock/internal.h
+++ b/tools/testing/memblock/internal.h
@@ -9,6 +9,9 @@
 static int memblock_debug = 1;
 #endif
 
+#define pr_warn_ratelimited(fmt, ...)    printf(fmt, ##__VA_ARGS__);
+
+bool mirrored_kernelcore = false;
 struct page {};
 
 void memblock_free_pages(struct page *page, unsigned long pfn,
-- 
1.8.3.1

