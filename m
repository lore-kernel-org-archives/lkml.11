Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A59C4167B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 12:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381105AbiDEL6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245034AbiDEIxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:53:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DBAC6A;
        Tue,  5 Apr 2022 01:50:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32F70B81BAE;
        Tue,  5 Apr 2022 08:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A225C385A1;
        Tue,  5 Apr 2022 08:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148600;
        bh=UCmlG4rd63t5l396pdjvaRu6Ova3zotoQonuVXPefqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MEkcFGGgJxIfLMeTVfVx8I7J5mZ8poJZliv7iBYJMx/J2sl+yccRsMHPNDCoTK50d
         E9++zafIGMiHj3ujFk04pZvvGjN/shVUHPAoXcrxNJAsZoS/m+6s0erB+oTvtYJN/6
         o01K9U1l5U1/cQFIdgIPR+Ol3wx8ugAHOnwOXPaA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wang Wensheng <wangwensheng4@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0387/1017] ASoC: imx-es8328: Fix error return code in imx_es8328_probe()
Date:   Tue,  5 Apr 2022 09:21:40 +0200
Message-Id: <20220405070405.773029471@linuxfoundation.org>
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

From: Wang Wensheng <wangwensheng4@huawei.com>

[ Upstream commit 3b891513f95cba3944e72c1139ea706d04f3781b ]

Fix to return a negative error code from the error handling case instead
of 0, as done elsewhere in this function.

Fixes: 7e7292dba215 ("ASoC: fsl: add imx-es8328 machine driver")
Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
Link: https://lore.kernel.org/r/20220310091902.129299-1-wangwensheng4@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/imx-es8328.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-es8328.c b/sound/soc/fsl/imx-es8328.c
index 09c674ee79f1..168973035e35 100644
--- a/sound/soc/fsl/imx-es8328.c
+++ b/sound/soc/fsl/imx-es8328.c
@@ -87,6 +87,7 @@ static int imx_es8328_probe(struct platform_device *pdev)
 	if (int_port > MUX_PORT_MAX || int_port == 0) {
 		dev_err(dev, "mux-int-port: hardware only has %d mux ports\n",
 			MUX_PORT_MAX);
+		ret = -EINVAL;
 		goto fail;
 	}
 
-- 
2.34.1



