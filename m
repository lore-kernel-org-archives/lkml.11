Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D234C43217
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 15:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244541AbiDNPWQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 11:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347595AbiDNN7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:59:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D7543EDA;
        Thu, 14 Apr 2022 06:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D970F61DA0;
        Thu, 14 Apr 2022 13:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A7EC385A1;
        Thu, 14 Apr 2022 13:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649944215;
        bh=fLFQ4pTdFMxQEWltQFVuFY+wlufNVyHPuJ7cjZoX2sI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VhARvOlI/UZx9ctnV6VKlE8DSrNWcZs1epXCRRIgjgDKx/GlAZh9oiCm9x/drxo7n
         r6Pg/fmUaxeGDwA7k8b23kFQLxdc4xKUc/F7vi0i47B0XPohFr6tybuPL9PEK21vTJ
         ALDmwGiMba04CNEc5gkNxHQZlkokEAJFpDqq5AeU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dust Li <dust.li@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 395/475] net/smc: correct settings of RMB window update limit
Date:   Thu, 14 Apr 2022 15:13:00 +0200
Message-Id: <20220414110906.125255947@linuxfoundation.org>
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

From: Dust Li <dust.li@linux.alibaba.com>

[ Upstream commit 6bf536eb5c8ca011d1ff57b5c5f7c57ceac06a37 ]

rmbe_update_limit is used to limit announcing receive
window updating too frequently. RFC7609 request a minimal
increase in the window size of 10% of the receive buffer
space. But current implementation used:

  min_t(int, rmbe_size / 10, SOCK_MIN_SNDBUF / 2)

and SOCK_MIN_SNDBUF / 2 == 2304 Bytes, which is almost
always less then 10% of the receive buffer space.

This causes the receiver always sending CDC message to
update its consumer cursor when it consumes more then 2K
of data. And as a result, we may encounter something like
"TCP silly window syndrome" when sending 2.5~8K message.

This patch fixes this using max(rmbe_size / 10, SOCK_MIN_SNDBUF / 2).

With this patch and SMC autocorking enabled, qperf 2K/4K/8K
tcp_bw test shows 45%/75%/40% increase in throughput respectively.

Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 12672019f76c..66cdfd5725ac 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -734,7 +734,7 @@ static struct smc_buf_desc *smc_buf_get_slot(int compressed_bufsize,
  */
 static inline int smc_rmb_wnd_update_limit(int rmbe_size)
 {
-	return min_t(int, rmbe_size / 10, SOCK_MIN_SNDBUF / 2);
+	return max_t(int, rmbe_size / 10, SOCK_MIN_SNDBUF / 2);
 }
 
 static struct smc_buf_desc *smcr_new_buf_create(struct smc_link_group *lgr,
-- 
2.35.1



