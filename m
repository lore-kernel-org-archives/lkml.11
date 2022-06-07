Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA02CCA483
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 21:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382285AbiFGVuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 17:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377170AbiFGUuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:50:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018581F7D81;
        Tue,  7 Jun 2022 11:39:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32A806157E;
        Tue,  7 Jun 2022 18:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2E1C385A5;
        Tue,  7 Jun 2022 18:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654627198;
        bh=zcz4MXC05t6lKEeUKiRDVQcjac26JfMYOebzlgasOfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lhIn15k1hLtVx1Js8aUhTbPgTWh6mtBZ1xd067k96gMO50L8QUfB1H2gjRqFS6Rxq
         VkUW4DRy6saEenpEwoP8uMCm0zNsceNOEt4eL5Ndp8r/dlOL6chICg1X0q735pxpIk
         ISDRmeKwb2nsKvSPUOMY8c6GWiyJlXkYrIQGWJZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 5.17 654/772] PCI: qcom: Fix runtime PM imbalance on probe errors
Date:   Tue,  7 Jun 2022 19:04:06 +0200
Message-Id: <20220607165008.335034882@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607164948.980838585@linuxfoundation.org>
References: <20220607164948.980838585@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan+linaro@kernel.org>

commit 87d83b96c8d6c6c2d2096bd0bdba73bcf42b8ef0 upstream.

Drop the leftover pm_runtime_disable() calls from the late probe error
paths that would, for example, prevent runtime PM from being reenabled
after a probe deferral.

Link: https://lore.kernel.org/r/20220401133854.10421-2-johan+linaro@kernel.org
Fixes: 6e5da6f7d824 ("PCI: qcom: Fix error handling in runtime PM support")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: stable@vger.kernel.org      # 4.20
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1593,17 +1593,14 @@ static int qcom_pcie_probe(struct platfo
 	pp->ops = &qcom_pcie_dw_ops;
 
 	ret = phy_init(pcie->phy);
-	if (ret) {
-		pm_runtime_disable(&pdev->dev);
+	if (ret)
 		goto err_pm_runtime_put;
-	}
 
 	platform_set_drvdata(pdev, pcie);
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "cannot initialize host\n");
-		pm_runtime_disable(&pdev->dev);
 		goto err_pm_runtime_put;
 	}
 


