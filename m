Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3964C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 15:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiGOPNp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 11:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbiGOPNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 11:13:40 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF252A1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 08:13:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VJPkRNI_1657898007;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VJPkRNI_1657898007)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 23:13:29 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     Jonathan.Cameron@Huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org, mark.rutland@arm.com
Cc:     baolin.wang@linux.alibaba.com, yaohongbo@linux.alibaba.com,
        nengchen@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        xueshuai@linux.alibaba.com
Subject: [RESEND PATCH v2 3/3] MAINTAINERS: add maintainers for Alibaba' T-Head PMU driver
Date:   Fri, 15 Jul 2022 23:13:10 +0800
Message-Id: <20220715151310.90091-4-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220617111825.92911-1-xueshuai@linux.alibaba.com>
References: <20220617111825.92911-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers for Alibaba PMU document and driver

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55114e73de26..ccddb59c253c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -733,6 +733,14 @@ S:	Maintained
 F:	Documentation/i2c/busses/i2c-ali1563.rst
 F:	drivers/i2c/busses/i2c-ali1563.c
 
+ALIBABA PMU DRIVER
+M:	Shuai Xue <xueshuai@linux.alibaba.com>
+M:	Hongbo Yao <yaohongbo@linux.alibaba.com>
+M:	Neng Chen <nengchen@linux.alibaba.com>
+S:	Supported
+F:	Documentation/admin-guide/perf/alibaba_pmu.rst
+F:	drivers/perf/alibaba_uncore_dwr_pmu.c
+
 ALIENWARE WMI DRIVER
 L:	Dell.Client.Kernel@dell.com
 S:	Maintained
-- 
2.20.1.9.gb50a0d7

