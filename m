Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD34C19F2A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jul 2022 02:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbiG0Cq6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jul 2022 22:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240072AbiG0Cqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 22:46:55 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74EC0240AA;
        Tue, 26 Jul 2022 19:46:54 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id E17BD1E80D54;
        Wed, 27 Jul 2022 10:47:05 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fTvU8SdDfP1i; Wed, 27 Jul 2022 10:47:03 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 972301E80D05;
        Wed, 27 Jul 2022 10:47:02 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc:     linux-decnet-user@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com, Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] dn_route: use time_is_before_jiffies(a) to replace "jiffies - a > 0"
Date:   Wed, 27 Jul 2022 10:46:00 +0800
Message-Id: <20220727024600.18413-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

time_is_before_jiffies deals with timer wrapping correctly.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 net/decnet/dn_route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/decnet/dn_route.c b/net/decnet/dn_route.c
index 552a53f1d5d0..0a4bed0bc2e3 100644
--- a/net/decnet/dn_route.c
+++ b/net/decnet/dn_route.c
@@ -201,7 +201,7 @@ static void dn_dst_check_expire(struct timer_list *unused)
 		}
 		spin_unlock(&dn_rt_hash_table[i].lock);
 
-		if ((jiffies - now) > 0)
+		if (time_is_before_jiffies(now))
 			break;
 	}
 
-- 
2.11.0

