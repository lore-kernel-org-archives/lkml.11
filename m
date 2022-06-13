Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4E1C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 10:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244333AbiFMK0Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 06:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245348AbiFMKYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:24:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814A3205FA;
        Mon, 13 Jun 2022 03:18:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E50360AE7;
        Mon, 13 Jun 2022 10:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009E5C34114;
        Mon, 13 Jun 2022 10:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655115531;
        bh=w4aNFqmZ3RyZUHLp6CD9hqlFUPY2Q/FaKB24OoyPk/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pii/nKBlzwNEfOR8jtMAsZWbYpi1fm8ZMXyrHKkJd+JFOVjCzI8SJ7SSOGoMF6Zo7
         d8hceBne0ew1jzBpGGPAa1cQ7QRcoGJAQXP5/zvmYassQtlCvV9tZz6+QZgs4ixLAa
         4RIWwsEQJNviAYhWBmX2tgO2YJkJ+DeHAV+40Uqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
        Hangyu Hua <hbh25y@gmail.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 110/167] usb: usbip: fix a refcount leak in stub_probe()
Date:   Mon, 13 Jun 2022 12:09:44 +0200
Message-Id: <20220613094906.600470047@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220613094840.720778945@linuxfoundation.org>
References: <20220613094840.720778945@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangyu Hua <hbh25y@gmail.com>

[ Upstream commit 9ec4cbf1cc55d126759051acfe328d489c5d6e60 ]

usb_get_dev() is called in stub_device_alloc(). When stub_probe() fails
after that, usb_put_dev() needs to be called to release the reference.

Fix this by moving usb_put_dev() to sdev_free error path handling.

Find this by code review.

Fixes: 3ff67445750a ("usbip: fix error handling in stub_probe()")
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Link: https://lore.kernel.org/r/20220412020257.9767-1-hbh25y@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/usbip/stub_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index cec5805feb25..ca76ee4058c9 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -441,7 +441,6 @@ static int stub_probe(struct usb_device *udev)
 			     (struct usb_dev_state *) udev);
 err_port:
 	dev_set_drvdata(&udev->dev, NULL);
-	usb_put_dev(udev);
 
 	/* we already have busid_priv, just lock busid_lock */
 	spin_lock(&busid_priv->busid_lock);
@@ -456,6 +455,7 @@ static int stub_probe(struct usb_device *udev)
 	put_busid_priv(busid_priv);
 
 sdev_free:
+	usb_put_dev(udev);
 	stub_device_free(sdev);
 
 	return rc;
-- 
2.35.1



