Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B155CC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Feb 2022 08:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiB0Iqi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Feb 2022 03:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiB0Iqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 03:46:36 -0500
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24E258E7E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 00:45:55 -0800 (PST)
X-QQ-mid: bizesmtp75t1645951549tnaiglpy
Received: from localhost.localdomain (unknown [202.96.137.248])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 27 Feb 2022 16:45:45 +0800 (CST)
X-QQ-SSF: 01400000000000D0N000B00A0000000
X-QQ-FEAT: F3yR32iATbhJMNxbc1/wHAQGmD/mIVH+L6iJric5H1HxFw0Rc/4TH6koD28EC
        BZGDGp1ca3151OwASk12UNvw/9uLV/zZn1fXLgKOz8Cgi1WDVcEDOWFcdc8O7NCr4eZPME9
        fnWuqrH2gRYU84H9ShkHAQFR/XiX1GEchO1oWWUX26vwzHqd81oN/zepy+IwvpvUtBZVcIw
        bfwm8bsbiOYCiq2l48ydRXUE0jSjOHgy3SI8Tbpm97ZE/PefMOjYBhJKI3wYcYHyDXetPua
        0QU17TPRHZvmXnwHPLbYlXff7UU6DFr2L9lkdMSclXgeTxh3Qpp9tckupRAL5buZAjVfFBj
        EGfgHZa
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] mm/vmalloc.c: fix a comment
Date:   Sun, 27 Feb 2022 16:45:44 +0800
Message-Id: <20220227084544.4681-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sir/Madam,

The sentence
"but the mempolcy want to alloc memory by interleaving"
should be rephrased with
"but the mempolicy wants to alloc memory by interleaving"
where "mempolicy" is a struct name.

Thanks and best regards,
Yixuan Cao

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b454cf1a261f..89d48d8eb20c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2905,7 +2905,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			/* memory allocation should consider mempolicy, we can't
 			 * wrongly use nearest node when nid == NUMA_NO_NODE,
 			 * otherwise memory may be allocated in only one node,
-			 * but mempolcy want to alloc memory by interleaving.
+			 * but mempolicy want to alloc memory by interleaving.
 			 */
 			if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
 				nr = alloc_pages_bulk_array_mempolicy(bulk_gfp,
-- 
2.31.1



