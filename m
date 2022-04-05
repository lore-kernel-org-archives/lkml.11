Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6F9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 09:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240741AbiDEJGW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238765AbiDEITW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:19:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436D672E13;
        Tue,  5 Apr 2022 01:09:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C759460A67;
        Tue,  5 Apr 2022 08:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70E8C385A0;
        Tue,  5 Apr 2022 08:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649146166;
        bh=CSM//Rz3PDHvzk+BYq71+X+1Jm1t0/cBCElyGnnl1/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eGmMHYf9v1NM6z2AiHQV+PSdWuLp0A9BYmNQDKpto5pChmsZK2iRSv7pPeGffGy1T
         WgFoKEBt+8BVsiy4V4o8uxd0P/nW6SMQ+/BkJEUlNkPEFSJJUyTU7qXElVgUo1LqTl
         5pDis95WgJrvO8TV0tnWeCFLLx/Fj9W1SemjNEDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0665/1126] USB: storage: ums-realtek: fix error code in rts51x_read_mem()
Date:   Tue,  5 Apr 2022 09:23:32 +0200
Message-Id: <20220405070427.147673909@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit b07cabb8361dc692522538205552b1b9dab134be ]

The rts51x_read_mem() function should return negative error codes.
Currently if the kmalloc() fails it returns USB_STOR_TRANSPORT_ERROR (3)
which is treated as success by the callers.

Fixes: 065e60964e29 ("ums_realtek: do not use stack memory for DMA")
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20220304073504.GA26464@kili
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/storage/realtek_cr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index 3789698d9d3c..0c423916d7bf 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -365,7 +365,7 @@ static int rts51x_read_mem(struct us_data *us, u16 addr, u8 *data, u16 len)
 
 	buf = kmalloc(len, GFP_NOIO);
 	if (buf == NULL)
-		return USB_STOR_TRANSPORT_ERROR;
+		return -ENOMEM;
 
 	usb_stor_dbg(us, "addr = 0x%x, len = %d\n", addr, len);
 
-- 
2.34.1



