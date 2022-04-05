Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0BFC3527D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 23:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354133AbiDEXhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 19:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357235AbiDEKZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:25:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5485C27B36;
        Tue,  5 Apr 2022 03:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0647B81C8A;
        Tue,  5 Apr 2022 10:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B37C385A1;
        Tue,  5 Apr 2022 10:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649153386;
        bh=sVR33FUtTlVIApPJsjKgr9pJZo5UOvcNrviZQ+t5OWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLPq974f1ExBEQUMtBI2jirpyJD1RM8xn9eLbEEsyXun0nagWifOcGJCgMKc06t7U
         7cnxaZ7KdsOY7piuDqOH3B1X5XIu5umKd2j+6IDKrcxFBKb6rvJc9cDmRfk1LySnEg
         G8Fj/SCzLZjyCUIVsRTQ1ls95w4oK7/wy+bMTww0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 166/599] hwrng: nomadik - Change clk_disable to clk_disable_unprepare
Date:   Tue,  5 Apr 2022 09:27:40 +0200
Message-Id: <20220405070303.782754804@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 7f0f1f3ef62ed7a40e30aff28115bd94c4211d1d ]

The corresponding API for clk_prepare_enable is clk_disable_unprepare,
other than clk_disable_unprepare.

Fix this by changing clk_disable to clk_disable_unprepare.

Fixes: beca35d05cc2 ("hwrng: nomadik - use clk_prepare_enable()")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/nomadik-rng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/nomadik-rng.c b/drivers/char/hw_random/nomadik-rng.c
index 67947a19aa22..e8f9621e7954 100644
--- a/drivers/char/hw_random/nomadik-rng.c
+++ b/drivers/char/hw_random/nomadik-rng.c
@@ -65,14 +65,14 @@ static int nmk_rng_probe(struct amba_device *dev, const struct amba_id *id)
 out_release:
 	amba_release_regions(dev);
 out_clk:
-	clk_disable(rng_clk);
+	clk_disable_unprepare(rng_clk);
 	return ret;
 }
 
 static void nmk_rng_remove(struct amba_device *dev)
 {
 	amba_release_regions(dev);
-	clk_disable(rng_clk);
+	clk_disable_unprepare(rng_clk);
 }
 
 static const struct amba_id nmk_rng_ids[] = {
-- 
2.34.1



