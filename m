Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B851C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jul 2022 16:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbiGYQAG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jul 2022 12:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiGYQAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:00:05 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0C913D6F;
        Mon, 25 Jul 2022 09:00:02 -0700 (PDT)
Received: from stanislav-HLY-WX9XX.intra.ispras.ru (unknown [46.172.12.24])
        by mail.ispras.ru (Postfix) with ESMTPSA id 2488840737DC;
        Mon, 25 Jul 2022 15:59:59 +0000 (UTC)
From:   Stanislav Goriainov <goriainov@ispras.ru>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Stanislav Goriainov <goriainov@ispras.ru>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] scripts/dtc: Fix memory leak in check_msg()
Date:   Mon, 25 Jul 2022 18:59:55 +0300
Message-Id: <20220725155955.46439-1-goriainov@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the function check_msg() is called, memory for str is allocated
via xasprintf() and xasprintf_append() (as well as for file_str),
but is not freed anywhere later (although file_str is).

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c2e7075ca830 ("scripts/dtc: Update to upstream version v1.4.7-57-gf267e674d145")
Signed-off-by: Stanislav Goriainov <goriainov@ispras.ru>
---
 scripts/dtc/checks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index 781ba1129a8e..92ffc8de6a52 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -114,6 +114,7 @@ static inline void  PRINTF(5, 6) check_msg(struct check *c, struct dt_info *dti,
 	}
 
 	fputs(str, stderr);
+	free(str);
 }
 
 #define FAIL(c, dti, node, ...)						\
-- 2.34.1

