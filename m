Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC532C2BB45
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 20:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347684AbiHOU0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 16:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346490AbiHOUUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:20:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0396C979E8;
        Mon, 15 Aug 2022 12:00:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40621B8105C;
        Mon, 15 Aug 2022 19:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98324C433C1;
        Mon, 15 Aug 2022 19:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660590050;
        bh=lg2+YsXQQBrsQ6BLKQMFy06zfZHh2gbqSTZ/yvTb1h8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3/CIWrBJiGGYCHnzeq9G3ivdPTXTr6ri1R4IENQMbmg55APL+zWWk+KLhew7IKFM
         +aS2DtqT6xdZCPMk7uMz57i6ncnjLp2BW3XkviF6noMsYXmVq8p/rZ9M+palZLKHRc
         gfkiKbda2C4GsBeEVkuQh+kyNoPP5hDEY5a2XQx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Justin Tee <justin.tee@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.18 0094/1095] scsi: lpfc: Remove extra atomic_inc on cmd_pending in queuecommand after VMID
Date:   Mon, 15 Aug 2022 19:51:33 +0200
Message-Id: <20220815180433.431250368@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180429.240518113@linuxfoundation.org>
References: <20220815180429.240518113@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

commit 0948a9c5386095baae4012190a6b65aba684a907 upstream.

VMID introduced an extra increment of cmd_pending, causing double-counting
of the I/O. The normal increment ios performed in lpfc_get_scsi_buf.

Link: https://lore.kernel.org/r/20220701211425.2708-5-jsmart2021@gmail.com
Fixes: 33c79741deaf ("scsi: lpfc: vmid: Introduce VMID in I/O path")
Cc: <stable@vger.kernel.org> # v5.14+
Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_scsi.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -5710,7 +5710,6 @@ lpfc_queuecommand(struct Scsi_Host *shos
 				cur_iocbq->cmd_flag |= LPFC_IO_VMID;
 		}
 	}
-	atomic_inc(&ndlp->cmd_pending);
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	if (unlikely(phba->hdwqstat_on & LPFC_CHECK_SCSI_IO))


