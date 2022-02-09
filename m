Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EBAC43217
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 09:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbiBIJjq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 04:39:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbiBIJe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:34:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E73E05BA4E;
        Wed,  9 Feb 2022 01:34:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFF91619CB;
        Wed,  9 Feb 2022 09:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEA7C340E7;
        Wed,  9 Feb 2022 09:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644399260;
        bh=qBP7pDK7v38bL/Wj23CF1WYCYm0yN9WGAG1T7aIL6zE=;
        h=From:To:Cc:Subject:Date:From;
        b=qDFdQnbA9V2YzBLX0cgzQeybJ3NLv4bX/fW17t96oEZAdkmGUqbZafoMnZ9UPuJX+
         GJJheq411xlHA2c1PO1CbUPFYIQAoEb7jUTNEwilBE+tsNJPLPFqSGrwIuN3mZiktp
         VXaN9XqqzUpfSH+DKz2LvppPutkraGmdOQTj3bBlOIAgMtsMycy4vJIsS82bqb1Y7V
         Yr9KHChxTG7V5iIkefeucAKISsBGpu9mxGyUmeNmdpJGQK8nFvYaafFxMUCCO87xw5
         Pfm/2kSl4U9Upje/sfqq+tkb92HnBU8ViodXItq6HVvaMlCIKlVS0El3+5NJG2bz+i
         2PnNUtrimpmmQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     shy828301@gmail.com, ziy@nvidia.com, ying.huang@intel.com,
        willy@infradead.org, linux-mm@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH] migrate: Wrap CONFIG_DEVICE_PRIVATE dependent function declarations with ifdef
Date:   Wed,  9 Feb 2022 09:34:07 +0000
Message-Id: <20220209093408.21780-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'migrate_vma_{setup,pages,finalize}()' functions are defined under
CONFIG_DEVICE_PRIVATE, but their declarations are not.  This commit
wraps the declaration under the config to minimize confusion.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/migrate.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 66a34eae8cb6..f8fa7db83e23 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -162,9 +162,14 @@ struct migrate_vma {
 	unsigned long		flags;
 };
 
+#ifdef CONFIG_DEVICE_PRIVATE
+
 int migrate_vma_setup(struct migrate_vma *args);
 void migrate_vma_pages(struct migrate_vma *migrate);
 void migrate_vma_finalize(struct migrate_vma *migrate);
+
+#endif /* CONFIG_DEVICE_PRIVATE */
+
 int next_demotion_node(int node);
 
 #else /* CONFIG_MIGRATION disabled: */
-- 
2.17.1

