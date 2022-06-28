Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCECC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 22:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiF1WWI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 18:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiF1WVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:21:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013733E5E3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656454702; x=1687990702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uNe89NzUGZVurHhaeglpcfid0owgNfOq0pFWX45Dy+Y=;
  b=Dkp47wOGhYO9B59hDHcTIexnNcI+i0UDYx9lBm/tKuzlHf3gdV9CWWsg
   b9xPtCgQWEbHBrgg4w2z8JIcE2IHea4Y+qbbC/77uf+tXk0OB6oNFa8Eh
   6E/Ecz5IvQrp1YUFAPJuJ6dPWQMEIGHHmhZ4Fd2kOPhgDwPCJZNSUnNum
   uuGkJMdcUHB98SRGnFdbGUFJIYCKyqLQ5eSNwxKPaC3BasI/QmfrDz4d5
   GX/9eiFA6dxASA8eBGMMqw6B/M4tqm3IHetS+5T+3FkVy2p5iCgIJ66bY
   ynuY3I8FKszVDpphEKKSNm+bunqIEBEniTtyMltWu2tSv0gTEvUMtCAQY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="279407820"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="279407820"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 15:17:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="693301208"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jun 2022 15:17:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1B3034A9; Wed, 29 Jun 2022 01:17:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 07/11] mfd: intel_soc_pmic_bxtwc: Drop redundant ACPI_PTR()
Date:   Wed, 29 Jun 2022 01:17:43 +0300
Message-Id: <20220628221747.33956-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver depends on ACPI (via MFD_INTEL_PMC_BXT), ACPI_PTR() resolution
is always the same. Otherwise a compiler may produce a warning.

That said, the rule of thumb either ugly ifdeffery with ACPI_PTR or
none should be used in a driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
v2: added tag (Lee)

 drivers/mfd/intel_soc_pmic_bxtwc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 7c3ce440c826..f79ae0ddc495 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -573,7 +573,7 @@ static struct platform_driver bxtwc_driver = {
 	.driver	= {
 		.name	= "BXTWC PMIC",
 		.pm     = pm_sleep_ptr(&bxtwc_pm_ops),
-		.acpi_match_table = ACPI_PTR(bxtwc_acpi_ids),
+		.acpi_match_table = bxtwc_acpi_ids,
 		.dev_groups = bxtwc_groups,
 	},
 };
-- 
2.35.1

