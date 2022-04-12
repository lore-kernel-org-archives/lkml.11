Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1E8C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 07:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377194AbiDLHr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 03:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353071AbiDLHOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:14:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED99255AD;
        Mon, 11 Apr 2022 23:56:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B0A560B2B;
        Tue, 12 Apr 2022 06:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5BFC385A1;
        Tue, 12 Apr 2022 06:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649746573;
        bh=TbRJXNLQ6oxcJqYxM+ZbMOebR23pGsGpKcEgFZC/WIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HKY+/vLHL3CeQX+GZMlRQXSUvAMwVjFHVUnZ0yHZcXPbvkRcwpGD6f7K2OiGREnZy
         iEwBcBtqS04AdzlUZEK22B7dPYg99MMCec1gT9oX8bp7ZuP7LjTC73jXP4/qimGP5u
         Qh+GuDLZb2AdBo9WxU1gmW1apL5IUqFm98M0p4vU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 054/285] scsi: mpi3mr: Fix memory leaks
Date:   Tue, 12 Apr 2022 08:28:31 +0200
Message-Id: <20220412062945.230545350@linuxfoundation.org>
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

From: Sreekanth Reddy <sreekanth.reddy@broadcom.com>

[ Upstream commit d44b5fefb22e139408ae12b864da1ecb9ad9d1d2 ]

Fix memory leaks related to operational reply queue's memory segments which
are not getting freed while unloading the driver.

Link: https://lore.kernel.org/r/20220210095817.22828-9-sreekanth.reddy@broadcom.com
Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 2daf633ea295..9bb64a7b2af7 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -1275,7 +1275,7 @@ static void mpi3mr_free_op_req_q_segments(struct mpi3mr_ioc *mrioc, u16 q_idx)
 			    MPI3MR_MAX_SEG_LIST_SIZE,
 			    mrioc->req_qinfo[q_idx].q_segment_list,
 			    mrioc->req_qinfo[q_idx].q_segment_list_dma);
-			mrioc->op_reply_qinfo[q_idx].q_segment_list = NULL;
+			mrioc->req_qinfo[q_idx].q_segment_list = NULL;
 		}
 	} else
 		size = mrioc->req_qinfo[q_idx].segment_qd *
-- 
2.35.1



