Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B613C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 12:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiCWMMQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 08:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242743AbiCWMMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:12:10 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6444C3EF0B;
        Wed, 23 Mar 2022 05:10:37 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.48:39292.1744386625
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.38 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id 006A6280096;
        Wed, 23 Mar 2022 20:10:33 +0800 (CST)
X-189-SAVE-TO-SEND: +sunshouxin@chinatelecom.cn
Received: from  ([172.18.0.48])
        by app0024 with ESMTP id 276ae1b2306842268f39292b7fe3135a for j.vosburgh@gmail.com;
        Wed, 23 Mar 2022 20:10:37 CST
X-Transaction-ID: 276ae1b2306842268f39292b7fe3135a
X-Real-From: sunshouxin@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: sunshouxin@chinatelecom.cn
From:   Sun Shouxin <sunshouxin@chinatelecom.cn>
To:     j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, oliver@neukum.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyd12@chinatelecom.cn, sunshouxin@chinatelecom.cn
Subject: [PATCH v6 3/4] net:ipv6:Export inet6_ifa_finish_destroy and ipv6_get_ifaddr
Date:   Wed, 23 Mar 2022 08:09:05 -0400
Message-Id: <20220323120906.42692-4-sunshouxin@chinatelecom.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220323120906.42692-1-sunshouxin@chinatelecom.cn>
References: <20220323120906.42692-1-sunshouxin@chinatelecom.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export inet6_ifa_finish_destroy and ipv6_get_ifaddr for bonding usage.

Signed-off-by: Sun Shouxin <sunshouxin@chinatelecom.cn>
---
 net/ipv6/addrconf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index bb1912eacd90..6825d70c34fb 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -975,6 +975,7 @@ void inet6_ifa_finish_destroy(struct inet6_ifaddr *ifp)
 
 	kfree_rcu(ifp, rcu);
 }
+EXPORT_SYMBOL(inet6_ifa_finish_destroy);
 
 static void
 ipv6_link_dev_addr(struct inet6_dev *idev, struct inet6_ifaddr *ifp)
@@ -2037,6 +2038,7 @@ struct inet6_ifaddr *ipv6_get_ifaddr(struct net *net, const struct in6_addr *add
 
 	return result;
 }
+EXPORT_SYMBOL(ipv6_get_ifaddr);
 
 /* Gets referenced address, destroys ifaddr */
 
-- 
2.27.0

