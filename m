Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877D9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 20:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiBYUNq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbiBYUNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:13:44 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2611181E79
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645819991; x=1677355991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/4za/Ep7RDiEGFvdsETPj/FMLR0h5FKa/IZsMHY83Kc=;
  b=Zs0dTEyYuMjz9mAzBwurObEYer5tb+DTvDdnqI0oVWQhrbGKtX0ghuGH
   wYJToeexoadcdkm6j87QVYcrSPVClyMXxqoTacdFxoTVUym40QIff3Bm7
   fKzUPRZDgMrLInlJDs+vMtVA0+8s9fB7nXFhMaZf3FwzJCJ8CdNg8M7Sw
   iPdzN2no7zOcMKkiGVd7FVMq9CHOS9V2vOfrD2iiGtxRAtfaEjyG7D8Xi
   FqYU7nqcXu9HjRcYyywENfAdLRJ7K3YmzC75wTa31SrhOTd63w550OwYi
   H/SIIfp/gULj4Xb2iwDiFlatPz7CXGuFhuYI28nqCsx/C4aU+y4KOw/2m
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="233196216"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="233196216"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 12:12:54 -0800
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="684750559"
Received: from mgelhass-mobl1.amr.corp.intel.com (HELO mvcheng-desk2.intel.com) ([10.212.211.186])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 12:12:53 -0800
From:   Michael Cheng <michael.cheng@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, michael.cheng@intel.com,
        casey.g.bowman@intel.com, lucas.demarchi@intel.com,
        wayne.boyer@intel.com, tvrtko.ursulin@linux.intel.com,
        matthew.d.roper@intel.com, geert@linux-m68k.org
Subject: [PATCH v1] Add struct folio to cacheflush.h
Date:   Fri, 25 Feb 2022 12:12:48 -0800
Message-Id: <20220225201248.984169-1-michael.cheng@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare struct folio. This will help resolve warnings on s390 and h8300
platforms.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Michael Cheng <michael.cheng@intel.com>
---
 include/linux/cacheflush.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/cacheflush.h b/include/linux/cacheflush.h
index fef8b607f97e..ea32982d6c23 100644
--- a/include/linux/cacheflush.h
+++ b/include/linux/cacheflush.h
@@ -4,6 +4,8 @@
 
 #include <asm/cacheflush.h>
 
+struct folio *folio;
+
 #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
 #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
 void flush_dcache_folio(struct folio *folio);
-- 
2.25.1

