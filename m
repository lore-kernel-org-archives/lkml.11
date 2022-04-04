Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63881C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 23:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbiDDXEf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 19:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349652AbiDDXCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:02:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B8C6CA7C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 15:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 164E1B81A55
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 22:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58232C2BBE4;
        Mon,  4 Apr 2022 22:22:39 +0000 (UTC)
Date:   Mon, 4 Apr 2022 18:22:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] Bluetooth: hci_qca: Use del_timer_sync() before freeing
Message-ID: <20220404182236.1caa174e@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Resending due to cut and paste failure of email address ]

From: Steven Rostedt (Google) <rostedt@goodmis.org>

While looking at a crash report on a timer list being corrupted, which
usually happens when a timer is freed while still active. This is
commonly triggered by code calling del_timer() instead of
del_timer_sync() just before freeing.

One possible culprit is the hci_qca driver, which does exactly that.

Cc: stable@vger.kernel.org
Fixes: 0ff252c1976da ("Bluetooth: hciuart: Add support QCA chipset for
UART") Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f6e91fb432a3..73a8c72b5aae 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -696,8 +696,8 @@ static int qca_close(struct hci_uart *hu)
 	skb_queue_purge(&qca->tx_wait_q);
 	skb_queue_purge(&qca->txq);
 	skb_queue_purge(&qca->rx_memdump_q);
-	del_timer(&qca->tx_idle_timer);
-	del_timer(&qca->wake_retrans_timer);
+	del_timer_sync(&qca->tx_idle_timer);
+	del_timer_sync(&qca->wake_retrans_timer);
 	destroy_workqueue(qca->workqueue);
 	qca->hu = NULL;
 
