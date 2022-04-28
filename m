Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06126C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Apr 2022 12:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346313AbiD1MeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Apr 2022 08:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346298AbiD1MeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:34:01 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E70E5A2C4;
        Thu, 28 Apr 2022 05:30:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=mqaio@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VBaxOrU_1651149040;
Received: from localhost(mailfrom:mqaio@linux.alibaba.com fp:SMTPD_---0VBaxOrU_1651149040)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Apr 2022 20:30:41 +0800
From:   Qiao Ma <mqaio@linux.alibaba.com>
To:     luobin9@huawei.com, davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] hinic: fix bug of wq out of bound access
Date:   Thu, 28 Apr 2022 20:30:16 +0800
Message-Id: <282817b0e1ae2e28fdf3ed8271a04e77f57bf42e.1651148587.git.mqaio@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If wq has only one page, we need to check wqe rolling over page by
compare end_idx and curr_idx, and then copy wqe to shadow wqe to
avoid out of bound access.
This work has been done in hinic_get_wqe, but missed for hinic_read_wqe.
This patch fixes it, and removes unnecessary MASKED_WQE_IDX().

Fixes: 7dd29ee12865 ("hinic: add sriov feature support")
Signed-off-by: Qiao Ma <mqaio@linux.alibaba.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c
index 5dc3743f8091..f04ac00e3e70 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c
@@ -771,7 +771,7 @@ struct hinic_hw_wqe *hinic_get_wqe(struct hinic_wq *wq, unsigned int wqe_size,
 	/* If we only have one page, still need to get shadown wqe when
 	 * wqe rolling-over page
 	 */
-	if (curr_pg != end_pg || MASKED_WQE_IDX(wq, end_prod_idx) < *prod_idx) {
+	if (curr_pg != end_pg || end_prod_idx < *prod_idx) {
 		void *shadow_addr = &wq->shadow_wqe[curr_pg * wq->max_wqe_size];
 
 		copy_wqe_to_shadow(wq, shadow_addr, num_wqebbs, *prod_idx);
@@ -841,7 +841,10 @@ struct hinic_hw_wqe *hinic_read_wqe(struct hinic_wq *wq, unsigned int wqe_size,
 
 	*cons_idx = curr_cons_idx;
 
-	if (curr_pg != end_pg) {
+	/* If we only have one page, still need to get shadown wqe when
+	 * wqe rolling-over page
+	 */
+	if (curr_pg != end_pg || end_cons_idx < curr_cons_idx) {
 		void *shadow_addr = &wq->shadow_wqe[curr_pg * wq->max_wqe_size];
 
 		copy_wqe_to_shadow(wq, shadow_addr, num_wqebbs, *cons_idx);
-- 
1.8.3.1

