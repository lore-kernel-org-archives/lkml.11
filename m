Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD955C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 02:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352071AbiFFCLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jun 2022 22:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbiFFCLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 22:11:10 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614DB2F389
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 19:11:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VFPqycH_1654481463;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VFPqycH_1654481463)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Jun 2022 10:11:04 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: [PATCH] MAINTAINERS: erofs: add myself as reviewer
Date:   Mon,  6 Jun 2022 10:11:03 +0800
Message-Id: <20220606021103.89211-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Glad to contribute the fscache mode to erofs. Sincerely I recommend
myself as the reviewer to maintain these codes.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1309e1496c23..6cd8b3631cc0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7388,6 +7388,7 @@ EROFS FILE SYSTEM
 M:	Gao Xiang <xiang@kernel.org>
 M:	Chao Yu <chao@kernel.org>
 R:	Yue Hu <huyue2@coolpad.com>
+R:	Jeffle Xu <jefflexu@linux.alibaba.com>
 L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
-- 
2.27.0

