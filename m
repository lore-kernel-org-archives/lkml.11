Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F01C2BB41
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 09:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbiHPJCL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 05:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiHPJBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:01:30 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8580E46216
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1660633905;
  x=1692169905;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wr/E2w/JPcT8FmjOXhcd8N+UutLMOAifnscUPZC1iUg=;
  b=kpO6rLOfLeRFRLEg8NFwXO7MYwdXb7XHjUFaqrhouTq9Z0luI9u29bId
   XyGwb5Vm+Z9xMIR8eh1gGWp+9KsV5hjL+cCxIq8yDiK5dkyMokIdShb7j
   R4rywSCEKcFEVoTjDXYAJqGvI5SQq1L72lSG6MXtwkwzgTn6UdC+iPcoa
   aDL/e3Xl6tQojIDG4frFSmGFjQbR/yRPW43k3qTYuiTmhAazzAcWPebaG
   7WDZTBP4nUrqCDmFXpWcgCO1tVBYc4JuFQclgYUPlEGYa3AKmXkYM12YM
   XrbwlUvnHMJ0rPwRd/PHl1Fadk+6CX+MwyswR2jqiiiZJAw2PIWwjnA+1
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] tty: Fix lookahead_buf crash with serdev
Date:   Tue, 16 Aug 2022 09:11:41 +0200
Message-ID: <20220816071142.1128001-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not follow a NULL pointer if the tty_port_client_operations does not
implement the ->lookahead_buf() callback, which is the case with
serdev's ttyport.

Fixes: 6bb6fa6908ebd3 ("tty: Implement lookahead to process XON/XOFF timely")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/tty/tty_buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 9fdecc795b6b..a1c97d4a45fb 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -493,7 +493,8 @@ static void lookahead_bufs(struct tty_port *port, struct tty_buffer *head)
 		if (~head->flags & TTYB_NORMAL)
 			f = flag_buf_ptr(head, head->lookahead);
 
-		port->client_ops->lookahead_buf(port, p, f, count);
+		if (port->client_ops->lookahead_buf)
+			port->client_ops->lookahead_buf(port, p, f, count);
 		head->lookahead += count;
 	}
 }
-- 
2.34.1

