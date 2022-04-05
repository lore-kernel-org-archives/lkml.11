Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7D1C43217
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 12:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351510AbiDELyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244896AbiDEIwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:52:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C5F2458A;
        Tue,  5 Apr 2022 01:45:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5028FB81BAE;
        Tue,  5 Apr 2022 08:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96818C385A0;
        Tue,  5 Apr 2022 08:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148348;
        bh=HWxjACHl9Ir8KVcVfW8mCP3H8HhaV08T+cFUkUDcZTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WU8vSjhxfwUfKs9jwEym2vAk9tTId714y+au48/IY7aOnPNeRHE6IxhN8XDXNRcEa
         HfLo0AcGokHdzlkdEDK5+XbNSn4HNLRiAFhSOTMwdxDeI1CP/uT2rOHd0bn3u7ett7
         EGf/lYRA2f8kt5hLkW9t3kM8cpnuEr0psNWjMRT8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0324/1017] soc: ti: wkup_m3_ipc: Fix IRQ check in wkup_m3_ipc_probe
Date:   Tue,  5 Apr 2022 09:20:37 +0200
Message-Id: <20220405070403.897260482@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit c3d66a164c726cc3b072232d3b6d87575d194084 ]

platform_get_irq() returns negative error number instead 0 on failure.
And the doc of platform_get_irq() provides a usage example:

    int irq = platform_get_irq(pdev, 0);
    if (irq < 0)
        return irq;

Fix the check of return value to catch errors correctly.

Fixes: cdd5de500b2c ("soc: ti: Add wkup_m3_ipc driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Acked-by: Dave Gerlach <d-gerlach@ti.com>
Link: https://lore.kernel.org/r/20220114062840.16620-1-linmq006@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/ti/wkup_m3_ipc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 72386bd393fe..2f03ced0f411 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -450,9 +450,9 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 		return PTR_ERR(m3_ipc->ipc_mem_base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq) {
+	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq resource\n");
-		return -ENXIO;
+		return irq;
 	}
 
 	ret = devm_request_irq(dev, irq, wkup_m3_txev_handler,
-- 
2.34.1



