Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CB7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 09:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245115AbiEQJ7C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 05:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243178AbiEQJ6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:58:38 -0400
X-Greylist: delayed 131 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 May 2022 02:58:25 PDT
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B11A43394;
        Tue, 17 May 2022 02:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=RGaHmVYObVzH+m7sYp
        QCxzcT7fn0h4cxILJiyo027rw=; b=H311eSeFVeS7yQZ7Yxaem9vUXiKucTs9MU
        lufXYklFJVA4BoUEUfTt/9Tgj/Hw/QBdh4SinvpRG6UqDPTsXxwhoAf6kdmiGy6X
        YDcwYazkr0iBNtsVExdU5Rc4T8kKBnWvwwqZqjz5WAZ0PXqktQVmq8rCsEB8dxMF
        Zv+GX4lnY=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp7 (Coremail) with SMTP id C8CowAAXIJObcYNi42D3Cw--.59736S4;
        Tue, 17 May 2022 17:57:57 +0800 (CST)
From:   Yuanjun Gong <ruc_gongyuanjun@163.com>
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: [PATCH 1/1] drm/amd/pm: fix a potential gpu_metrics_table memory leak
Date:   Tue, 17 May 2022 17:57:46 +0800
Message-Id: <20220517095746.7537-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: C8CowAAXIJObcYNi42D3Cw--.59736S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFW7tFW7KFWxZw1DZF4xWFg_yoWftrc_Gr
        y8Xwn3Z3sxCF1vyrWrZFs8ZFyYkF15CF4kJFnYg390vr17XFy3Za9FqF1kua18CF1UZFWD
        XF1kXF98CrZrJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNJ5rUUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/xtbB6BUE5WBHIt94LQAAsT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gong Yuanjun <ruc_gongyuanjun@163.com>

gpu_metrics_table is allocated in yellow_carp_init_smc_tables() but
not freed in yellow_carp_fini_smc_tables().

Signed-off-by: Gong Yuanjun <ruc_gongyuanjun@163.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index e2d099409123..c66c39ccf19c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -190,6 +190,9 @@ static int yellow_carp_fini_smc_tables(struct smu_context *smu)
 	kfree(smu_table->watermarks_table);
 	smu_table->watermarks_table = NULL;
 
+	kfree(smu_table->gpu_metrics_table);
+	smu_table->gpu_metrics_table = NULL;
+
 	return 0;
 }
 
-- 
2.17.1

