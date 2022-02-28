Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDC0C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 17:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbiB1R2V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 12:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbiB1R1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:27:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127608931F;
        Mon, 28 Feb 2022 09:26:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD983B815A9;
        Mon, 28 Feb 2022 17:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED65C340E7;
        Mon, 28 Feb 2022 17:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646069190;
        bh=zZ6LiIMj7SqtEv2H37OOoIxckBagwGVvn0Vn+J1jCAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bN0mTtZCaEEDR79YuqQjSOGborQbQTPMwWUIzthgLihxWLuCdzRZFNZ/jENgdU6br
         HyQezyEjdQyBLch85vvWsaQXhTeELByHwfOv6Qnorpg7yYJ5TZsjEzRScSMY0d3GyZ
         Os01vF6JFxSeoIsg16Qd+2HiZFJcaVNuWcz52haU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.9 07/29] serial: 8250: fix error handling in of_platform_serial_probe()
Date:   Mon, 28 Feb 2022 18:23:34 +0100
Message-Id: <20220228172142.301478056@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228172141.744228435@linuxfoundation.org>
References: <20220228172141.744228435@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

commit fa9ba3acb557e444fe4a736ab654f0d0a0fbccde upstream.

clk_disable_unprepare(info->clk) is missed in of_platform_serial_probe(),
while irq_dispose_mapping(port->irq) is missed in of_platform_serial_setup().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[sudip: adjust context]
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_of.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -86,7 +86,7 @@ static int of_platform_serial_setup(stru
 	ret = of_address_to_resource(np, 0, &resource);
 	if (ret) {
 		dev_warn(&ofdev->dev, "invalid address\n");
-		goto out;
+		goto err_unprepare;
 	}
 
 	spin_lock_init(&port->lock);
@@ -132,7 +132,7 @@ static int of_platform_serial_setup(stru
 			dev_warn(&ofdev->dev, "unsupported reg-io-width (%d)\n",
 				 prop);
 			ret = -EINVAL;
-			goto out;
+			goto err_dispose;
 		}
 	}
 
@@ -162,7 +162,9 @@ static int of_platform_serial_setup(stru
 		port->handle_irq = fsl8250_handle_irq;
 
 	return 0;
-out:
+err_dispose:
+	irq_dispose_mapping(port->irq);
+err_unprepare:
 	if (info->clk)
 		clk_disable_unprepare(info->clk);
 	return ret;
@@ -194,7 +196,7 @@ static int of_platform_serial_probe(stru
 	port_type = (unsigned long)match->data;
 	ret = of_platform_serial_setup(ofdev, port_type, &port, info);
 	if (ret)
-		goto out;
+		goto err_free;
 
 	switch (port_type) {
 	case PORT_8250 ... PORT_MAX_8250:
@@ -228,15 +230,18 @@ static int of_platform_serial_probe(stru
 		break;
 	}
 	if (ret < 0)
-		goto out;
+		goto err_dispose;
 
 	info->type = port_type;
 	info->line = ret;
 	platform_set_drvdata(ofdev, info);
 	return 0;
-out:
-	kfree(info);
+err_dispose:
 	irq_dispose_mapping(port.irq);
+	if (info->clk)
+		clk_disable_unprepare(info->clk);
+err_free:
+	kfree(info);
 	return ret;
 }
 


