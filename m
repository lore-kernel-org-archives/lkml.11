Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7637FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 07:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345650AbiCOHwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 03:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiCOHwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:52:00 -0400
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD16E12AD8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:50:47 -0700 (PDT)
X-QQ-mid: bizesmtp65t1647330599t5jaxgpj
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Mar 2022 15:49:53 +0800 (CST)
X-QQ-SSF: 01400000002000D0H000B00A0000000
X-QQ-FEAT: F3yR32iATbgMpCjbikc3BWSKeichddKAGID8W5xikXF3OmtDM7BGzcFt33YO1
        Bl123JlrOMf2XGDP9jYKyTX29QEBr4qU+cbjYb4/z1x0YZy/OElwmyMj2wsE83OekJNjX5l
        XGt4Nl59hWdWuqD2ExSFSrRrRQtDOpcdCi5x4Ng4pSqUK6ouzIr21OVYcXlmE7cabFs6C2i
        jHkeROi0AC6KMwhqqCJc9Wte26kq4GfGBPfojflnUxlqZ+eT3J23mVzwpoKqnXiGrt3+Gjh
        WuE2onOmnqJugzMoXfC+Bcw6Q6sdzxXSnt/5Bg87rIh2f4YcY5BknCME4LinZD0a/eoUHXL
        OjFo53XoCpiuXJYo4CM+4x1zgxrL21PgTDttKSX
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] net: tulip: de4x5: Optimize if branch in de4x5_parse_params
Date:   Tue, 15 Mar 2022 15:49:52 +0800
Message-Id: <20220315074952.6577-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the de4x5_parse_params, 'if (strstr(p, "BNC_AUI"))' condition and
'if (strstr(p, "BNC_AUI"))' condition are both execute the statement
'lp->params.autosense = BNC', these two conditions can be combined.

In addition, in the current code logic, when p = "BNC", the judgments
need to be executed four times. In order to simplify the execution
process and keep the original code design, I used the statement which
is 'if (strstr(p, "BNC") || strstr(p, "BNC_AUI"))' to deal with it,
after that once 'strstr(p, "BNC")' is established, we no longer need
to judge whether 'strstr(p, "BNC_AUI")' is true(not NULL).

In this way, we can execute the judgment statement one time less.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 drivers/net/ethernet/dec/tulip/de4x5.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/dec/tulip/de4x5.c b/drivers/net/ethernet/dec/tulip/de4x5.c
index 71730ef4cd57..5900b8ef7f6f 100644
--- a/drivers/net/ethernet/dec/tulip/de4x5.c
+++ b/drivers/net/ethernet/dec/tulip/de4x5.c
@@ -5208,9 +5208,7 @@ de4x5_parse_params(struct net_device *dev)
 		lp->params.autosense = TP_NW;
 	    } else if (strstr(p, "TP")) {
 		lp->params.autosense = TP;
-	    } else if (strstr(p, "BNC_AUI")) {
-		lp->params.autosense = BNC;
-	    } else if (strstr(p, "BNC")) {
+	    } else if (strstr(p, "BNC") || strstr(p, "BNC_AUI")) {
 		lp->params.autosense = BNC;
 	    } else if (strstr(p, "AUI")) {
 		lp->params.autosense = AUI;
-- 
2.20.1



