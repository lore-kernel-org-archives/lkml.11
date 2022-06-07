Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A948BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 17:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345621AbiFGRSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 13:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345560AbiFGRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:18:35 -0400
Received: from smtp64.ord1d.emailsrvr.com (smtp64.ord1d.emailsrvr.com [184.106.54.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D36104CA7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1654622312;
        bh=euZGxOd3pxjypj1/z7N1GUIu656v2zkFAT2vpmjc2/4=;
        h=From:To:Subject:Date:From;
        b=DWKTmyC2VbSDqDcc7W0E4JTsr1+mkuZ0NK7bWf3Yff14Hj0EGkBuZJWkLOMRjwehG
         zZYcL5U0lNdWRAw8XwDY/F1qgrvrxUyrqgZ9nFuuXdUIVk3WwhW3i+DOhCJRo5tXNz
         aSqNhN4DfqzQhW8BeVV4FU+siy/1CjOK2TW4VXhM=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp9.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id F400CC0A4E;
        Tue,  7 Jun 2022 13:18:31 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Johan Hovold <johan@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v2] comedi: vmk80xx: fix expression for tx buffer size
Date:   Tue,  7 Jun 2022 18:18:19 +0100
Message-Id: <20220607171819.4121-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <d2696256-639b-4b20-3612-6dcfe68313a1@mev.co.uk>
References: <d2696256-639b-4b20-3612-6dcfe68313a1@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 72dfd4e7-ea9b-46f6-9082-6bc6c9ba8098-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The expression for setting the size of the allocated bulk TX buffer
(`devpriv->usb_tx_buf`) is calling `usb_endpoint_maxp(devpriv->ep_rx)`,
which is using the wrong endpoint (should be `devpriv->ep_tx`).  Fix it.

Fixes: a23461c47482 ("comedi: vmk80xx: fix transfer-buffer overflow")
Cc: Johan Hovold <johan@kernel.org>
Cc: stable@vger.kernel.org # 4.9+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Reviewed-by: Johan Hovold <johan@kernel.org>
---
v2: Amended Cc: stable@vger.kernel.org line to apply to 4.9+.
    Added Reviewed-by: Johan Hovold

 drivers/comedi/drivers/vmk80xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/vmk80xx.c b/drivers/comedi/drivers/vmk80xx.c
index 46023adc5395..4536ed43f65b 100644
--- a/drivers/comedi/drivers/vmk80xx.c
+++ b/drivers/comedi/drivers/vmk80xx.c
@@ -684,7 +684,7 @@ static int vmk80xx_alloc_usb_buffers(struct comedi_device *dev)
 	if (!devpriv->usb_rx_buf)
 		return -ENOMEM;
 
-	size = max(usb_endpoint_maxp(devpriv->ep_rx), MIN_BUF_SIZE);
+	size = max(usb_endpoint_maxp(devpriv->ep_tx), MIN_BUF_SIZE);
 	devpriv->usb_tx_buf = kzalloc(size, GFP_KERNEL);
 	if (!devpriv->usb_tx_buf)
 		return -ENOMEM;
-- 
2.35.1

