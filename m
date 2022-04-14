Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A85C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 14:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244913AbiDNOru (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345120AbiDNNpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:45:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456C835A8E;
        Thu, 14 Apr 2022 06:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6E11612E6;
        Thu, 14 Apr 2022 13:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E5DC385A1;
        Thu, 14 Apr 2022 13:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649943751;
        bh=ZUf7VpBmN5vHuRIu7EsmmPzhhVmnABLBaydhp5XUdZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ob7X/Cmp8LO0K9mcsy+iT8zmjaQ7tDjY39VoX/N4JrcJFDrz5ObnA4kbZ50DcYdRX
         UIH3TIW6UmAwXan4GGz4CLD7B1rgVcfaMazic8LV+LQoxjwIha5BsytJlXSTQkBBcr
         Bv1fYtTZc+NwQGTDT66HFFlaYCPbbWD/UFyfOpyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Chen <markyawenchen@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Yake Yang <yake.yang@mediatek.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 218/475] Bluetooth: btmtksdio: Fix kernel oops in btmtksdio_interrupt
Date:   Thu, 14 Apr 2022 15:10:03 +0200
Message-Id: <20220414110901.223980128@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110855.141582785@linuxfoundation.org>
References: <20220414110855.141582785@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yake Yang <yake.yang@mediatek.com>

[ Upstream commit b062a0b9c1dc1ff63094337dccfe1568d5b62023 ]

Fix the following kernel oops in btmtksdio_interrrupt

[   14.339134]  btmtksdio_interrupt+0x28/0x54
[   14.339139]  process_sdio_pending_irqs+0x68/0x1a0
[   14.339144]  sdio_irq_work+0x40/0x70
[   14.339154]  process_one_work+0x184/0x39c
[   14.339160]  worker_thread+0x228/0x3e8
[   14.339168]  kthread+0x148/0x3ac
[   14.339176]  ret_from_fork+0x10/0x30

That happened because hdev->power_on is already called before
sdio_set_drvdata which btmtksdio_interrupt handler relies on is not
properly set up.

The details are shown as the below: hci_register_dev would run
queue_work(hdev->req_workqueue, &hdev->power_on) as WQ_HIGHPRI
workqueue_struct to complete the power-on sequeunce and thus hci_power_on
may run before sdio_set_drvdata is done in btmtksdio_probe.

The hci_dev_do_open in hci_power_on would initialize the device and enable
the interrupt and thus it is possible that btmtksdio_interrupt is being
called right before sdio_set_drvdata is filled out.

When btmtksdio_interrupt is being called and sdio_set_drvdata is not filled
, the kernel oops is going to happen because btmtksdio_interrupt access an
uninitialized pointer.

Fixes: 9aebfd4a2200 ("Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO devices")
Reviewed-by: Mark Chen <markyawenchen@gmail.com>
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Yake Yang <yake.yang@mediatek.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btmtksdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index c2eb64bcd5d5..0e7f44461946 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -980,6 +980,8 @@ static int btmtksdio_probe(struct sdio_func *func,
 	hdev->manufacturer = 70;
 	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 
+	sdio_set_drvdata(func, bdev);
+
 	err = hci_register_dev(hdev);
 	if (err < 0) {
 		dev_err(&func->dev, "Can't register HCI device\n");
@@ -987,8 +989,6 @@ static int btmtksdio_probe(struct sdio_func *func,
 		return err;
 	}
 
-	sdio_set_drvdata(func, bdev);
-
 	/* pm_runtime_enable would be done after the firmware is being
 	 * downloaded because the core layer probably already enables
 	 * runtime PM for this func such as the case host->caps &
-- 
2.34.1



