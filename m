Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FEDC19F29
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jul 2022 10:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiG0Kku (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jul 2022 06:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiG0Kkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:40:47 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7DD617B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:40:42 -0700 (PDT)
X-QQ-mid: bizesmtp71t1658918434ty604371
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 27 Jul 2022 18:40:29 +0800 (CST)
X-QQ-SSF: 0100000000000030C000B00A0000020
X-QQ-FEAT: C2zsvWT0ctXZohQ/cZ71IbVYX22hUrNjSquXw9mRHWjFV0DYkYPEVEJ3UEg4e
        ytiu85joJK7Enu5jMnCDkFF+E3X6mR0FtX3KOEoZFn/4jdvFTILNtHm3gJVass02wUotxuK
        vZNGTl5Og/gAgTBVXFrZBoeUevt6QhXgB/wVfJcNN3SZ6LgGTZZwARAGPyTAU36W8uQI+fF
        q1ncDg4xlpojIhBD5AQYbHWALMn+ahD3MIYzFDnJRuaIhSwi7CZiitEmc2zpBGH8hFswEha
        2gJL6QY8BBUWxZ/kSmOQGRAYKkHaINoflCG7XeuP3EYU5HzUIk4JaS3HLiZdKgDEbU4lu+Y
        8vrvj/9bZL7xOnrhyIi+SEsW5Um993gTBkbx4M0
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] tools: Fix code typo
Date:   Wed, 27 Jul 2022 18:40:27 +0800
Message-Id: <20220727104027.32515-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be better to change'unsigned'to'unsigned int'.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 tools/virtio/ringtest/noring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/ringtest/noring.c b/tools/virtio/ringtest/noring.c
index ce2440d5ca93..3deb8413c289 100644
--- a/tools/virtio/ringtest/noring.c
+++ b/tools/virtio/ringtest/noring.c
@@ -9,7 +9,7 @@ void alloc_ring(void)
 }
 
 /* guest side */
-int add_inbuf(unsigned len, void *buf, void *datap)
+int add_inbuf(unsigned int len, void *buf, void *datap)
 {
 	return 0;
 }
-- 
2.30.2

