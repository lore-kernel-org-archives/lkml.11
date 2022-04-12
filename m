Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F40C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 06:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiDLGlw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 02:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350110AbiDLGkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:40:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6732735858;
        Mon, 11 Apr 2022 23:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03A8B618C8;
        Tue, 12 Apr 2022 06:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FAFC385A6;
        Tue, 12 Apr 2022 06:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649745318;
        bh=JdWcJHw6Z8EOIGMC+LCs3fNNPER0efBe14vg7ayrxpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsjA+uIjr4VZAOZ3+Zxf0NFoP1j1StADNHZBwmi2IoSGuibpny/oGsVJUJLxG3jkW
         ZHTmpsh71YrWDUQnemzxULi7GVnlm7lMHATa+v1j8o2Z8EEJTtIMsHmq2Na3AAH7kU
         vJq77kAhx2qXBrnedNZuIYaTn0W/iYfNCy0kTbO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Chen <lchen@ambarella.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 055/171] PCI: endpoint: Fix misused goto label
Date:   Tue, 12 Apr 2022 08:29:06 +0200
Message-Id: <20220412062929.475311997@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062927.870347203@linuxfoundation.org>
References: <20220412062927.870347203@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Chen <lchen@ambarella.com>

[ Upstream commit bf8d87c076f55b8b4dfdb6bc6c6b6dc0c2ccb487 ]

Fix a misused goto label jump since that can result in a memory leak.

Link: https://lore.kernel.org/r/17e7b9b9ee6.c6d9c6a02564.4545388417402742326@zohomail.com
Signed-off-by: Li Chen <lchen@ambarella.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index b861840e867c..262b2c4c70c9 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -451,7 +451,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 		if (!epf_test->dma_supported) {
 			dev_err(dev, "Cannot transfer data using DMA\n");
 			ret = -EINVAL;
-			goto err_map_addr;
+			goto err_dma_map;
 		}
 
 		src_phys_addr = dma_map_single(dma_dev, buf, reg->size,
-- 
2.35.1



