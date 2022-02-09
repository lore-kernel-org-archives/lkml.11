Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78EBC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 04:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345370AbiBIEOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 23:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346786AbiBIDhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:37:41 -0500
X-Greylist: delayed 106 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 19:37:38 PST
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BB3BC0401C7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=YvOhP
        o6ymYclh5k4417PVKOkRi78cNnblip3oZXJi9w=; b=b3YuP2NtlIcvzw+cUdRWX
        qCYVAPNjHzVRBpDCLxd2eJznjz1YqUrjhVmmT+x+KLnqPDcCusJXBLNo54Bl+n5r
        ThoAbeHLN1+Vi/W5cWYkEpSkfteSmZHwTWf2AqfILeL62CiVrtRXA4YC5gIxLUNB
        YakRCn9UInoEXg1HMb0UoI=
Received: from sysgbj8.hosso.cc (unknown [42.62.85.2])
        by smtp13 (Coremail) with SMTP id EcCowABH3AnbNgNi+NtICA--.41353S2;
        Wed, 09 Feb 2022 11:37:00 +0800 (CST)
From:   chengchaohang@163.com
To:     leon@kernel.org, maorg@nvidia.com, jgg@ziepe.ca,
        logang@deltatee.com, thunder.leizhen@huawei.com
Cc:     linux-kernel@vger.kernel.org,
        "chaohang.cheng" <chaohang.cheng@horizon.ai>
Subject: [PATCH] lib/scatterlist: Provide scatterlist hexdump.
Date:   Wed,  9 Feb 2022 11:36:59 +0800
Message-Id: <20220209033659.3461-1-chengchaohang@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowABH3AnbNgNi+NtICA--.41353S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF18ZF4xJF48AF48WFWkXrb_yoWkCrb_Ca
        47Jw45Gr4fGF4IqFW3WFWftFy8WFZ8ZF1I9F1Igr93W3s8urs8X34vqr9rAF45Way8Ca1D
        Gasaqas7XF1UXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5SeHDUUUUU==
X-Originating-IP: [42.62.85.2]
X-CM-SenderInfo: xfkh0wpfkd0xxdqjqiywtou0bp/xtbBzRyivF0CR+iuTgAAsf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "chaohang.cheng" <chaohang.cheng@horizon.ai>

A scatterlist hexdump is essential during debug, sometimes.

Signed-off-by: chaohang.cheng <chaohang.cheng@horizon.ai>
---
 include/linux/scatterlist.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 7ff9d6386c12..ef8ecaac0016 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -563,4 +563,21 @@ bool sg_miter_skip(struct sg_mapping_iter *miter, off_t offset);
 bool sg_miter_next(struct sg_mapping_iter *miter);
 void sg_miter_stop(struct sg_mapping_iter *miter);
 
+/*
+ * Hexdump scatterlist
+ *
+ * @sg: struct scatterlist* .
+ * it stands for the head of a scatterlist .
+ *
+ * note: print_hex_dump_debug is a dynamic debug .
+ *
+ */
+#define SG_HEXDUMP(sg)							\
+do {									\
+	struct scatterlist *sg_tmp = NULL;				\
+	for (sg_tmp = sg; sg_tmp; sg_tmp = sg_next(sg_tmp))		\
+		print_hex_dump_debug("", DUMP_PREFIX_OFFSET,		\
+			16, 1, sg_virt(sg_tmp), sg_tmp->length, true);	\
+} while (0)
+
 #endif /* _LINUX_SCATTERLIST_H */
-- 
2.25.1

