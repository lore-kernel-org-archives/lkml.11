Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A164CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 17:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiFWROa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 13:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiFWRMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:12:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959E82DCC;
        Thu, 23 Jun 2022 09:57:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 007F060B2C;
        Thu, 23 Jun 2022 16:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC61EC3411B;
        Thu, 23 Jun 2022 16:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656003461;
        bh=YFSLUmsgfLwiMcvlShyqk9K23fj8lUXfyVTV4G0bNOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aYKQINNrKG5+/eaf5Yd+g6un6okTUIEH623GaFWnjvmWDWXrsKKJtl8z7++3mjT87
         Kk+KffML947xCenfOGkUw8nPhxAy83++EFm0MPqJAZfzdtBmNXtutuIOr24t2pJEWz
         JTz+wFv1K9HhroxsFH4JxgYKUWrt0dNO77nQ1ooA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable <stable@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH 4.9 245/264] usb: gadget: lpc32xx_udc: Fix refcount leak in lpc32xx_udc_probe
Date:   Thu, 23 Jun 2022 18:43:58 +0200
Message-Id: <20220623164351.003771829@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623164344.053938039@linuxfoundation.org>
References: <20220623164344.053938039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

commit 4757c9ade34178b351580133771f510b5ffcf9c8 upstream.

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.
of_node_put() will check NULL pointer.

Fixes: 24a28e428351 ("USB: gadget driver for LPC32xx")
Cc: stable <stable@kernel.org>
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Link: https://lore.kernel.org/r/20220603140246.64529-1-linmq006@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -3034,6 +3034,7 @@ static int lpc32xx_udc_probe(struct plat
 	}
 
 	udc->isp1301_i2c_client = isp1301_get_client(isp1301_node);
+	of_node_put(isp1301_node);
 	if (!udc->isp1301_i2c_client) {
 		retval = -EPROBE_DEFER;
 		goto phy_fail;


