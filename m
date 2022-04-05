Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F063C4167D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 12:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353186AbiDEM5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 08:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243086AbiDEJIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:08:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ED092D0D;
        Tue,  5 Apr 2022 01:57:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C791B80DA1;
        Tue,  5 Apr 2022 08:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC56C385A0;
        Tue,  5 Apr 2022 08:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649149056;
        bh=EKAYW56pgoj/fMmDPk6hd7qfExudZsuNd4gA0XItQsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=thJH/nrB7wgeiXLgUiCGzfyED0cNDGJLlFjoX6S6Lk9F/tRscTJyyZ07ioxlqjHET
         9SGQ61KSEjtFwBvzgY3nJy2bh+LqN31KGat2dd1ta/I2xi5Se0Mbs2ONngNpHtlzR4
         juBVpArxyNaMjP8woMUgl30BfjZsh1bv4AOhP+cM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yihang Li <liyihang6@hisilicon.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0551/1017] scsi: hisi_sas: Change permission of parameter prot_mask
Date:   Tue,  5 Apr 2022 09:24:24 +0200
Message-Id: <20220405070410.640136355@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

[ Upstream commit c4e070457a93705e56ed06b3910d9e5fe56d3be3 ]

Currently the permission of parameter prot_mask is 0x0, which means that
the member does not appear in sysfs. Change it as other module parameters
to 0444 for world-readable.

[mkp: s/v3/v2/]

Link: https://lore.kernel.org/r/1645703489-87194-2-git-send-email-john.garry@huawei.com
Fixes: d6a9000b81be ("scsi: hisi_sas: Add support for DIF feature for v2 hw")
Reported-by: Yihang Li <liyihang6@hisilicon.com>
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 11a44d9dd9b2..b3bdbea3c955 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -530,7 +530,7 @@ MODULE_PARM_DESC(intr_conv, "interrupt converge enable (0-1)");
 
 /* permit overriding the host protection capabilities mask (EEDP/T10 PI) */
 static int prot_mask;
-module_param(prot_mask, int, 0);
+module_param(prot_mask, int, 0444);
 MODULE_PARM_DESC(prot_mask, " host protection capabilities mask, def=0x0 ");
 
 static void debugfs_work_handler_v3_hw(struct work_struct *work);
-- 
2.34.1



