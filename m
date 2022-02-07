Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D668DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 21:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbiBGVHt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 16:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbiBGVHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:07:21 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E471C06173B;
        Mon,  7 Feb 2022 13:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644268040; x=1675804040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jOpByrow/S4Ra6vNQIr8BnLkiWvJpMBWcQHYr5s8fsk=;
  b=ei+2o3AeK9o1+lq/LWJ9tyKVwgW2Rj5Gi9M+fqDZWe9/yKxoCk00lNPh
   dhLom3ezeLt8Zck5qJ77yN0Ja7TAWnB+QmNN7jFB1ei4uwPNaWYKpwIm9
   RRmAfAtcZZcS/PlJc1oZBsvo1tHnf0K98d+LX3pn5BvbAz6r1c6UDwCh0
   uJyH/OfaDZq4SXHyzhEaMOCjMltjmzyAquuWcJc6wRd6XTfiHzgTGfGVX
   NnXyf/QUrJ9sl8/Y/hNK7BAGB445+bmI53G9ozAuLMDD5QUKsjh8FATQS
   ZKtIiOMUKaBjqvZPgLg+zLQeo8lJGmmtHO2Y0pUN+M52ZWXuJvMJkKgCF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="312107541"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="312107541"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 13:07:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="584965863"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 07 Feb 2022 13:07:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 75CB956A; Mon,  7 Feb 2022 23:07:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v2 net-next 6/6] ptp_pch: Remove unused pch_pm_ops
Date:   Mon,  7 Feb 2022 23:07:30 +0200
Message-Id: <20220207210730.75252-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207210730.75252-1-andriy.shevchenko@linux.intel.com>
References: <20220207210730.75252-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default values for hooks in the driver.pm are NULLs.
Hence drop unused pch_pm_ops.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/ptp/ptp_pch.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/ptp/ptp_pch.c b/drivers/ptp/ptp_pch.c
index 0d2ffcca608c..7d4da9e605ef 100644
--- a/drivers/ptp/ptp_pch.c
+++ b/drivers/ptp/ptp_pch.c
@@ -447,9 +447,6 @@ static const struct ptp_clock_info ptp_pch_caps = {
 	.enable		= ptp_pch_enable,
 };
 
-#define pch_suspend NULL
-#define pch_resume NULL
-
 static void pch_remove(struct pci_dev *pdev)
 {
 	struct pch_dev *chip = pci_get_drvdata(pdev);
@@ -540,14 +537,11 @@ static const struct pci_device_id pch_ieee1588_pcidev_id[] = {
 };
 MODULE_DEVICE_TABLE(pci, pch_ieee1588_pcidev_id);
 
-static SIMPLE_DEV_PM_OPS(pch_pm_ops, pch_suspend, pch_resume);
-
 static struct pci_driver pch_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = pch_ieee1588_pcidev_id,
 	.probe = pch_probe,
 	.remove = pch_remove,
-	.driver.pm = &pch_pm_ops,
 };
 module_pci_driver(pch_driver);
 
-- 
2.34.1

