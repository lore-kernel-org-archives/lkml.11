Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FE4C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 13:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbiGSNcp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 09:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238968AbiGSNcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:32:33 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63134E39AB;
        Tue, 19 Jul 2022 05:47:54 -0700 (PDT)
X-QQ-mid: bizesmtp67t1658234772t6p3sjeh
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:46:08 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000C00A0000020
X-QQ-FEAT: n5Ysw2DEON5wMicO4DrlXoB2VIR8NUEgEacVMvnH4DH1FoXCnFghtSkT+Hog0
        +cXInwsnXkP/IMkvlH1M1c46KrOD2/QdfS4++3EyIV7QYl1U5sM7g3RYuzEkqjqTnpTvqDT
        XU0a1iR5GAJuteOyHO3lgy7B+tyf6yiVCRFbJj8llglKbai4NyiSxb/ebLKFsxOTVM380/u
        LkEPUPhQB/pZb0U4s7t/EXVsF3VZAuIbxLJCWhr+Vf+U3zo8vjMzXhj9OG3kBQYkLIIl+VD
        ZHwx9bTxOj4f1ohAb89LAcKy0bEphWciAbvzF/jCKK09nY986DGRY4GGPsZ6SZENeBHkEsb
        KKEmy5wqUCOvWHrw4GxtNGAZLG/fCMuMJogpS6ta0pF+yPCKMDsNtuNI9qo5/mdOq+hl7wy
        0HOcL5dxzOw=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     davem@davemloft.net
Cc:     pshelar@ovn.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] net: openvswitch: Fix comment typo
Date:   Sat, 16 Jul 2022 12:44:11 +0800
Message-Id: <20220716044411.43842-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `is' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 net/openvswitch/flow_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 4c09cf8a0ab2..4a07ab094a84 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -3304,7 +3304,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 
 			/* Disallow subsequent L2.5+ set actions and mpls_pop
 			 * actions once the last MPLS label in the packet is
-			 * is popped as there is no check here to ensure that
+			 * popped as there is no check here to ensure that
 			 * the new eth type is valid and thus set actions could
 			 * write off the end of the packet or otherwise corrupt
 			 * it.
-- 
2.35.1


