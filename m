Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87C5C4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347957AbiBUJKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:10:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347460AbiBUJFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:05:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4084A240A3;
        Mon, 21 Feb 2022 00:59:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFA6261137;
        Mon, 21 Feb 2022 08:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAECC340E9;
        Mon, 21 Feb 2022 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645433947;
        bh=CnK08Uw1CN+mGBLje/lIxt/UcsQHJilLheLM1CvZEmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mocWnvConlC1rrfyuHpShzNkTyRxPyRwpEodEFb9u8YJLsVRNI41TOHRov7/aMBFG
         lKPsD8R+qMvrcEHEvXrL7l7indQtU8q6gCGSGy4MFIJXYEdyrmEKfiYj0idQ2P9CMQ
         pePq6JHb391ute3aM/Mg211E3KZALc7u8b1AOCIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mans Rullgard <mans@mansr.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fianelil <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 39/80] net: dsa: lan9303: fix reset on probe
Date:   Mon, 21 Feb 2022 09:49:19 +0100
Message-Id: <20220221084916.851688209@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084915.554151737@linuxfoundation.org>
References: <20220221084915.554151737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mans Rullgard <mans@mansr.com>

commit 6bb9681a43f34f2cab4aad6e2a02da4ce54d13c5 upstream.

The reset input to the LAN9303 chip is active low, and devicetree
gpio handles reflect this.  Therefore, the gpio should be requested
with an initial state of high in order for the reset signal to be
asserted.  Other uses of the gpio already use the correct polarity.

Fixes: a1292595e006 ("net: dsa: add new DSA switch driver for the SMSC-LAN9303")
Signed-off-by: Mans Rullgard <mans@mansr.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fianelil <f.fainelli@gmail.com>
Link: https://lore.kernel.org/r/20220209145454.19749-1-mans@mansr.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/lan9303-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1303,7 +1303,7 @@ static int lan9303_probe_reset_gpio(stru
 				     struct device_node *np)
 {
 	chip->reset_gpio = devm_gpiod_get_optional(chip->dev, "reset",
-						   GPIOD_OUT_LOW);
+						   GPIOD_OUT_HIGH);
 	if (IS_ERR(chip->reset_gpio))
 		return PTR_ERR(chip->reset_gpio);
 


