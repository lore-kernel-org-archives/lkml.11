Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E21CCA481
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 15:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiGKPZQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 11:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiGKPZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:25:15 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDBE252A3;
        Mon, 11 Jul 2022 08:25:13 -0700 (PDT)
Received: from andrey-lpc.intra.ispras.ru (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id 9B57140737D8;
        Mon, 11 Jul 2022 15:25:11 +0000 (UTC)
From:   Andrey Strachuk <strochuk@ispras.ru>
To:     Peter Chen <peter.chen@kernel.org>
Cc:     Andrey Strachuk <strochuk@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] usb: remove useless condition _ep_queue()
Date:   Mon, 11 Jul 2022 18:25:03 +0300
Message-Id: <20220711152503.17657-1-strochuk@ispras.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comparison of 'ep' with NULL is useless since
'ep' is a result of container_of and cannot be NULL
in any reasonable scenario.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
Fixes: 2dbc5c4c8314 ("usb: chipidea: get rid of camelcase names")
---
 drivers/usb/chipidea/udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 3b8bf6daf7d0..8ce31f9933e1 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -933,7 +933,7 @@ static int _ep_queue(struct usb_ep *ep, struct usb_request *req,
 	struct ci_hdrc *ci = hwep->ci;
 	int retval = 0;
 
-	if (ep == NULL || req == NULL || hwep->ep.desc == NULL)
+	if (req == NULL || hwep->ep.desc == NULL)
 		return -EINVAL;
 
 	if (hwep->type == USB_ENDPOINT_XFER_CONTROL) {
-- 
2.25.1

