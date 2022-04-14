Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A42C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 14:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbiDNOiI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344317AbiDNNks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:40:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0227120;
        Thu, 14 Apr 2022 06:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94D0AB828F4;
        Thu, 14 Apr 2022 13:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1208C385A1;
        Thu, 14 Apr 2022 13:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649943501;
        bh=mW0/NGktVhnDCE4JOlUAkSAXhp8nnOUBGnleDCPXXx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Xahp5+7LvZrruTvykkLjHl7jKJ8K5bBjQ+SxRQ2r0j+UEaNYF7fesm1EijCQCeso
         2wG+2BHJPOgLPs5cTJe0JQlb2RRfXl7XcOefLjSP4qTDyKv/m/Ftdyb5r6kAPSfwMy
         upYA0OgY4q7rjU4mvZNhkU0LV+JYDe6tmg0CYysg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 137/475] ASoC: atmel_ssc_dai: Handle errors for clk_enable
Date:   Thu, 14 Apr 2022 15:08:42 +0200
Message-Id: <20220414110858.983052588@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110855.141582785@linuxfoundation.org>
References: <20220414110855.141582785@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit f9e2ca0640e59d19af0ff285ee5591ed39069b09 ]

As the potential failure of the clk_enable(),
it should be better to check it and return error if fals.

Fixes: cbaadf0f90d6 ("ASoC: atmel_ssc_dai: refactor the startup and shutdown")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Link: https://lore.kernel.org/r/20220301090637.3776558-1-jiasheng@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/atmel/atmel_ssc_dai.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index ca603397651c..1e0973322cd0 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -280,7 +280,10 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 
 	/* Enable PMC peripheral clock for this SSC */
 	pr_debug("atmel_ssc_dai: Starting clock\n");
-	clk_enable(ssc_p->ssc->clk);
+	ret = clk_enable(ssc_p->ssc->clk);
+	if (ret)
+		return ret;
+
 	ssc_p->mck_rate = clk_get_rate(ssc_p->ssc->clk);
 
 	/* Reset the SSC unless initialized to keep it in a clean state */
-- 
2.34.1



