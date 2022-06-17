Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6A7C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 13:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbiFQNf6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 09:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiFQNf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:35:57 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55DB92DD40
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yuRiu
        CnunewqQxt3RNaqRELOefpKxwqd4ifIPvWRwyA=; b=fDDre4cf216t12tgFa03a
        jQvVXHvjwvdoqygOxAPH6JBogV5WGBA4enh/mvDQODciO9UR+HJz0yTH36HGamVE
        Gy7nVaKdzx5ld++suf3d7r2UzgEe2HpimBSaElxaKWPOCz78TOe1we7GQxFbEfaV
        rBLFNfbmjvsrjSAlAkPBiE=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgD3QHU6g6xiKS9+Ew--.39312S2;
        Fri, 17 Jun 2022 21:35:54 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     linux-kernel@vger.kernel.org
Cc:     Liang He <windhl@126.com>
Subject: [PATCH] firmware: Fix refcount leak bug in trusted_foundation
Date:   Fri, 17 Jun 2022 21:35:53 +0800
Message-Id: <20220617133553.4049515-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgD3QHU6g6xiKS9+Ew--.39312S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4UXry8JryrKryfJF45trb_yoWfKrg_ua
        y8XrW2kF4qga1aqrWUua9xZrZ5ArW8urs5Xr12y3Z5tw4UAwn8Xr1DurWkAwsrZr4UJF95
        Ar1rtrnYvFsrKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRFAp7UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2hojF1uwMOVRIwAAs4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In of_register_trusted_foundations(), of_find_compatible_node() will
return a node pointer with refcount incremented. We should use
of_node_put() when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/firmware/trusted_foundations.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/trusted_foundations.c b/drivers/firmware/trusted_foundations.c
index 1389fa9418a7..74ef947f5547 100644
--- a/drivers/firmware/trusted_foundations.c
+++ b/drivers/firmware/trusted_foundations.c
@@ -173,6 +173,7 @@ void of_register_trusted_foundations(void)
 		panic("Trusted Foundation: missing version-major property\n");
 	err = of_property_read_u32(node, "tlm,version-minor",
 				   &pdata.version_minor);
+	of_node_put(node);
 	if (err != 0)
 		panic("Trusted Foundation: missing version-minor property\n");
 	register_trusted_foundations(&pdata);
-- 
2.25.1

