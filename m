Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C05C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 11:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbiF0LmI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiF0LjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:39:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12440BE09;
        Mon, 27 Jun 2022 04:35:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BDEA60DF6;
        Mon, 27 Jun 2022 11:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BFBC341CF;
        Mon, 27 Jun 2022 11:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656329708;
        bh=hYDa6Bz31lTHXpIPhf/aJ/mFl8ah0rfXXrvW8+o6EOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pK0wZwKzPa33H21QygPbJHdYtNXU2h7h8IBmkzfejJXBPFMPNBpNvW4A9d8LQCWoQ
         bWcP5mQr+vUbu8ZnAN2c9bDY4z4Ld+zMI2yEQgNsJMDMhMme8Yslu7UiIWm28UJSTc
         Nvx94XJu02p0asKpFPlTemOYXW1SmZSJPuEnXBts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH 5.15 089/135] usb: chipidea: udc: check request status before setting device address
Date:   Mon, 27 Jun 2022 13:21:36 +0200
Message-Id: <20220627111940.741804472@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627111938.151743692@linuxfoundation.org>
References: <20220627111938.151743692@linuxfoundation.org>
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
@@ -1040,6 +1040,9 @@ isr_setup_status_complete(struct usb_ep
 	struct ci_hdrc *ci = req->context;
 	unsigned long flags;
 
+	if (req->status < 0)
+		return;
+
 	if (ci->setaddr) {
 		hw_usb_set_address(ci, ci->address);
 		ci->setaddr = false;


