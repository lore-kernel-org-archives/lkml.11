Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0F4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 09:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbiCGJ1t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 04:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbiCGJZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:25:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC4559A79;
        Mon,  7 Mar 2022 01:23:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8E19ECE0E97;
        Mon,  7 Mar 2022 09:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E27C36AE5;
        Mon,  7 Mar 2022 09:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646645019;
        bh=qq75YEDYGUbl4suePRv+CRtPt1pAz6xhGh3Tvm2ubJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u1gjI1HvyN4XMyjxji9Vi+iefJ0XGu9vKEVCQuv1xI3CtjFgHt2MRHUarTn/tTuGa
         KnwEgpdnrj6eq2a40bbMKcLUlpbouzIVrsfChTkIosQWSnFiisGEFhI3qwDkj/9Cpu
         eN0Wck1lOOc2D5sTZMq9ivu8mhlDQPDL+we0qErE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH 4.19 12/51] usb: gadget: dont release an existing dev->buf
Date:   Mon,  7 Mar 2022 10:18:47 +0100
Message-Id: <20220307091637.343320282@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307091636.988950823@linuxfoundation.org>
References: <20220307091636.988950823@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangyu Hua <hbh25y@gmail.com>

commit 89f3594d0de58e8a57d92d497dea9fee3d4b9cda upstream.

dev->buf does not need to be released if it already exists before
executing dev_config.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Link: https://lore.kernel.org/r/20211231172138.7993-2-hbh25y@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/legacy/inode.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1828,8 +1828,9 @@ dev_config (struct file *fd, const char
 	spin_lock_irq (&dev->lock);
 	value = -EINVAL;
 	if (dev->buf) {
+		spin_unlock_irq(&dev->lock);
 		kfree(kbuf);
-		goto fail;
+		return value;
 	}
 	dev->buf = kbuf;
 


