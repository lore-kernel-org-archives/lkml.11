Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF462C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 00:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343625AbiDLA4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 20:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245614AbiDLAxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 20:53:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C6133A1A;
        Mon, 11 Apr 2022 17:48:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC2F9B819C5;
        Tue, 12 Apr 2022 00:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856F8C385AA;
        Tue, 12 Apr 2022 00:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649724479;
        bh=h3/4h0H471UJtADRLo2a8XhpcTHhAAbQKbJpOEoncW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K0SxcDv24cOUPqmlcxvjC7tJUlIGKSZy0LbNghbRVTBvAxN1gozh3tPz866I6W8Sy
         q7X0b3FyQr//PC44vlcFVukR7Jf7e2eeUJVY4DE7uj7s8vKTPh5bx4wEe1pp+HPrgp
         6nG8UA5aTVF+9ET4BzAvQ73bBi5JCaTTwoy6czmHaEvIal/xnACBFceVYCfHcDsV2F
         46rUwtSuCnxVS0lYhlEQMVO9mHcSXSkLQDyi+wdKt6VaUsMgcsbk1ncQMzvtTzRJX7
         zbCdtW1PgpL4G0GFAlKtN/O95izlJG25rJQg2cfC86cJAgmS84nVYIFET+sZdePo6e
         zO3qEng1BOVNQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Leo Ruan <tingquan.ruan@cn.bosch.com>,
        Mark Jonas <mark.jonas@de.bosch.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 20/41] gpu: ipu-v3: Fix dev_dbg frequency output
Date:   Mon, 11 Apr 2022 20:46:32 -0400
Message-Id: <20220412004656.350101-20-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412004656.350101-1-sashal@kernel.org>
References: <20220412004656.350101-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Ruan <tingquan.ruan@cn.bosch.com>

[ Upstream commit 070a88fd4a03f921b73a2059e97d55faaa447dab ]

This commit corrects the printing of the IPU clock error percentage if
it is between -0.1% to -0.9%. For example, if the pixel clock requested
is 27.2 MHz but only 27.0 MHz can be achieved the deviation is -0.8%.
But the fixed point math had a flaw and calculated error of 0.2%.

Before:
  Clocks: IPU 270000000Hz DI 24716667Hz Needed 27200000Hz
  IPU clock can give 27000000 with divider 10, error 0.2%
  Want 27200000Hz IPU 270000000Hz DI 24716667Hz using IPU, 27000000Hz

After:
  Clocks: IPU 270000000Hz DI 24716667Hz Needed 27200000Hz
  IPU clock can give 27000000 with divider 10, error -0.8%
  Want 27200000Hz IPU 270000000Hz DI 24716667Hz using IPU, 27000000Hz

Signed-off-by: Leo Ruan <tingquan.ruan@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Link: https://lore.kernel.org/r/20220207151411.5009-1-mark.jonas@de.bosch.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/ipu-v3/ipu-di.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-di.c b/drivers/gpu/ipu-v3/ipu-di.c
index 666223c6bec4..0a34e0ab4fe6 100644
--- a/drivers/gpu/ipu-v3/ipu-di.c
+++ b/drivers/gpu/ipu-v3/ipu-di.c
@@ -447,8 +447,9 @@ static void ipu_di_config_clock(struct ipu_di *di,
 
 		error = rate / (sig->mode.pixelclock / 1000);
 
-		dev_dbg(di->ipu->dev, "  IPU clock can give %lu with divider %u, error %d.%u%%\n",
-			rate, div, (signed)(error - 1000) / 10, error % 10);
+		dev_dbg(di->ipu->dev, "  IPU clock can give %lu with divider %u, error %c%d.%d%%\n",
+			rate, div, error < 1000 ? '-' : '+',
+			abs(error - 1000) / 10, abs(error - 1000) % 10);
 
 		/* Allow a 1% error */
 		if (error < 1010 && error >= 990) {
-- 
2.35.1

