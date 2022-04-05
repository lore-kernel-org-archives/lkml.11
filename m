Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4453C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 12:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383176AbiDEMZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 08:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245051AbiDEIxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:53:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4092DDE7;
        Tue,  5 Apr 2022 01:50:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A4672CE1BCE;
        Tue,  5 Apr 2022 08:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC37C385A1;
        Tue,  5 Apr 2022 08:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148643;
        bh=9xEAKMpxGzf2culwYA+lPprUuDTBQpTKmsGMIu0d/v0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3bAarNP9VbODL++HYYabkwqGBSnj9JAOfKw9aUkbUR7/HliX5f1G6UcvXzUgcy3r
         fq6MftnRLTgecWgqK989AOOm9s9QgBap+LNkfAk/sjrGrJ4qrlDyB9PeeLT8YvjsG8
         3xEyRiYa/ITMPw29mEeFIiMqB3Grc2dCVztnm6NI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0390/1017] mmc: davinci_mmc: Handle error for clk_enable
Date:   Tue,  5 Apr 2022 09:21:43 +0200
Message-Id: <20220405070405.862160748@linuxfoundation.org>
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

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit 09e7af76db02c74f2a339b3cb2d95460fa2ddbe4 ]

As the potential failure of the clk_enable(),
it should be better to check it and return error
if fails.

Fixes: bbce5802afc5 ("davinci: mmc: updates to suspend/resume implementation")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Link: https://lore.kernel.org/r/20220308071415.1093393-1-jiasheng@iscas.ac.cn
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/davinci_mmc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 2a757c88f9d2..80de660027d8 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1375,8 +1375,12 @@ static int davinci_mmcsd_suspend(struct device *dev)
 static int davinci_mmcsd_resume(struct device *dev)
 {
 	struct mmc_davinci_host *host = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_enable(host->clk);
+	if (ret)
+		return ret;
 
-	clk_enable(host->clk);
 	mmc_davinci_reset_ctrl(host, 0);
 
 	return 0;
-- 
2.34.1



