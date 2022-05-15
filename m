Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F683C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 15 May 2022 15:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbiEOP5Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 May 2022 11:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236841AbiEOP5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 11:57:18 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B30713F8A
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 08:57:16 -0700 (PDT)
Received: from pop-os.home ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id qGcCn0Tbaqn1xqGcCnISX0; Sun, 15 May 2022 17:57:15 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 15 May 2022 17:57:15 +0200
X-ME-IP: 86.243.180.246
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Veerasenareddy Burru <vburru@marvell.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Satananda Burla <sburla@marvell.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org
Subject: [PATCH 1/2] octeon_ep: Fix a memory leak in the error handling path of octep_request_irqs()
Date:   Sun, 15 May 2022 17:56:44 +0200
Message-Id: <78dcfbb5d22328bc83edbfc74af10c3625c54087.1652629833.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652629833.git.christophe.jaillet@wanadoo.fr>
References: <cover.1652629833.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'oct->non_ioq_irq_names' is not freed in the error handling path of
octep_request_irqs().

Add the missing kfree().

Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index e020c81f3455..6b60a03574a0 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -267,6 +267,8 @@ static int octep_request_irqs(struct octep_device *oct)
 		--i;
 		free_irq(oct->msix_entries[i].vector, oct);
 	}
+	kfree(oct->non_ioq_irq_names);
+	oct->non_ioq_irq_names = NULL;
 alloc_err:
 	return -1;
 }
-- 
2.34.1

