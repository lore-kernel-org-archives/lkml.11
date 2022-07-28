Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55650C19F2B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jul 2022 16:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiG1Qap (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiG1Qaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:30:39 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA0CFF9;
        Thu, 28 Jul 2022 09:30:27 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id E3E7040737CF;
        Thu, 28 Jul 2022 16:30:25 +0000 (UTC)
From:   Andrey Strachuk <strochuk@ispras.ru>
To:     Peter Chen <peter.chen@kernel.org>
Cc:     Andrey Strachuk <strochuk@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH v2] usb: cdns3: change place of NULL check in cdns3_gadget_ep_enable()
Date:   Thu, 28 Jul 2022 19:30:14 +0300
Message-Id: <20220728163014.247082-1-strochuk@ispras.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <16589929667170@kroah.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'ep' is NULL, result of ep_to_cdns3_ep(ep) is invalid and
priv_ep->cdns3_dev causes panic.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
---
 drivers/usb/cdns3/cdns3-gadget.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 5c15c48952a6..51de7457a3b8 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2284,11 +2284,14 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
 	int ret = 0;
 	int val;
 
+	if (!ep)
+		return -EINVAL;
+
 	priv_ep = ep_to_cdns3_ep(ep);
 	priv_dev = priv_ep->cdns3_dev;
 	comp_desc = priv_ep->endpoint.comp_desc;
 
-	if (!ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT) {
+	if (!desc || desc->bDescriptorType != USB_DT_ENDPOINT) {
 		dev_dbg(priv_dev->dev, "usbss: invalid parameters\n");
 		return -EINVAL;
 	}
-- 
2.25.1

