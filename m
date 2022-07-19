Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0B4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 00:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbiGSANr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jul 2022 20:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbiGSANj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:13:39 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6752E357C9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:13:38 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658189617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1v1m9FmRS/rLhFe38ENkOT8DlGvSMLAmXg64oTGrtEU=;
        b=Hz61K3OELw7/RLdZWw95Dm+7jXjxVz3VcDfsTd0onVN5I3KbvEYRmVvTGnIYt4kbCXB3zI
        nDUflcZ3CJaUXskpg3dfvcQvb/H8iJBInxDhMlxeYmVqvSUrxSlQ2CfaEgUnyKBC8Un3hy
        3hjBfBly+wSRWoWkkOUNrcX1DP1irJM=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm v2 22/33] kasan: use virt_addr_valid in kasan_addr_to_page/slab
Date:   Tue, 19 Jul 2022 02:10:02 +0200
Message-Id: <d26fd9de4a19b0021451fdd35897efbf5acae2e5.1658189199.git.andreyknvl@google.com>
In-Reply-To: <cover.1658189199.git.andreyknvl@google.com>
References: <cover.1658189199.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Instead of open-coding the validity checks for addr in
kasan_addr_to_page/slab(), use the virt_addr_valid() helper.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- This is a new patch.
---
 mm/kasan/report.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 83f420a28c0b..570f9419b90c 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -208,14 +208,14 @@ static void print_track(struct kasan_track *track, const char *prefix)
 
 struct page *kasan_addr_to_page(const void *addr)
 {
-	if ((addr >= (void *)PAGE_OFFSET) && (addr < high_memory))
+	if (virt_addr_valid(addr))
 		return virt_to_head_page(addr);
 	return NULL;
 }
 
 struct slab *kasan_addr_to_slab(const void *addr)
 {
-	if ((addr >= (void *)PAGE_OFFSET) && (addr < high_memory))
+	if (virt_addr_valid(addr))
 		return virt_to_slab(addr);
 	return NULL;
 }
-- 
2.25.1

