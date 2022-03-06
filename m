Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB387C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Mar 2022 08:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiCFI3w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Mar 2022 03:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiCFI3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 03:29:51 -0500
Received: from smtpbg501.qq.com (smtpbg501.qq.com [203.205.250.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDEB3FBF1
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 00:28:55 -0800 (PST)
X-QQ-mid: bizesmtp70t1646555298tpc46is0
Received: from localhost.localdomain ( [114.222.120.105])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Mar 2022 16:28:10 +0800 (CST)
X-QQ-SSF: 01400000002000B0I000C00A0000000
X-QQ-FEAT: qRSZ1HlaXGByGca36I+bIIq76RHZ8CQngWUNAw/6zayHFsrox5oEIx274EzHu
        opQ/Wl/Ui53PubUtStOlaI5Uq1yLpQS2H70ssqkc2PDYbFW3qu2IGW4ali+qLNTwkEsAWKC
        04pIBKEm4AUOpQMEjlfUwk/LXajyXBwWlq10k1cXxyFetq/gTEBQYbK41/tKTf/+8GrFPXO
        fnWX5tqPb7g0603XwTgEKHb80Z378teBmb14PFQ8dXRk4neRHLa3rR9ZO6XwEyfv2jWLARO
        zG+wJW7TM5HRXxNDw5yBU2daTyIYWuCIh2c5mr3S1Em/rqpOrCBUArZIalmVB4Q57fpeLIh
        0iGSPIL2RZJZnDEl6ldB7pCYXm7NbbdaqURaOf36nsmVoMkB0k=
X-QQ-GoodBg: 2
From:   Lianjie Zhang <zhanglianjie@uniontech.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lianjie Zhang <zhanglianjie@uniontech.com>
Subject: [PATCH] bonding: helper macro __ATTR_RO to make code more clear
Date:   Sun,  6 Mar 2022 16:28:08 +0800
Message-Id: <20220306082808.85844-1-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lianjie Zhang <zhanglianjie@uniontech.com>

diff --git a/drivers/net/bonding/bond_sysfs_slave.c b/drivers/net/bonding/bond_sysfs_slave.c
index 6a6cdd0bb258..69b0a3751dff 100644
--- a/drivers/net/bonding/bond_sysfs_slave.c
+++ b/drivers/net/bonding/bond_sysfs_slave.c
@@ -15,14 +15,8 @@ struct slave_attribute {
 	ssize_t (*show)(struct slave *, char *);
 };

-#define SLAVE_ATTR(_name, _mode, _show)				\
-const struct slave_attribute slave_attr_##_name = {		\
-	.attr = {.name = __stringify(_name),			\
-		 .mode = _mode },				\
-	.show	= _show,					\
-};
 #define SLAVE_ATTR_RO(_name)					\
-	SLAVE_ATTR(_name, 0444, _name##_show)
+const struct slave_attribute slave_attr_##_name = __ATTR_RO(_name)

 static ssize_t state_show(struct slave *slave, char *buf)
 {
--
2.20.1



