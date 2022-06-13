Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E90C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 10:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345156AbiFMKfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 06:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345046AbiFMKdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:33:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6B927FD2;
        Mon, 13 Jun 2022 03:21:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 001BACE1161;
        Mon, 13 Jun 2022 10:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2A5C34114;
        Mon, 13 Jun 2022 10:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655115715;
        bh=f4Sar/WvzR2BqS9FayKm4bduJaQEzWXxAM2xpEH8zkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=enSajT1KuwlOw9g8DaemDQjXsapOhCBI6MAuPQOBM1N50++QB4M/G1BXOnY2SNkG4
         ObRCLnNIqlNyoJEhuaGjeqptxEEjoZr7dAA7c9gPGHqIPgBqBk7JE7llf8GxHaLzmh
         38gTJ79Mi/SnSG2IJI44jMHkuLlTlrwIMpxQSo1Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Monish Kumar R <monish.kumar.r@intel.com>
Subject: [PATCH 4.14 003/218] USB: new quirk for Dell Gen 2 devices
Date:   Mon, 13 Jun 2022 12:07:41 +0200
Message-Id: <20220613094909.135439307@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220613094908.257446132@linuxfoundation.org>
References: <20220613094908.257446132@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Monish Kumar R <monish.kumar.r@intel.com>

commit 97fa5887cf283bb75ffff5f6b2c0e71794c02400 upstream.

Add USB_QUIRK_NO_LPM and USB_QUIRK_RESET_RESUME quirks for Dell usb gen
2 device to not fail during enumeration.

Found this bug on own testing

Signed-off-by: Monish Kumar R <monish.kumar.r@intel.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20220520130044.17303-1-monish.kumar.r@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -328,6 +328,9 @@ static const struct usb_device_id usb_qu
 	/* DJI CineSSD */
 	{ USB_DEVICE(0x2ca3, 0x0031), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* DELL USB GEN2 */
+	{ USB_DEVICE(0x413c, 0xb062), .driver_info = USB_QUIRK_NO_LPM | USB_QUIRK_RESET_RESUME },
+
 	/* VCOM device */
 	{ USB_DEVICE(0x4296, 0x7570), .driver_info = USB_QUIRK_CONFIG_INTF_STRINGS },
 


