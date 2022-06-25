Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0AFC43334
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jun 2022 07:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiFYHJO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jun 2022 03:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiFYHJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 03:09:13 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DA1220F6;
        Sat, 25 Jun 2022 00:09:08 -0700 (PDT)
X-QQ-mid: bizesmtp73t1656140813t2579wch
Received: from localhost.localdomain ( [125.70.163.206])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 25 Jun 2022 15:06:39 +0800 (CST)
X-QQ-SSF: 0100000000200060C000B00A0000000
X-QQ-FEAT: 3u0oYPVhaeOCQ9MuS67mRqj+E/BEgpxpnesZL5zezAs7/KWq6nXpfPisKurFE
        DcM1SfSaw7hFtPuz8DPgWOO13RyYpkZsJ5tiI/58LH5wIVYt31VTuBJndxcGG4T/bMZE+iW
        fFydsH4HvORGxWzbkGgHDdhGbfDKWmk55P7fBjMXc/i86W/qXb7poIvPENPPqOQD+27ko2N
        MYSsE8ee+rwGrmKNJCGC/3fWzYiCt6bPS1DnVdaFBlXga9jr1G7+eem9BbYrxS1qRMnRm6l
        IB+AhpYsR23QVW4gU68mCxzYegADrH5kAT6jJPOv9oCidO4qHtg5ecIt41010rv1vylotwC
        ojmEh8yVPgdjV35jSw=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     thomas.lendacky@amd.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] amd/xgbe: fix repeated words in comments
Date:   Sat, 25 Jun 2022 15:06:33 +0800
Message-Id: <20220625070633.64982-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'use'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index d9547552ceef..b875c430222e 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -417,7 +417,7 @@ struct xgbe_rx_ring_data {
 
 /* Structure used to hold information related to the descriptor
  * and the packet associated with the descriptor (always use
- * use the XGBE_GET_DESC_DATA macro to access this data from the ring)
+ * the XGBE_GET_DESC_DATA macro to access this data from the ring)
  */
 struct xgbe_ring_data {
 	struct xgbe_ring_desc *rdesc;	/* Virtual address of descriptor */
-- 
2.36.1

