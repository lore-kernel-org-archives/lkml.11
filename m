Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B9AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 18:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377784AbiFVSzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 14:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359437AbiFVSyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:54:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AB1403CA;
        Wed, 22 Jun 2022 11:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655924068; x=1687460068;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b2jYdUokYSrhLLJ65hnYCKypoanrr8xEmX1WraLh+kI=;
  b=QxDib/FjCs6chtMsot8/mRBIG/brUIGygArh9I6paKWDTgekp/8WdCfD
   YEWO+BxH3Mi4JTN9g4u+oVk+BeTXUFShZcrAaeL82c1QLAsmdz0to52Gl
   Ctx9DFy1Lh//hrkN5E1Xos4OrqDBGidDqjOSei49aOK97yXbpYVb0rYi4
   sNbWJo5GXNdrZ2ED8fsw9pXWuyR1xhLCa/tjPnopT7Evp4gVyGSVVKZst
   0pSIyByXKc/oBAISwafu3wvcAdnd1axe5xcA86CF72Mjjsly38yXpB+DZ
   7kgriktACYD3iQGkJ4ib8wv5XHXW9jRRoHsTIicKZSDscNzZx0KRCkTis
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281244405"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="281244405"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 11:54:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="538592747"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2022 11:54:08 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/15] dmaengine: idxd: idxd_desc.id is now a u16
Date:   Wed, 22 Jun 2022 11:54:07 -0700
Message-Id: <20220622185407.3043638-1-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is going to be packed into the cookie. It does not need to be
negative or larger than u16.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 drivers/dma/idxd/idxd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index fed0dfc1eaa83..bd93ada32c89d 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -325,7 +325,7 @@ struct idxd_desc {
 	struct dma_async_tx_descriptor txd;
 	struct llist_node llnode;
 	struct list_head list;
-	int id;
+	u16 id;
 	int cpu;
 	struct idxd_wq *wq;
 };
-- 
2.35.1

