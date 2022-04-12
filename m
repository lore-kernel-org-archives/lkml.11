Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E93C4321E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 07:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377273AbiDLHte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 03:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353962AbiDLHQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:16:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED52C424BD;
        Mon, 11 Apr 2022 23:57:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C80B60B65;
        Tue, 12 Apr 2022 06:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D097C385A1;
        Tue, 12 Apr 2022 06:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649746671;
        bh=ar+aTTavAFPKxAyUKMRmB2Q/D3BkrrzN9zg6lFUY3/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0pyGaU0FQmEY7b+dbMOE0AZpwfe7qTa5EMKiiQ54HF6Co/h7tJGdif4YOwBXj830G
         jHlmEg9Sn1X4AAC7oLgyU5ZZn94pRmCxAECe5a24aC+y+Pt/lbfjmTEEGYEmnQdEsZ
         rPC42N1xNuYMaCASXUTFSz4+8N+MpPsAZ0CP0dDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 072/285] scsi: pm8001: Fix task leak in pm8001_send_abort_all()
Date:   Tue, 12 Apr 2022 08:28:49 +0200
Message-Id: <20220412062945.745380533@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062943.670770901@linuxfoundation.org>
References: <20220412062943.670770901@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

[ Upstream commit f90a74892f3acf0cdec5844e90fc8686ca13e7d7 ]

In pm8001_send_abort_all(), make sure to free the allocated sas task
if pm8001_tag_alloc() or pm8001_mpi_build_cmd() fail.

Link: https://lore.kernel.org/r/20220220031810.738362-21-damien.lemoal@opensource.wdc.com
Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 1b1860f305ef..7351e767b68d 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -1767,7 +1767,6 @@ static void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
 	}
 
 	task = sas_alloc_slow_task(GFP_ATOMIC);
-
 	if (!task) {
 		pm8001_dbg(pm8001_ha, FAIL, "cannot allocate task\n");
 		return;
@@ -1776,8 +1775,10 @@ static void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
 	task->task_done = pm8001_task_done;
 
 	res = pm8001_tag_alloc(pm8001_ha, &ccb_tag);
-	if (res)
+	if (res) {
+		sas_free_task(task);
 		return;
+	}
 
 	ccb = &pm8001_ha->ccb_info[ccb_tag];
 	ccb->device = pm8001_ha_dev;
@@ -1794,8 +1795,10 @@ static void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
 
 	ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &task_abort,
 			sizeof(task_abort), 0);
-	if (ret)
+	if (ret) {
+		sas_free_task(task);
 		pm8001_tag_free(pm8001_ha, ccb_tag);
+	}
 
 }
 
-- 
2.35.1



