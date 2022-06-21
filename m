Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA62C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 08:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348353AbiFUIrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 04:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiFUIrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:47:05 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEBD2613E;
        Tue, 21 Jun 2022 01:47:01 -0700 (PDT)
X-QQ-mid: bizesmtp81t1655801144t635j276
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 16:45:38 +0800 (CST)
X-QQ-SSF: 0100000000700020B000B00A0000000
X-QQ-FEAT: g1CXZ3gRPwx3XGBYAGvOolfop4KKqFCtr034AVejk1ghy4k84dmBLJT9/NjIp
        veOwSHUCMrKVOcjsw+vtIbEWNp3QAgGOAFMskpPENq1uRUzSexrN3S2IA2V56aaMKdN9+ku
        5lLnjBic37eO0xfLNe8n64Agl5tzgl4ex6rE4uP62XwXxk9vpZppBFD56JskJRUgxXPE4s9
        uhcoMndqxUsHiZj52H4BNGTf+MQzTNbugPgsDxCplewIRZz+d9JyAMwh1zcOBZ1kVOVCWsJ
        J18uzH4v8BhP4ZLRq0c2yl9z/rcbucWOIEyUa5LXq55/1X9/NoPHu2i10cdNH+IE/J1aGfD
        d51z5N4/Imf7U6Pxl8ybjduua9VJw==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     rajur@chelsio.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] cxgb4vf: remove unexpected word "the"
Date:   Tue, 21 Jun 2022 16:45:37 +0800
Message-Id: <20220621084537.58402-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be removed

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
index 7de3800437c9..c2822e635f89 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
@@ -2859,7 +2859,7 @@ static const struct net_device_ops cxgb4vf_netdev_ops	= {
  *				address stored on the adapter
  *	@adapter: The adapter
  *
- *	Find the the port mask for the VF based on the index of mac
+ *	Find the port mask for the VF based on the index of mac
  *	address stored in the adapter. If no mac address is stored on
  *	the adapter for the VF, use the port mask received from the
  *	firmware.
-- 
2.17.1


