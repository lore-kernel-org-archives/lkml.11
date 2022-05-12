Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9C6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 08:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351440AbiELI1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 May 2022 04:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbiELI1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:27:41 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3BAA8CCFD
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:27:39 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 72CC61E80D22;
        Thu, 12 May 2022 16:22:05 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P_XuIkaqYk70; Thu, 12 May 2022 16:22:02 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 5AEB81E80D04;
        Thu, 12 May 2022 16:22:02 +0800 (CST)
From:   liqiong <liqiong@nfschina.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        liqiong <liqiong@nfschina.com>
Subject: [PATCH] mm: change "char *bdi_unknown_name" to "char bdi_unknown_name[]"
Date:   Thu, 12 May 2022 16:26:37 +0800
Message-Id: <20220512082637.24649-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"char bdi_unknown_nam[]" string form declares a single variable.
It is better then "char *bdi_unknown_name" which creates two
variables.

Signed-off-by: liqiong <liqiong@nfschina.com>
---
 mm/backing-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 7176af65b103..4982ccc63536 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -20,7 +20,7 @@ struct backing_dev_info noop_backing_dev_info;
 EXPORT_SYMBOL_GPL(noop_backing_dev_info);
 
 static struct class *bdi_class;
-static const char *bdi_unknown_name = "(unknown)";
+static const char bdi_unknown_name[] = "(unknown)";
 
 /*
  * bdi_lock protects bdi_tree and updates to bdi_list. bdi_list has RCU
-- 
2.11.0

