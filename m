Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53289C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jun 2022 07:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350448AbiFAH6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jun 2022 03:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244461AbiFAH6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:58:14 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FD7433A3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:58:13 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 1 Jun 2022
 15:58:05 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 1 Jun
 2022 15:58:04 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Jan Harkes <jaharkes@cs.cmu.edu>, <coda@cs.cmu.edu>
CC:     Haowen Bai <baihaowen@meizu.com>, <codalist@coda.cs.cmu.edu>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] coda: remove unused variable
Date:   Wed, 1 Jun 2022 15:58:03 +0800
Message-ID: <1654070283-7216-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable insize is initialized but never used otherwise.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 fs/coda/upcall.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index 59f6cfd06f96..c214b424426d 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -477,10 +477,9 @@ int venus_pioctl(struct super_block *sb, struct CodaFid *fid,
 {
         union inputArgs *inp;
         union outputArgs *outp;  
-	int insize, outsize, error;
+	int outsize, error;
 	int iocsize;
 
-	insize = VC_MAXMSGSIZE;
 	UPARG(CODA_IOCTL);
 
         /* build packet for Venus */
-- 
2.7.4

