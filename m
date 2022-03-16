Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79712C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Mar 2022 00:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352730AbiCPAE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 20:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350148AbiCPAE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:04:26 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D424F2194;
        Tue, 15 Mar 2022 17:03:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V7JsYey_1647388988;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V7JsYey_1647388988)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Mar 2022 08:03:09 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     davem@davemloft.net
Cc:     kuba@kernel.org, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ice: clean up one inconsistent indenting
Date:   Wed, 16 Mar 2022 08:03:07 +0800
Message-Id: <20220316000307.66863-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:
drivers/net/ethernet/intel/ice/ice_switch.c:5568 ice_find_dummy_packet()
warn: inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 7f3d97595890..25b8f6f726eb 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -5565,7 +5565,7 @@ ice_find_dummy_packet(struct ice_adv_lkup_elem *lkups, u16 lkups_cnt,
 					*offsets = dummy_ipv6_gtpu_ipv4_udp_packet_offsets;
 				} else {
 					*pkt = dummy_ipv6_gtpu_ipv4_tcp_packet;
-				*pkt_len = sizeof(dummy_ipv6_gtpu_ipv4_tcp_packet);
+					*pkt_len = sizeof(dummy_ipv6_gtpu_ipv4_tcp_packet);
 					*offsets = dummy_ipv6_gtpu_ipv4_tcp_packet_offsets;
 				}
 			}
-- 
2.20.1.7.g153144c

