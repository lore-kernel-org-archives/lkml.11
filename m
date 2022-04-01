Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11EDC3526F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 15:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350007AbiDAPdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349994AbiDAO6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:58:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BB4179B09;
        Fri,  1 Apr 2022 07:45:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47CCBB824AF;
        Fri,  1 Apr 2022 14:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9355C3410F;
        Fri,  1 Apr 2022 14:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648824348;
        bh=KUoN2sAQwHXFoP8k41WIlisIhknCVrq5bbCR10RaRVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hDsYJkrDD06tUSwkWSNCTwOEbWAbWFHFMbUpbb8KfbI91wsML9LgeZkG5mbDgyzOt
         iQENZmn4JaZBtU9OU4IhLR002OdF5siCgdLNeDc+ecsUlshKQSr25bGcHpTdYT2xjj
         9X6GqckRVA+fHwj/9oHWUM/0ZRZH8bnqzwZqlI+l7AsdK2npNQtX0y3VYZaoiiaEmz
         ypdZwvZwT0+7Ms/KqGsdksdTaz5Qrdo76fASwT6zs308Io8LGQcirtW49k2oeYklh6
         ID84zj0LM8m6aW/odDoSQiRqCFlG1I+Lly+oPtK7jcdiuz2DnciYoKXeIDkh45+N7z
         y4/0t6Y1L+Hgw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Chan <michael.chan@broadcom.com>,
        Colin Winegarden <colin.winegarden@broadcom.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 28/37] bnxt_en: Eliminate unintended link toggle during FW reset
Date:   Fri,  1 Apr 2022 10:44:37 -0400
Message-Id: <20220401144446.1954694-28-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401144446.1954694-1-sashal@kernel.org>
References: <20220401144446.1954694-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 7c492a2530c1f05441da541307c2534230dfd59b ]

If the flow control settings have been changed, a subsequent FW reset
may cause the ethernet link to toggle unnecessarily.  This link toggle
will increase the down time by a few seconds.

The problem is caused by bnxt_update_phy_setting() detecting a false
mismatch in the flow control settings between the stored software
settings and the current FW settings after the FW reset.  This mismatch
is caused by the AUTONEG bit added to link_info->req_flow_ctrl in an
inconsistent way in bnxt_set_pauseparam() in autoneg mode.  The AUTONEG
bit should not be added to link_info->req_flow_ctrl.

Reviewed-by: Colin Winegarden <colin.winegarden@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 97aff84fd1d1..d74c6a34b936 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1673,9 +1673,7 @@ static int bnxt_set_pauseparam(struct net_device *dev,
 		}
 
 		link_info->autoneg |= BNXT_AUTONEG_FLOW_CTRL;
-		if (bp->hwrm_spec_code >= 0x10201)
-			link_info->req_flow_ctrl =
-				PORT_PHY_CFG_REQ_AUTO_PAUSE_AUTONEG_PAUSE;
+		link_info->req_flow_ctrl = 0;
 	} else {
 		/* when transition from auto pause to force pause,
 		 * force a link change
-- 
2.34.1

