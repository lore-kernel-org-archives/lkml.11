Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15323C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 11:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354921AbiEULZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 May 2022 07:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355020AbiEULOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:14:05 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870731312B0;
        Sat, 21 May 2022 04:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k0xGUi45Pmhckpj1HUc6z8Jrm9BIzWJyP6t9OROWXAU=;
  b=HFbqzgnxC9KLOvz/wGXvdMbu0Wiw6fJHSQ9vBxZMZ4FALLcn0U645L1U
   lDkVW3yvDkgUPpYykoMk4w/pAN00Blb47vHAKZOW0XOjjF5z86dmNg3OY
   oIsCj/eL5jNK+yur/uQ2D4nFhq7BUh4lYWFy/P0U1LuojTB6fNLo1P59k
   w=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727993"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:07 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Peter Chen <peter.chen@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] USB: chipidea: fix typo in comment
Date:   Sat, 21 May 2022 13:11:35 +0200
Message-Id: <20220521111145.81697-85-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/usb/chipidea/ci_hdrc_imx.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.h b/drivers/usb/chipidea/ci_hdrc_imx.h
index 999c65390b7f..7daccb9c5006 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.h
+++ b/drivers/usb/chipidea/ci_hdrc_imx.h
@@ -21,7 +21,7 @@ struct imx_usbmisc_data {
 	unsigned int pwr_pol:1; /* power polarity */
 	unsigned int evdo:1; /* set external vbus divider option */
 	unsigned int ulpi:1; /* connected to an ULPI phy */
-	unsigned int hsic:1; /* HSIC controlller */
+	unsigned int hsic:1; /* HSIC controller */
 	unsigned int ext_id:1; /* ID from exteranl event */
 	unsigned int ext_vbus:1; /* Vbus from exteranl event */
 	struct usb_phy *usb_phy;

