Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6FBC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Feb 2022 03:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiBZD2B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 22:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiBZD15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 22:27:57 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31D42ADED1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 19:27:17 -0800 (PST)
X-QQ-mid: bizesmtp71t1645846020tobsl2hv
Received: from localhost.localdomain (unknown [202.96.137.248])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 26 Feb 2022 11:26:44 +0800 (CST)
X-QQ-SSF: 01400000002000D0N000B00A0000000
X-QQ-FEAT: iMwtnhZSIzGHLVrpCzwFeORZB+16tOANmrQOm7BWF0BWyIJNjZH8/cRezNC+m
        9IFwNTIAgfAlGxqb5osCTTNaWPckedoqLH+CHV6rWmOqeZ3aL/OpWAY71VPpRg+d6O991B1
        vbPpc9hOj+GWsldigJ6q64a8FKjQFi4xLuGsK7DYO7DOmYQoPmr1tcBKmBLKwgMB+2OrpsE
        IxSbIbRfzI7Zk7a2EFil2gf/86boXrH3TCLw5VhxOPCmnaAR1Hi4XXbqn2GCA7lJRo9kYc9
        gZUmtnRBg/mTwaglu2m2hXWdMIePqUpFpjw2v8mSKa5w/kMhozFs0LdHF6mpe5rkd4Lo1wl
        Ypce5+Hwas2GLrgLGKZ5lc3JtsYtA==
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     corbet@lwn.net
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        weizhenliang@huawei.com, georgi.djakov@linaro.org,
        skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, hanshenghong2019@email.szu.edu.cn,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] Documentation/vm/page_owner.rst: fix function usage information for -f option
Date:   Sat, 26 Feb 2022 11:26:41 +0800
Message-Id: <20220226032641.2493-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous linux-next based patch
d7e9705bb715fc3deb16bfd5976d9d50f8d2aa67
(tools/vm/page_owner_sort.c: fix the instructions for use)
stated that the description for the "-f" option should be
"Filter out the information of blocks whose memory
has been released."

So I made the same changes in this document.

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 Documentation/vm/page_owner.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index aec1906976f4..32ca54757d3f 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -78,7 +78,7 @@ Usage
 
 2) Enable page owner: add "page_owner=on" to boot cmdline.
 
-3) Do the job what you want to debug
+3) Do the job what you want to debug.
 
 4) Analyze information from page owner::
 
@@ -126,4 +126,4 @@ Usage
 		-c		Cull by comparing stacktrace instead of total block.
 
 	Filter:
-		-f		Filter out the information of blocks whose memory has not been released.
+		-f		Filter out the information of blocks whose memory has been released.
-- 
2.31.1



