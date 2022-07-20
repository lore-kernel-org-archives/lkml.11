Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663A2C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 07:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbiGTHZT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 03:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbiGTHZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:25:12 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A067225DB;
        Wed, 20 Jul 2022 00:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8VLYE
        h8tNmkR+3P2pMoFgJHuwjDlhhtxi2b4fJDmOaQ=; b=JWZGKICMAP1ueac15+wJ1
        GS4WRixvUYk3klf18cawZhFjh6tOttXytsxIERTNwsExgU3k8PgrFW88qnHmYNPk
        bj4608PPcMRBiSlup8lWQGrX6kVfP+RsPlOO4N44KlifHcYY94UPSLmtfG5wpgo4
        wHQL+5b3ci9hT7/3drPtLg=
Received: from localhost.localdomain (unknown [112.95.163.118])
        by smtp3 (Coremail) with SMTP id G9xpCgB3FZeXrddiwvXTQA--.50S2;
        Wed, 20 Jul 2022 15:24:18 +0800 (CST)
From:   LemmyHuang <hlm3280@163.com>
To:     edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        LemmyHuang <hlm3280@163.com>
Subject: [PATCH net-next v2] tcp: fix condition for increasing pingpong count
Date:   Wed, 20 Jul 2022 15:24:04 +0800
Message-Id: <20220720072404.16708-1-hlm3280@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgB3FZeXrddiwvXTQA--.50S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFWxZFy8Ary7tF1UAF4rGrg_yoWkZFbEkr
        4kGrWxJr43JFn29340kw4rXFyUKrZFgF1Fkr13uF93tw1rtF1DurZ5CryfZrn29r4UWryY
        vwn8KF1jgr12qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_Tmh5UUUUU==
X-Originating-IP: [112.95.163.118]
X-CM-SenderInfo: pkopjjiyq6il2tof0z/xtbBogJE+VaEFbRRyAAAs3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_HZ defaults to 1000Hz and the network transmission time is
less than 1ms, lsndtime and lrcvtime are likely to be equal, which will
lead to hundreds of interactions before entering pingpong mode.

Fixes: 4a41f453bedf ("tcp: change pingpong threshold to 3")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: LemmyHuang <hlm3280@163.com>
---
v2:
  * Use !after() wrapping the values. (Jakub Kicinski)

v1: https://lore.kernel.org/netdev/20220719130136.11907-1-hlm3280@163.com/
---
 net/ipv4/tcp_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 858a15cc2..c1c95dc40 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -172,7 +172,7 @@ static void tcp_event_data_sent(struct tcp_sock *tp,
 	 * and it is a reply for ato after last received packet,
 	 * increase pingpong count.
 	 */
-	if (before(tp->lsndtime, icsk->icsk_ack.lrcvtime) &&
+	if (!after(tp->lsndtime, icsk->icsk_ack.lrcvtime) &&
 	    (u32)(now - icsk->icsk_ack.lrcvtime) < icsk->icsk_ack.ato)
 		inet_csk_inc_pingpong_cnt(sk);
 
-- 
2.27.0

