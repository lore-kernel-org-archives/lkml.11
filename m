Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F069AC4167D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 08:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386329AbiDLIzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359411AbiDLHnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:43:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F862CE15;
        Tue, 12 Apr 2022 00:22:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C794B81B46;
        Tue, 12 Apr 2022 07:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAA2C385A6;
        Tue, 12 Apr 2022 07:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649748169;
        bh=QaNOR5RKZom6VvVT+7/5NSchd1phah1uvn1QBNxVMAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xDiaTUuAmgtVtX2dIVqhxY4Njjm8cqgOw3kuumtbutgbdoyqsgqT1EdPNaBEx0nOV
         DtQG8mIMnMON9CBNXPC1BGeXHVFo8zM/aLP3C0Knwmh3TPE8YDl5Vpn8xcH6m8oO/A
         4T2Wg1R1N7ZE5mfZpnCDKqBnaA8QIOzBvX98yiAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.17 324/343] dmaengine: Revert "dmaengine: shdma: Fix runtime PM imbalance on error"
Date:   Tue, 12 Apr 2022 08:32:22 +0200
Message-Id: <20220412063000.673620530@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062951.095765152@linuxfoundation.org>
References: <20220412062951.095765152@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

commit d143f939a95696d38ff800ada14402fa50ebbd6c upstream.

This reverts commit 455896c53d5b ("dmaengine: shdma: Fix runtime PM
imbalance on error") as the patch wrongly reduced the count on error and
did not bail out. So drop the count by reverting the patch .

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/sh/shdma-base.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -115,10 +115,8 @@ static dma_cookie_t shdma_tx_submit(stru
 		ret = pm_runtime_get(schan->dev);
 
 		spin_unlock_irq(&schan->chan_lock);
-		if (ret < 0) {
+		if (ret < 0)
 			dev_err(schan->dev, "%s(): GET = %d\n", __func__, ret);
-			pm_runtime_put(schan->dev);
-		}
 
 		pm_runtime_barrier(schan->dev);
 


