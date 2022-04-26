Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E972C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 09:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347482AbiDZJ3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 05:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347414AbiDZJFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:05:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DFD11C986;
        Tue, 26 Apr 2022 01:44:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 411D260A56;
        Tue, 26 Apr 2022 08:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43847C385B4;
        Tue, 26 Apr 2022 08:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650962677;
        bh=Zef/20gInlPkxqalUsDjt0UXGQLCnsEk4RHQO/Fp1XU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pH6YIEB/xFJh6xVcxGr0LOD9N5IV3bDlGiZ9ld2lsoVR6BX29kyErW6t2WqhzA0rM
         oc0n4vogDDhc65V1KVpbrP4bRRo8+lZ9iV8uuNhJLKg2S8YUsGdiLJ7oxTn/jKlymp
         GHTmFhMZ44xwkP6gVQJSMXuchWL+wSnfSAoW1c7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bernice Zhang <bernice.zhang@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 051/146] dmaengine: idxd: add RO check for wq max_transfer_size write
Date:   Tue, 26 Apr 2022 10:20:46 +0200
Message-Id: <20220426081751.505301430@linuxfoundation.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426081750.051179617@linuxfoundation.org>
References: <20220426081750.051179617@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

[ Upstream commit 505a2d1032ae656b0a8c736be110255503941cde ]

Block wq_max_transfer_size_store() when the device is configured as
read-only and not configurable.

Fixes: d7aad5550eca ("dmaengine: idxd: add support for configurable max wq xfer size")
Reported-by: Bernice Zhang <bernice.zhang@intel.com>
Tested-by: Bernice Zhang <bernice.zhang@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/164971488154.2200913.10706665404118545941.stgit@djiang5-desk3.ch.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/idxd/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 6c41d429bd89..dfd549685c46 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -905,6 +905,9 @@ static ssize_t wq_max_transfer_size_store(struct device *dev, struct device_attr
 	u64 xfer_size;
 	int rc;
 
+	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		return -EPERM;
+
 	if (wq->state != IDXD_WQ_DISABLED)
 		return -EPERM;
 
-- 
2.35.1



