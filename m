Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF92DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 23:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575302AbiDEXDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 19:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354783AbiDEKPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:15:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E846C93B;
        Tue,  5 Apr 2022 03:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69264616E7;
        Tue,  5 Apr 2022 10:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7023FC385A1;
        Tue,  5 Apr 2022 10:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649152971;
        bh=RM0KKzpT8cLsJyrZoDbIHvg0ONgKHvUQdCMuQWGyK5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K96x80/S/LSJC0knU6J/3iAt8q04PSZM5cnYiMCM60AGWEN5n8ImbDJUFrm11wfvT
         +JHrwEYetQ0F8DUbCEu4BmyM/nXqGTmNBaefhadEnFofjhEa3jre2fpcnzWuKrMeYw
         NySjXHwMXjmhU219ID1bIuNNiCMjCsZkmyAWa1AE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Haas <haas@ems-wuensche.com>,
        Hangyu Hua <hbh25y@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.10 055/599] can: ems_usb: ems_usb_start_xmit(): fix double dev_kfree_skb() in error path
Date:   Tue,  5 Apr 2022 09:25:49 +0200
Message-Id: <20220405070300.465505942@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangyu Hua <hbh25y@gmail.com>

commit c70222752228a62135cee3409dccefd494a24646 upstream.

There is no need to call dev_kfree_skb() when usb_submit_urb() fails
beacause can_put_echo_skb() deletes the original skb and
can_free_echo_skb() deletes the cloned skb.

Link: https://lore.kernel.org/all/20220228083639.38183-1-hbh25y@gmail.com
Fixes: 702171adeed3 ("ems_usb: Added support for EMS CPC-USB/ARM7 CAN/USB interface")
Cc: stable@vger.kernel.org
Cc: Sebastian Haas <haas@ems-wuensche.com>
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/ems_usb.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -823,7 +823,6 @@ static netdev_tx_t ems_usb_start_xmit(st
 
 		usb_unanchor_urb(urb);
 		usb_free_coherent(dev->udev, size, buf, urb->transfer_dma);
-		dev_kfree_skb(skb);
 
 		atomic_dec(&dev->active_tx_urbs);
 


