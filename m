Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E798CC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 17:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbiFGR7A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 13:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347663AbiFGRjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:39:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2D9443F4;
        Tue,  7 Jun 2022 10:33:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6973B614BC;
        Tue,  7 Jun 2022 17:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6CBC34115;
        Tue,  7 Jun 2022 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654623177;
        bh=qY7uHp6Fsuyx7mTXhwX2aF+FGARITpLrjQfpYtpCVS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=seftsJQ6XCCLvmuE0yOQJHp8mITkLrRDc2YpI0JzaBCMJP2dQl3ONB3U4J9ycbhEV
         sjzW20SmkD464z3/+rxbhc8lDe+L4u14v2S11Uhxa85Acb9C015Ww6yCYtTmywNV3z
         dwGKJViBuwrBmGooTIsiXbYc2PEnysSS1VxoZebQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qinglang Miao <miaoqinglang@huawei.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 322/452] cpufreq: mediatek: add missing platform_driver_unregister() on error in mtk_cpufreq_driver_init
Date:   Tue,  7 Jun 2022 19:02:59 +0200
Message-Id: <20220607164918.153169155@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607164908.521895282@linuxfoundation.org>
References: <20220607164908.521895282@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qinglang Miao <miaoqinglang@huawei.com>

[ Upstream commit 2f05c19d9ef4f5a42634f83bdb0db596ffc0dd30 ]

Add the missing platform_driver_unregister() before return from
mtk_cpufreq_driver_init in the error handling case when failed
to register mtk-cpufreq platform device

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index a310372dc53e..f2e5ba3c539b 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -573,6 +573,7 @@ static int __init mtk_cpufreq_driver_init(void)
 	pdev = platform_device_register_simple("mtk-cpufreq", -1, NULL, 0);
 	if (IS_ERR(pdev)) {
 		pr_err("failed to register mtk-cpufreq platform device\n");
+		platform_driver_unregister(&mtk_cpufreq_platdrv);
 		return PTR_ERR(pdev);
 	}
 
-- 
2.35.1



