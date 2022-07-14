Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFC0CCA47B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 08:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbiGNIgZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 04:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiGNIgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:36:23 -0400
Received: from syslogsrv (unknown [217.20.186.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21633D5B7;
        Thu, 14 Jul 2022 01:36:22 -0700 (PDT)
Received: from fg200.ow.s ([172.20.254.44] helo=localhost.localdomain)
        by syslogsrv with esmtp (Exim 4.90_1)
        (envelope-from <maksym.glubokiy@plvision.eu>)
        id 1oBuKP-000CGL-Kp; Thu, 14 Jul 2022 11:36:09 +0300
From:   Maksym Glubokiy <maksym.glubokiy@plvision.eu>
To:     Taras Chornyi <tchornyi@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Maksym Glubokiy <maksym.glubokiy@plvision.eu>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>
Subject: [PATCH net-next] net: prestera: acl: add support for 'police' action on egress
Date:   Thu, 14 Jul 2022 11:35:41 +0300
Message-Id: <20220714083541.1973919-1-maksym.glubokiy@plvision.eu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagate ingress/egress direction for 'police' action down to hardware.

Co-developed-by: Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>
Signed-off-by: Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>
Signed-off-by: Maksym Glubokiy <maksym.glubokiy@plvision.eu>
---
 drivers/net/ethernet/marvell/prestera/prestera_flower.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_flower.c b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
index 652aa95e65ac..92c6ace125e0 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_flower.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
@@ -116,7 +116,7 @@ static int prestera_flower_parse_actions(struct prestera_flow_block *block,
 			rule->re_arg.police.rate =
 				act->police.rate_bytes_ps;
 			rule->re_arg.police.burst = act->police.burst;
-			rule->re_arg.police.ingress = true;
+			rule->re_arg.police.ingress = block->ingress;
 			break;
 		case FLOW_ACTION_GOTO:
 			err = prestera_flower_parse_goto_action(block, rule,
-- 
2.25.1

