Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60A0C25B0D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 04:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiHPEcl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 00:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiHPEcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 00:32:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BCE193F2;
        Mon, 15 Aug 2022 13:22:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80FF460F60;
        Mon, 15 Aug 2022 20:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70056C433C1;
        Mon, 15 Aug 2022 20:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660594936;
        bh=UA4CGN5pQUGKiJSR+n6oMVNpzJodTwCIgeiovrvABLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MKLiw1Lrqd113MZEAZF1FQunQTlybZoIAp8w7Ses00UudJdc7YW1bR6dFCP0uB8zN
         EJyOIpnLd6zmQoWitrfSZQMvGQLsxGosP5yFOJZzJAVqpgxqXCJHm0DrvlxTdnxCf6
         BRt/HdCUYruY2ABu65XTdJwUyBXrVrmPoBASGg7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.19 0605/1157] PCI: mediatek-gen3: Fix refcount leak in mtk_pcie_init_irq_domains()
Date:   Mon, 15 Aug 2022 19:59:21 +0200
Message-Id: <20220815180503.877537980@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180439.416659447@linuxfoundation.org>
References: <20220815180439.416659447@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit bf038503d5fe90189743124233fe7aeb0984e961 ]

of_get_child_by_name() returns a node pointer with refcount incremented, so
we should use of_node_put() on it when we don't need it anymore.

Add missing of_node_put() to avoid refcount leak.

Fixes: 814cceebba9b ("PCI: mediatek-gen3: Add INTx support")
Link: https://lore.kernel.org/r/20220601041259.56185-1-linmq006@gmail.com
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Acked-by: Jianjun Wang <jianjun.wang@mediatek.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 5d9fd36b02d1..a02c466a597c 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -600,7 +600,8 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
 						  &intx_domain_ops, pcie);
 	if (!pcie->intx_domain) {
 		dev_err(dev, "failed to create INTx IRQ domain\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_put_node;
 	}
 
 	/* Setup MSI */
@@ -623,13 +624,15 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
 		goto err_msi_domain;
 	}
 
+	of_node_put(intc_node);
 	return 0;
 
 err_msi_domain:
 	irq_domain_remove(pcie->msi_bottom_domain);
 err_msi_bottom_domain:
 	irq_domain_remove(pcie->intx_domain);
-
+out_put_node:
+	of_node_put(intc_node);
 	return ret;
 }
 
-- 
2.35.1



