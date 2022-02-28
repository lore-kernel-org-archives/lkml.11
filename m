Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E68FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 17:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbiB1RqP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 12:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238819AbiB1RnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:43:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7358F888C6;
        Mon, 28 Feb 2022 09:35:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22136B815B8;
        Mon, 28 Feb 2022 17:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D85C340E7;
        Mon, 28 Feb 2022 17:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646069712;
        bh=0uozSdYEpm4wPeKQjXI6P7p2CNOcuYuCBw5SCjpmGnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kh1wzB47HUC8WebH65qHm7Um323sAd4KwztMzHj4lgA7N6nS43iR5Qvc47bFaAqlr
         j4HS7hpKPevWemQJviaOvNI1NTHAgZCEh2NA5SasPQhEoUmoAR0BOIX344fOu8ms9+
         ZpVuqqBttx9BhfXj+hl08glEez4LkjZwzv7tFP3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5.10 66/80] usb: dwc3: pci: Fix Bay Trail phy GPIO mappings
Date:   Mon, 28 Feb 2022 18:24:47 +0100
Message-Id: <20220228172319.741053910@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228172311.789892158@linuxfoundation.org>
References: <20220228172311.789892158@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 62e3f0afe246720f7646eb1b034a6897dac34405 upstream.

When the Bay Trail phy GPIO mappings where added cs and reset were swapped,
this did not cause any issues sofar, because sofar they were always driven
high/low at the same time.

Note the new mapping has been verified both in /sys/kernel/debug/gpio
output on Android factory images on multiple devices, as well as in
the schematics for some devices.

Fixes: 5741022cbdf3 ("usb: dwc3: pci: Add GPIO lookup table on platforms without ACPI GPIO resources")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20220213130524.18748-3-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/dwc3-pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -81,8 +81,8 @@ static const struct acpi_gpio_mapping ac
 static struct gpiod_lookup_table platform_bytcr_gpios = {
 	.dev_id		= "0000:00:16.0",
 	.table		= {
-		GPIO_LOOKUP("INT33FC:00", 54, "reset", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("INT33FC:02", 14, "cs", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("INT33FC:00", 54, "cs", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("INT33FC:02", 14, "reset", GPIO_ACTIVE_HIGH),
 		{}
 	},
 };


