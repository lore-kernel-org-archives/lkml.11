Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7F6C46467
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 11:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381508AbiDELqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244878AbiDEIwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:52:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E5623BEE;
        Tue,  5 Apr 2022 01:45:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C27D4B81BC5;
        Tue,  5 Apr 2022 08:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34018C385A1;
        Tue,  5 Apr 2022 08:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148320;
        bh=SeEmVQ+6sOiq6KI47+xvkVim2p4SUR0DdCPXVwb5hVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J6PT9+/wHlbrqnlf4GDW1yo3/+7Y7EDQkTdDKqaiydEmKAAjJdVECkSJBnEi6TvG9
         6ztY4k6NS44dQt6P7Qlr12Z2Jsh1ltfrYPmv5LdhUVyldobQTPINS/0maAtZPP6Ma1
         y/8OeanLH1qQw3Fp5LOBMDcZzBqUN1V69P2lVc8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0315/1017] soc: qcom: aoss: remove spurious IRQF_ONESHOT flags
Date:   Tue,  5 Apr 2022 09:20:28 +0200
Message-Id: <20220405070403.627715914@linuxfoundation.org>
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

From: Daniel Thompson <daniel.thompson@linaro.org>

[ Upstream commit 8030cb9a55688c1339edd284d9d6ce5f9fc75160 ]

Quoting the header comments, IRQF_ONESHOT is "Used by threaded interrupts
which need to keep the irq line disabled until the threaded handler has
been run.". When applied to an interrupt that doesn't request a threaded
irq then IRQF_ONESHOT has a lesser known (undocumented?) side effect,
which it to disable the forced threading of the irq. For "normal" kernels
(without forced threading) then, if there is no thread_fn, then
IRQF_ONESHOT is a nop.

In this case disabling forced threading is not appropriate for this driver
because it calls wake_up_all() and this API cannot be called from
no-thread interrupt handlers on PREEMPT_RT systems (deadlock risk, triggers
sleeping-while-atomic warnings).

Fix this by removing IRQF_ONESHOT.

Fixes: 2209481409b7 ("soc: qcom: Add AOSS QMP driver")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
[bjorn: Added Fixes tag]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220127173554.158111-1-daniel.thompson@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/qcom_aoss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index e234d78b33e7..55c156aaf68a 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -501,7 +501,7 @@ static int qmp_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	ret = devm_request_irq(&pdev->dev, irq, qmp_intr, IRQF_ONESHOT,
+	ret = devm_request_irq(&pdev->dev, irq, qmp_intr, 0,
 			       "aoss-qmp", qmp);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request interrupt\n");
-- 
2.34.1



