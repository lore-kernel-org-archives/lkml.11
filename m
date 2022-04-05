Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BE7C41535
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 09:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbiDEJb4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239538AbiDEIUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:20:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66611002;
        Tue,  5 Apr 2022 01:15:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5165A60B0B;
        Tue,  5 Apr 2022 08:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62669C385A0;
        Tue,  5 Apr 2022 08:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649146536;
        bh=q1UeRlLEWK3JLoRsaXN04m0q8F3HuCNVdsPigD7nWpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLKOIZDUUYsKln3U0g2kjC/7j6tee7hSCt5teuAw5f2nnUpS0m0xRXH+b/1pQnm1L
         d4wjBLQF7u3uxGHRt6pHZF6SGZ5vI/52A483V079SNBwfWR5WrorVa8x+nMPBmMGk0
         0tpOPY9fye8mwu6Dqihz8p2+pLg4r6APdzz4RYmk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0761/1126] mailbox: imx: fix crash in resume on i.mx8ulp
Date:   Tue,  5 Apr 2022 09:25:08 +0200
Message-Id: <20220405070429.919368725@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

[ Upstream commit 8219efd08a0aa1d7944bdb66d84ba57549258968 ]

check 'priv->clk' before 'imx_mu_read()' otherwise crash happens on
i.mx8ulp, since clock not enabled.

Fixes: 4f0b776ef5831 ("mailbox: imx-mailbox: support i.MX8ULP MU")
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/imx-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 544de2db6453..3c9c87b9c872 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -718,7 +718,7 @@ static int __maybe_unused imx_mu_resume_noirq(struct device *dev)
 	 * send failed, may lead to system freeze. This issue
 	 * is observed by testing freeze mode suspend.
 	 */
-	if (!imx_mu_read(priv, priv->dcfg->xCR[0]) && !priv->clk) {
+	if (!priv->clk && !imx_mu_read(priv, priv->dcfg->xCR[0])) {
 		for (i = 0; i < IMX_MU_xCR_MAX; i++)
 			imx_mu_write(priv, priv->xcr[i], priv->dcfg->xCR[i]);
 	}
-- 
2.34.1



