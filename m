Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B543C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 11:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbiF0L5N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238167AbiF0Lu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:50:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADEE1106;
        Mon, 27 Jun 2022 04:43:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDC1061241;
        Mon, 27 Jun 2022 11:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B719AC3411D;
        Mon, 27 Jun 2022 11:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656330215;
        bh=MI0bsniUwDkWSt13JruOm4ZUqJHUFJtapMTmtz/L4J8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6Rohf26nWFU1gudn4ypUpNukFl7nHzF4fwN06yeWdOf0IUN/FY19xf8X8IMFxtCQ
         +xBbV71PJYqi5suNE4Nda3uC675qfXHzOECvVVqatqIxvO19ouKBPlo8D0uGHuF4kP
         Mh3U/0TrSytWKV21yX8eRWFQmiFfpRgWtcCXB/RY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH 5.18 121/181] usb: chipidea: udc: check request status before setting device address
Date:   Mon, 27 Jun 2022 13:21:34 +0200
Message-Id: <20220627111948.203330169@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627111944.553492442@linuxfoundation.org>
References: <20220627111944.553492442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Yang <xu.yang_2@nxp.com>

commit b24346a240b36cfc4df194d145463874985aa29b upstream.

The complete() function may be called even though request is not
completed. In this case, it's necessary to check request status so
as not to set device address wrongly.

Fixes: 10775eb17bee ("usb: chipidea: udc: update gadget states according to ch9")
cc: <stable@vger.kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://lore.kernel.org/r/20220623030242.41796-1-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/chipidea/udc.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1048,6 +1048,9 @@ isr_setup_status_complete(struct usb_ep
 	struct ci_hdrc *ci = req->context;
 	unsigned long flags;
 
+	if (req->status < 0)
+		return;
+
 	if (ci->setaddr) {
 		hw_usb_set_address(ci, ci->address);
 		ci->setaddr = false;


