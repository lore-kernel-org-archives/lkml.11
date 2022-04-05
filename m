Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAE1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 23:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577987AbiDEXR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 19:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349080AbiDEJtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:49:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA26A9951;
        Tue,  5 Apr 2022 02:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35188B818F3;
        Tue,  5 Apr 2022 09:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915B2C385A1;
        Tue,  5 Apr 2022 09:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649151615;
        bh=pmz8VFRznL4qWCoGOrrIxTyP3DntmYhPsBWgkc/K+O4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jv4kdyUfQbQx9VfLwtLmLRBraBjP2aSKAERWqWq2DENO6gGyMWFeAgMUjMFFXiBK5
         UG45qrneNjYksFRGL4Ems5NOBpePw3yU/aRpegCtLJCK+c3fo05KJ5dMzrsK3plkzm
         kX26tHWMqN53QRohwAJRUQIIbZxwbWno89Vv7sac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hiral Patel <hiralpat@cisco.com>,
        Hannes Reinecke <hare@suse.de>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 479/913] scsi: fnic: Fix a tracing statement
Date:   Tue,  5 Apr 2022 09:25:41 +0200
Message-Id: <20220405070354.212134655@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070339.801210740@linuxfoundation.org>
References: <20220405070339.801210740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 3032ed77a28913203a4fe0ab8f05752331af79b3 ]

Report both the command flags and command state instead of only the
command state.

Link: https://lore.kernel.org/r/20220218195117.25689-22-bvanassche@acm.org
Fixes: 4d7007b49d52 ("[SCSI] fnic: Fnic Trace Utility")
Cc: Hiral Patel <hiralpat@cisco.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/fnic/fnic_scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index f8afbfb468dc..d084a7db3925 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -604,7 +604,7 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc, void (*done)(struct scsi_
 
 	FNIC_TRACE(fnic_queuecommand, sc->device->host->host_no,
 		  tag, sc, io_req, sg_count, cmd_trace,
-		  (((u64)CMD_FLAGS(sc) >> 32) | CMD_STATE(sc)));
+		  (((u64)CMD_FLAGS(sc) << 32) | CMD_STATE(sc)));
 
 	/* if only we issued IO, will we have the io lock */
 	if (io_lock_acquired)
-- 
2.34.1



