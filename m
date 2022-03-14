Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B73C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 12:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241045AbiCNM0K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 08:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242428AbiCNMTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:19:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7C24E3AA;
        Mon, 14 Mar 2022 05:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8EF960B09;
        Mon, 14 Mar 2022 12:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27D3C340E9;
        Mon, 14 Mar 2022 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647260051;
        bh=ZLHV/ijyzxqyLndfEsqIgFthJJDTK+xbOtWlHN6N4qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z/IhsISbBUSkiUbxg8Q06iVjB1djpB43tYECrvqSHUa9+UjTdZgDoT3FPgcFn30Dk
         7orQnyPQQFx0bZfqWyX3GG4XlAamhjwvDpt44ogJ+Xor+6msTe1gZpqw4pv5L4qPg2
         8h+n2kMmD0a9c5wYPXj4vmE3zpLQy0cK7qm5R0Eo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 041/121] net: ethernet: ti: cpts: Handle error for clk_enable
Date:   Mon, 14 Mar 2022 12:53:44 +0100
Message-Id: <20220314112745.274647273@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314112744.120491875@linuxfoundation.org>
References: <20220314112744.120491875@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit 6babfc6e6fab068018c36e8f6605184b8c0b349d ]

As the potential failure of the clk_enable(),
it should be better to check it and return error
if fails.

Fixes: 8a2c9a5ab4b9 ("net: ethernet: ti: cpts: rework initialization/deinitialization")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/cpts.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index dc70a6bfaa6a..92ca739fac01 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -568,7 +568,9 @@ int cpts_register(struct cpts *cpts)
 	for (i = 0; i < CPTS_MAX_EVENTS; i++)
 		list_add(&cpts->pool_data[i].list, &cpts->pool);
 
-	clk_enable(cpts->refclk);
+	err = clk_enable(cpts->refclk);
+	if (err)
+		return err;
 
 	cpts_write32(cpts, CPTS_EN, control);
 	cpts_write32(cpts, TS_PEND_EN, int_enable);
-- 
2.34.1



