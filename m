Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE09CCA47C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 10:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiFWKsn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 06:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiFWKsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:48:41 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703E5496A6;
        Thu, 23 Jun 2022 03:48:36 -0700 (PDT)
X-QQ-mid: bizesmtp77t1655981168ta0skglm
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 18:46:03 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000D00A0000000
X-QQ-FEAT: Zs8ezjsHqGq7OayqfPAflnYXwVZ1YmP53qhyqp4jSvlWN9c04a0OLw4eXzGhb
        DVIHqG4eQqskybbEO35+v7FEOqpkrXLdUeNwzyQ5tirBnzj3vdabbl0AxKr1qFQbO/BZJ3M
        5t6ivbESZPQ96CglOU8/FAagr5wJ62KUOIoy+U6Cb/FdFBiG9yq7Gmq0uDM7I+d+54cFHyb
        BWots8xPXRYsL8DCUxapxABT4O/3WkFrB/6vA6EUstWF8xdSbWPekAZ1k0yqfBCkLlzY9Bm
        o+HVX3FCyRnE4JvmLlMgbXv03pHKpriel+W6yngWrSNBO/ZmAwLzUFSk7Y+3AbBmF3Cqo9j
        62oAnN8Uk//nPt1UgvEw8MU9IijZQ==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     idosch@nvidia.com, petrm@nvidia.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] mlxsw: drop unexpected word 'for' in comments
Date:   Thu, 23 Jun 2022 18:46:01 +0800
Message-Id: <20220623104601.48149-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'for' in the comments that need to be dropped

file - drivers/net/ethernet/mellanox/mlxsw/spectrum2_kvdl.c
line - 18

	 * ids for for this purpose in partition definition.
changed to:

	 * ids for this purpose in partition definition.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum2_kvdl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum2_kvdl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum2_kvdl.c
index 10ae1115de6c..24ff305a2995 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum2_kvdl.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum2_kvdl.c
@@ -15,7 +15,7 @@ struct mlxsw_sp2_kvdl_part_info {
 	 * usage bits we need and how many indexes there are
 	 * represented by a single bit. This could be got from FW
 	 * querying appropriate resources. So have the resource
-	 * ids for for this purpose in partition definition.
+	 * ids for this purpose in partition definition.
 	 */
 	enum mlxsw_res_id usage_bit_count_res_id;
 	enum mlxsw_res_id index_range_res_id;
-- 
2.17.1

