Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E615C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 20:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiCDUsA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 15:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiCDUrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:47:53 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1408B3E58
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646426824; x=1677962824;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ict0jxzPJmapZnhPCTB+x92+MWtPTodSWIzHBKCsT9k=;
  b=JBfB+slyQ4HGINITT3xbbn/wlVB7OHRoF8caIKsJIwYdN2luh2tNz7df
   9KCnRUObECW/FEp11znH+gsYEER4B4OM9GJb8wGWlQTzQ+R76JFKHwmdl
   uQtlw66kHYwi3rkKltqr62ZVnXvQ1zL3+5iy/lqKrGY+R3LrM+dFfHaHS
   T7sfhnUM/NVcSdl3q0dLyOUI8vYTcybzwLAvG7AAvyj3MP/yKEZ2Fdour
   1s2wiD6UHYL/3/j07MG84h9ZwleOLZu3nRrQBU+vTUXCoVJQ/jp9D8b7E
   loYXnXqk6BjojcaOBwsBDfV0Lf5l2aC5w9OfHTQp7enmhYTup66NYZEAQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="253790540"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="253790540"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 12:47:04 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="509093700"
Received: from fushengl-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.64.239])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 12:47:04 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/dax: Fix missing kdoc for dax_device
Date:   Fri,  4 Mar 2022 12:46:55 -0800
Message-Id: <20220304204655.3489216-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

struct dax_device has a member named ops which was undocumented.

Add the kdoc.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/dax/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 5c003cc73d04..2fd3a01ba34b 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -22,6 +22,7 @@
  * @cdev: optional character interface for "device dax"
  * @private: dax driver private data
  * @flags: state and boolean properties
+ * @ops: operations for this device
  */
 struct dax_device {
 	struct inode inode;
-- 
2.35.1

