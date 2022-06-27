Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8785CCA47C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 03:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiF0DLt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jun 2022 23:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiF0DLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 23:11:47 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49601388F;
        Sun, 26 Jun 2022 20:11:46 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 23D241E80D5E;
        Mon, 27 Jun 2022 11:10:54 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r7PXBy4w9chS; Mon, 27 Jun 2022 11:10:51 +0800 (CST)
Received: from nfschina.com.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhounan@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 7302F1E80D11;
        Mon, 27 Jun 2022 11:10:51 +0800 (CST)
From:   zhoun <zhounan@nfschina.com>
To:     gregkh@linuxfoundation.org
Cc:     balbi@kernel.org, jakobkoschel@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        lutovinova@ispras.ru, zhounan@nfschina.com
Subject: [PATCH v2] usb: remove unnecessary mv_u3d* conversion
Date:   Sun, 26 Jun 2022 23:11:08 -0400
Message-Id: <20220627031108.12246-1-zhounan@nfschina.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <YrV2aQc8lB6wDEbE@kroah.com>
References: <YrV2aQc8lB6wDEbE@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhou nan <zhounan@nfschina.com>

remove unnecessary mv_u3d* type casting.
After analysis, the two u3d objects have the same type.

Signed-off-by: Zhou nan <zhounan@nfschina.com>
---
 drivers/usb/gadget/udc/mv_u3d_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/mv_u3d_core.c b/drivers/usb/gadget/udc/mv_u3d_core.c
index 598654a3cb41..102278a71307 100644
--- a/drivers/usb/gadget/udc/mv_u3d_core.c
+++ b/drivers/usb/gadget/udc/mv_u3d_core.c
@@ -175,7 +175,7 @@ void mv_u3d_done(struct mv_u3d_ep *ep, struct mv_u3d_req *req, int status)
 	__releases(&ep->udc->lock)
 	__acquires(&ep->udc->lock)
 {
-	struct mv_u3d *u3d = (struct mv_u3d *)ep->u3d;
+	struct mv_u3d *u3d = ep->u3d;
 
 	dev_dbg(u3d->dev, "mv_u3d_done: remove req->queue\n");
 	/* Removed the req from ep queue */
-- 
2.27.0

