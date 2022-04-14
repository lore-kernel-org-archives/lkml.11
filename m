Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D147FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 10:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbiDNKDy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 06:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiDNKDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:03:47 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67CF6D969
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:01:21 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 14 Apr
 2022 18:01:21 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 14 Apr
 2022 18:01:19 +0800
From:   Haowen Bai <baihaowen@meizu.com>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] virt: sevguest: Fix bool function returning negative value
Date:   Thu, 14 Apr 2022 18:01:17 +0800
Message-ID: <1649930477-10651-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

function enc_payload() is bool but return signedness value.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/virt/coco/sevguest/sevguest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
index 15afb6ce8d19..07adf3145d76 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -276,7 +276,7 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
 	return dec_payload(snp_dev, resp, payload, resp_hdr->msg_sz + crypto->a_len);
 }
 
-static bool enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
+static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
 			void *payload, size_t sz)
 {
 	struct snp_guest_msg *req = snp_dev->request;
-- 
2.7.4

