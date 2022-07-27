Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80238C04A68
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jul 2022 23:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiG0XiN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jul 2022 19:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiG0XiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 19:38:10 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18ADC0D;
        Wed, 27 Jul 2022 16:38:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VKcQYgS_1658965083;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VKcQYgS_1658965083)
          by smtp.aliyun-inc.com;
          Thu, 28 Jul 2022 07:38:04 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     idosch@nvidia.com
Cc:     petrm@nvidia.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] mlxsw: core_linecards: Remove duplicated include in core_linecard_dev.c
Date:   Thu, 28 Jul 2022 07:38:01 +0800
Message-Id: <20220727233801.23781-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following includecheck warning:
./drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.c: linux/err.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.c b/drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.c
index 49fee038a99c..af37e650a8ad 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.c
@@ -5,7 +5,6 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/types.h>
-#include <linux/err.h>
 #include <linux/auxiliary_bus.h>
 #include <linux/idr.h>
 #include <linux/gfp.h>
-- 
2.20.1.7.g153144c

