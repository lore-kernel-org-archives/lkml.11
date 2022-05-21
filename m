Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05445C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 06:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240557AbiEUG5Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 May 2022 02:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240245AbiEUG5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 02:57:21 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1EE17996D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 23:57:19 -0700 (PDT)
Received: from pop-os.home ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id sJ34n96Lf3JPEsJ34n8Vfn; Sat, 21 May 2022 08:57:17 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 21 May 2022 08:57:17 +0200
X-ME-IP: 86.243.180.246
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH] ice: Use correct order for the parameters of devm_kcalloc()
Date:   Sat, 21 May 2022 08:57:13 +0200
Message-Id: <627df513c3acf65f9aa5f43ca2bf7826a73c0c7b.1653116222.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should have 'n', then 'size', not the opposite.
This is harmless because the 2 values are just multiplied, but having
the correct order silence a (unpublished yet) smatch warning.

While at it use '*tun_seg' instead '*seg'. The both variable have the same
type, so the result is the same, but it lokks more logical.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index 5d10c4f84a36..ead6d50fc0ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -852,7 +852,7 @@ ice_create_init_fdir_rule(struct ice_pf *pf, enum ice_fltr_ptype flow)
 	if (!seg)
 		return -ENOMEM;
 
-	tun_seg = devm_kcalloc(dev, sizeof(*seg), ICE_FD_HW_SEG_MAX,
+	tun_seg = devm_kcalloc(dev, ICE_FD_HW_SEG_MAX, sizeof(*tun_seg),
 			       GFP_KERNEL);
 	if (!tun_seg) {
 		devm_kfree(dev, seg);
@@ -1214,7 +1214,7 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
 	if (!seg)
 		return -ENOMEM;
 
-	tun_seg = devm_kcalloc(dev, sizeof(*seg), ICE_FD_HW_SEG_MAX,
+	tun_seg = devm_kcalloc(dev, ICE_FD_HW_SEG_MAX, sizeof(*tun_seg),
 			       GFP_KERNEL);
 	if (!tun_seg) {
 		devm_kfree(dev, seg);
-- 
2.34.1

