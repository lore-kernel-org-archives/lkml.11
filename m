Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7FFC433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 14:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351066AbiDNOaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343791AbiDNNjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:39:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D7C30557;
        Thu, 14 Apr 2022 06:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C96BB8296A;
        Thu, 14 Apr 2022 13:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18C7C385A1;
        Thu, 14 Apr 2022 13:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649943290;
        bh=9xVC0t8fE1nc9iethMyli5nPUonY6Z+rOanOsf8awNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ge8UWJ0S6AFd7OeJnqfThYvWVTbkAahHAvBJjDrK3QTyIvklh22oyPcCrErdlnhUf
         xSM8QXg2g5dDKL3ovB2FDXpoHhJkrplqyC9snTJUZlyVfdoSDZFVy01+L5w/IQAy4H
         PBz5RlNArGUMlTmAbol5Fp+MY4BpdtFbxZhFAe6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Ranquet <granquet@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 103/475] clocksource/drivers/timer-of: Check return value of of_iomap in timer_of_base_init()
Date:   Thu, 14 Apr 2022 15:08:08 +0200
Message-Id: <20220414110858.036715290@linuxfoundation.org>
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

From: Guillaume Ranquet <granquet@baylibre.com>

[ Upstream commit 4467b8bad2401794fb89a0268c8c8257180bf60f ]

of_base->base can either be iomapped using of_io_request_and_map() or
of_iomap() depending whether or not an of_base->name has been set.

Thus check of_base->base against NULL as of_iomap() does not return a
PTR_ERR() in case of error.

Fixes: 9aea417afa6b ("clocksource/drivers/timer-of: Don't request the resource by name")
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
Link: https://lore.kernel.org/r/20220307172656.4836-1-granquet@baylibre.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/timer-of.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index a3c73e972fce..bf2a6f64ba0c 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -157,9 +157,9 @@ static __init int timer_of_base_init(struct device_node *np,
 	of_base->base = of_base->name ?
 		of_io_request_and_map(np, of_base->index, of_base->name) :
 		of_iomap(np, of_base->index);
-	if (IS_ERR(of_base->base)) {
-		pr_err("Failed to iomap (%s)\n", of_base->name);
-		return PTR_ERR(of_base->base);
+	if (IS_ERR_OR_NULL(of_base->base)) {
+		pr_err("Failed to iomap (%s:%s)\n", np->name, of_base->name);
+		return of_base->base ? PTR_ERR(of_base->base) : -ENOMEM;
 	}
 
 	return 0;
-- 
2.34.1



