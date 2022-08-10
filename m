Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D3BC25B07
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Aug 2022 06:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiHJGHw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Aug 2022 02:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiHJGHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:07:50 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5568561DAE
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:07:47 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id EER00042;
        Wed, 10 Aug 2022 14:07:42 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.9; Wed, 10 Aug 2022 14:07:41 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] nvdimm: Call ida_simple_remove() when failed
Date:   Wed, 10 Aug 2022 02:07:37 -0400
Message-ID: <20220810060737.5087-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   20228101407423e730e450a495fa8ac99b446cb56c639
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function nvdimm_bus_register(), when code execution fails, we should
call ida_simple_remove() to free ida.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/nvdimm/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index b38d0355b0ac..3415dc62632b 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -371,6 +371,7 @@ struct nvdimm_bus *nvdimm_bus_register(struct device *parent,
 	return nvdimm_bus;
  err:
 	put_device(&nvdimm_bus->dev);
+	ida_simple_remove(&nd_ida, nvdimm_bus->id);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(nvdimm_bus_register);
-- 
2.27.0

