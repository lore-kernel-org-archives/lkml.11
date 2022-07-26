Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD1FC04A68
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jul 2022 19:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239781AbiGZTP7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jul 2022 15:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbiGZTP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 15:15:56 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB06829C84
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 12:15:55 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id GQ24ojta0gXAiGQ24orxjW; Tue, 26 Jul 2022 21:15:54 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 26 Jul 2022 21:15:54 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 2/2] mmc: pxamci: Fix another error handling path in pxamci_probe()
Date:   Tue, 26 Jul 2022 21:15:51 +0200
Message-Id: <07a2dcebf8ede69b484103de8f9df043f158cffd.1658862932.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6d75855ad4e2470e9ed99e0df21bc30f0c925a29.1658862932.git.christophe.jaillet@wanadoo.fr>
References: <6d75855ad4e2470e9ed99e0df21bc30f0c925a29.1658862932.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit in Fixes: has introduced an new error handling without branching
to the existing error handling path.

Update it now and release some resources if pxamci_init_ocr() fails.

Fixes: 61951fd6cb49 ("mmc: pxamci: let mmc core handle regulators")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mmc/host/pxamci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 37bf362a0ed5..e4003f6058eb 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -672,7 +672,7 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	ret = pxamci_init_ocr(host);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	mmc->caps = 0;
 	host->cmdat = 0;
-- 
2.34.1

