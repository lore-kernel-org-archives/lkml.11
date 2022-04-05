Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A529C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 10:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350229AbiDEKvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 06:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240301AbiDEIbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:31:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DAD6B0B4;
        Tue,  5 Apr 2022 01:23:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52909B81B92;
        Tue,  5 Apr 2022 08:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BCEC385B3;
        Tue,  5 Apr 2022 08:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649147029;
        bh=UAK0kOTAZzJ3osgfxruwduiyoCZIcrnooyC7WYDw5bQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LyTu0x24ca7zi5e12dmMYPS3Bx8Y4lMqHlC2sAwLQNuxNQGA/zZ8Law0GZ/HEXcHj
         VvFAJ/BdarjMsP/DoORFk1YugrA3zE1C9aUibd6UMDbJcSH2koQg1dtiyEGIFcnNCP
         a2iJyceoT0Vg+pqpxWHms34XQj7UmXJoJ+nUNDbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.17 0977/1126] scsi: qla2xxx: Fix warning for missing error code
Date:   Tue,  5 Apr 2022 09:28:44 +0200
Message-Id: <20220405070436.179606239@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nilesh Javali <njavali@marvell.com>

commit 14cb838d245ae0d523b2f7804af5a02c22e79f5a upstream.

Fix smatch-reported warning message:

drivers/scsi/qla2xxx/qla_target.c:3324 qlt_xmit_response() warn: missing error
code 'res'

Link: https://lore.kernel.org/r/20220110050218.3958-12-njavali@marvell.com
Fixes: 4a8f71014b4d ("scsi: qla2xxx: Fix unmap of already freed sgl")
Cc: stable@vger.kernel.org
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_target.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -3318,6 +3318,7 @@ int qlt_xmit_response(struct qla_tgt_cmd
 			"RESET-RSP online/active/old-count/new-count = %d/%d/%d/%d.\n",
 			vha->flags.online, qla2x00_reset_active(vha),
 			cmd->reset_count, qpair->chip_reset);
+		res = 0;
 		goto out_unmap_unlock;
 	}
 


