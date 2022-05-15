Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8F3C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 May 2022 15:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbiEOP5L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 May 2022 11:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237660AbiEOP4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 11:56:33 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C0013F7F
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 08:56:32 -0700 (PDT)
Received: from pop-os.home ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id qGbcngusBVfTCqGbdnSibo; Sun, 15 May 2022 17:56:31 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 15 May 2022 17:56:31 +0200
X-ME-IP: 86.243.180.246
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     vburru@marvell.com, aayarekar@marvell.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        sburla@marvell.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/2] octeon_ep: Fix the error handling path of octep_request_irqs()
Date:   Sun, 15 May 2022 17:56:25 +0200
Message-ID: <cover.1652629833.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20220515155625.wjzoXwekA49EizLEO6EMqkCM0d463dMTMMH6tka_rII@z>

I send a small serie to ease review and because I'm sighly less confident with
the 2nd patch.

They are related to the same Fixes: tag, so they obviously could be merged if
it is preferred.

Christophe JAILLET (2):
  octeon_ep: Fix a memory leak in the error handling path of
    octep_request_irqs()
  octeon_ep: Fix irq releasing in the error handling path of
    octep_request_irqs()

 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.34.1

