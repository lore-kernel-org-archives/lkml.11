Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459B3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 12:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385939AbiDEMjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 08:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbiDEJDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:03:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320D410F6;
        Tue,  5 Apr 2022 01:55:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C271461476;
        Tue,  5 Apr 2022 08:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65C3C385A1;
        Tue,  5 Apr 2022 08:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148930;
        bh=gxj46xXKXGu0da1w9qPWBGPInZgSoe+vcXPqVqnPSz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RENzI8WKIpKod1a0bHyN494VVs+ertsuZAjU6rLWgcBqHspZQ0EqnfZfZCu3OC1bY
         O6YN/+r3njgCNfnwLjGpsrp7rJaZcuIKdIwW3e5VIp0/Umt2Uz+YXOaMg4ETFDpEek
         OSc407eUO8jegHLml/JAEulZGmBMe01djE41lmKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0532/1017] scsi: pm8001: Fix payload initialization in pm80xx_set_thermal_config()
Date:   Tue,  5 Apr 2022 09:24:05 +0200
Message-Id: <20220405070410.084964988@linuxfoundation.org>
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

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

[ Upstream commit bb225b12dbcc82d53d637d10b8d70b64494f8c16 ]

The fields of the set_ctrl_cfg_req structure have the __le32 type, so use
cpu_to_le32() to assign them. This removes the sparse warnings:

warning: incorrect type in assignment (different base types)
    expected restricted __le32
    got unsigned int

Link: https://lore.kernel.org/r/20220220031810.738362-8-damien.lemoal@opensource.wdc.com
Fixes: 842784e0d15b ("pm80xx: Update For Thermal Page Code")
Fixes: f5860992db55 ("[SCSI] pm80xx: Added SPCv/ve specific hardware functionalities and relevant changes in common files")
Reviewed-by: John Garry <john.garry@huawei.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index c56a726e1873..052bd97aa22b 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -1202,9 +1202,11 @@ pm80xx_set_thermal_config(struct pm8001_hba_info *pm8001_ha)
 	else
 		page_code = THERMAL_PAGE_CODE_8H;
 
-	payload.cfg_pg[0] = (THERMAL_LOG_ENABLE << 9) |
-				(THERMAL_ENABLE << 8) | page_code;
-	payload.cfg_pg[1] = (LTEMPHIL << 24) | (RTEMPHIL << 8);
+	payload.cfg_pg[0] =
+		cpu_to_le32((THERMAL_LOG_ENABLE << 9) |
+			    (THERMAL_ENABLE << 8) | page_code);
+	payload.cfg_pg[1] =
+		cpu_to_le32((LTEMPHIL << 24) | (RTEMPHIL << 8));
 
 	pm8001_dbg(pm8001_ha, DEV,
 		   "Setting up thermal config. cfg_pg 0 0x%x cfg_pg 1 0x%x\n",
-- 
2.34.1



