Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919C8C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 06:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348201AbiDLGq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 02:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350835AbiDLGn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:43:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3341381B0;
        Mon, 11 Apr 2022 23:36:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44AA2618C8;
        Tue, 12 Apr 2022 06:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56848C385A1;
        Tue, 12 Apr 2022 06:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649745409;
        bh=rma41m+xS7wxqcblXcOKWTwihmSCb05KPyPCQ5lDTtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DXmGJlHU7+MNRQKQDk/P+Idj6eLpToWojz8ycj0oI+zvYyywl+2i1NSbC99gdfxlK
         JylSyb/4hF6tfkrJCnHnWtbXPhMmCQHd4X/tDPdo+LeGsMRT1taXl9IHff65wadKX2
         M0z+6PqndJzdCx+oFQt4KfjNpN+encwMVFcBZXO8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Abraham <thomas.abraham@linaro.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Hyeonkook Kim <hk619.kim@samsung.com>,
        Jiri Slaby <jslaby@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 088/171] serial: samsung_tty: do not unlock port->lock for uart_write_wakeup()
Date:   Tue, 12 Apr 2022 08:29:39 +0200
Message-Id: <20220412062930.432670587@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062927.870347203@linuxfoundation.org>
References: <20220412062927.870347203@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>

[ Upstream commit 988c7c00691008ea1daaa1235680a0da49dab4e8 ]

The commit c15c3747ee32 (serial: samsung: fix potential soft lockup
during uart write) added an unlock of port->lock before
uart_write_wakeup() and a lock after it. It was always problematic to
write data from tty_ldisc_ops::write_wakeup and it was even documented
that way. We fixed the line disciplines to conform to this recently.
So if there is still a missed one, we should fix them instead of this
workaround.

On the top of that, s3c24xx_serial_tx_dma_complete() in this driver
still holds the port->lock while calling uart_write_wakeup().

So revert the wrap added by the commit above.

Cc: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Hyeonkook Kim <hk619.kim@samsung.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Link: https://lore.kernel.org/r/20220308115153.4225-1-jslaby@suse.cz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/samsung_tty.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 8ae3e03fbd8c..81faead3c4f8 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -883,11 +883,8 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 		goto out;
 	}
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
-		spin_unlock(&port->lock);
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
-		spin_lock(&port->lock);
-	}
 
 	if (uart_circ_empty(xmit))
 		s3c24xx_serial_stop_tx(port);
-- 
2.35.1



