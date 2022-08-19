Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D169AC32773
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 16:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352811AbiHSQZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352452AbiHSQU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 12:20:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60DBE70;
        Fri, 19 Aug 2022 09:02:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83180B8280C;
        Fri, 19 Aug 2022 16:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEB1C433D6;
        Fri, 19 Aug 2022 16:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660924928;
        bh=12/sbekqp31dBab5yFqkEixx9OV9wB+rdE/C6fOf1ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QrwjoYPCDrcB1jRdqRmYPo2pRwvLlCW+kOVmXlL2JM4TkOuSwBmCBj0hN4DLpUoMV
         izJwyGbqVVtTtBDZXF/IZb8WB+mvk0vo0iHfX7dCIZVsLCL+2TWH2ezjj3KVcUIRU0
         UHDsKNi7d2SrlGmoE+7vN2VI3736AghDICY4A4/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 328/545] usb: dwc3: qcom: fix missing optional irq warnings
Date:   Fri, 19 Aug 2022 17:41:38 +0200
Message-Id: <20220819153844.049054031@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819153829.135562864@linuxfoundation.org>
References: <20220819153829.135562864@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit 69bb3520db7cecbccc9e497fc568fa5465c9d43f ]

Not all platforms have all of the four currently supported wakeup
interrupts so use the optional irq helpers when looking up interrupts to
avoid printing error messages when an optional interrupt is not found:

	dwc3-qcom a6f8800.usb: error -ENXIO: IRQ hs_phy_irq not found

Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20220713131340.29401-4-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 504f8af4d0f8..915fa4197d77 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -443,9 +443,9 @@ static int dwc3_qcom_get_irq(struct platform_device *pdev,
 	int ret;
 
 	if (np)
-		ret = platform_get_irq_byname(pdev_irq, name);
+		ret = platform_get_irq_byname_optional(pdev_irq, name);
 	else
-		ret = platform_get_irq(pdev_irq, num);
+		ret = platform_get_irq_optional(pdev_irq, num);
 
 	return ret;
 }
-- 
2.35.1



