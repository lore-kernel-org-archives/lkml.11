Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076D1C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 13:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbiCaNP4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 09:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236668AbiCaNPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:15:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D233EB8C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648732445; x=1680268445;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O9KnN5FcrCuHH/U+fugRxZJxjGZZZEgGbWJGo5gTUIY=;
  b=ETKq//Y5SwTZ9sOkDApdu+lwfx1X/wAaW0I6cljUkI0xnPHmGcmDT1ah
   wowkKmO0hRh+fuibAwNH4Rmc35QyBJ4+j+Dk4LqOwnuUfIZrn2q0d9lRj
   BuHiO+8eGUHSV3Yob7LZxjxUYidPjUMnM3YFjFJNyAFG4Ri7iMbdcB4dL
   O7dhsqvpGmTXSlURh1ovmRZlmzvV8PDP0+DptTLb+YS5CBw2qjK26NRVk
   TPUyZTQEX7UWzmufqa54y8IzIZ4o7GCpgpw5R6qJ6X7QQSJk97KumysFI
   u8hdlQW6DdgnpP4x+uXP7nANDI35HgINxlAvoFi54HRfShKPsyHLKGbXB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="258666013"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="258666013"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 06:14:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="547328314"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 06:14:03 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: Create kworker only for boot CPU pool prior SMP initialization
Date:   Thu, 31 Mar 2022 21:14:35 +0800
Message-Id: <20220331131435.2864347-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workqueue_init() is called before SMP initialization, which
means only the boot CPU is online, just create kworker for boot
CPU pool.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/workqueue.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index abcc9a2ac319..3948babe02d5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6120,11 +6120,9 @@ void __init workqueue_init(void)
 	mutex_unlock(&wq_pool_mutex);
 
 	/* create the initial workers */
-	for_each_online_cpu(cpu) {
-		for_each_cpu_worker_pool(pool, cpu) {
-			pool->flags &= ~POOL_DISASSOCIATED;
-			BUG_ON(!create_worker(pool));
-		}
+	for_each_cpu_worker_pool(pool, smp_processor_id()) {
+		pool->flags &= ~POOL_DISASSOCIATED;
+		BUG_ON(!create_worker(pool));
 	}
 
 	hash_for_each(unbound_pool_hash, bkt, pool, hash_node)
-- 
2.25.1

