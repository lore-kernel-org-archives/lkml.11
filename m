Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89034C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jun 2022 11:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245605AbiFELzt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jun 2022 07:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiFELzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 07:55:47 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC6D54B41C
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 04:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=TktEAKzMXlckYPb1wm
        tHCGJBPjvUjlyBnCJZah6s7k8=; b=UxJRsh6Y88e0gYNya3P3ilkERz5ekqih9r
        rcqfowJPBQM3QbHBg1y1IT4ydejusEZZ0Zr+tX8eWgUv1r+LTQRon0Si+DfpB3qN
        3+Zo/EYJ+0pd0Gu7bEWwOreVi7HNCHusC5xOdlB2yFmobUy4XYAIPQHEN7nDhZW1
        cUGepyHWg=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp8 (Coremail) with SMTP id DMCowAD3Eh1lmZxiknruGA--.26778S4;
        Sun, 05 Jun 2022 19:54:21 +0800 (CST)
From:   Xiaohui Zhang <ruc_zhangxiaohui@163.com>
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.or,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] l2tp: fix possible use-after-free
Date:   Sun,  5 Jun 2022 19:54:12 +0800
Message-Id: <20220605115412.16004-1-ruc_zhangxiaohui@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DMCowAD3Eh1lmZxiknruGA--.26778S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF1xKF18ZF1UWrWfAw1fWFg_yoWkWFX_Zr
        y8X3WrWrn5Xan7Gr42vw4YqrWkJrZxCrWrCrn7tFsFya4ftF93Kr97JFWvv347urWqgr9a
        qrsYqw4UKwnrujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiApn5UUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: puxfs6pkdqw5xldrx3rl6rljoofrz/1tbiVg0XMFqzri88igAAsi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xiaohuizhang98 <ruc_zhangxiaohui@163.com>

We detected a suspected bug with our code clone detection tool.

Similar to the handling of l2tp_tunnel_get in commit a622b40035d1
("l2ip: fix possible use-after-free"), we thought a patch might
be needed here as well.

Before taking a refcount on a rcu protected structure,
we need to make sure the refcount is not zero.

Signed-off-by: xiaohuizhang98 <ruc_zhangxiaohui@163.com>
---
 net/l2tp/l2tp_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index b759fbd09b65..c5de6d4e0818 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -273,8 +273,8 @@ struct l2tp_session *l2tp_session_get(const struct net *net, u32 session_id)
 
 	rcu_read_lock_bh();
 	hlist_for_each_entry_rcu(session, session_list, global_hlist)
-		if (session->session_id == session_id) {
-			l2tp_session_inc_refcount(session);
+		if (session->session_id == session_id &&
+		    refcount_inc_not_zero(&session->ref_count)) {
 			rcu_read_unlock_bh();
 
 			return session;
-- 
2.17.1

