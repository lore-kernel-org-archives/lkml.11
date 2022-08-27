Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8170EECAAD2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Aug 2022 15:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiH0Pat (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Aug 2022 11:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbiH0Paj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 11:30:39 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4004E4D4EF;
        Sat, 27 Aug 2022 08:30:35 -0700 (PDT)
X-QQ-mid: bizesmtp67t1661614217tneioxme
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 27 Aug 2022 23:30:09 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: ao4JQgu0M3/ShWn/GLYK3b1OEZ3uMzuPtuR360O+xT4remUF8sEJUmlGenu1w
        7ozriyuDdhpj/ywfiV9TfWTIJ3IRRnAonvd1p7+qSpW3t8l7cSqosdLODe5NTd5LMVlBYMM
        vswvAoch5YOsj1AVU8EXQYXm3DmaJCnxlVX0jwCdCIfA4sPvwyh056LbeO1BMv8PJXdIdy+
        40GmK/QyUP4cjFsGNWc48c8ZOT6X3jFk5Wa9htaVF96RDaS5HUszn6Ue2B5mUBzHNornNNF
        scQp0O3vTf/pY0grjz1rtIpG9d2q+lLNZ26zS7+aYrvrWrRNedoRU95YAwoGxGRXV2dEAuJ
        5+QIvqfs0+NMuJlsW6p8cHMXbJqP3nlktmWXfCBprgQrnj5w0E=
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] usb: gadget: net2272: Remove the initialization of statics to 0
Date:   Sat, 27 Aug 2022 11:30:09 -0400
Message-Id: <20220827153009.4768-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is always unnecessary to initialise statics to 0.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/usb/gadget/udc/net2272.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index c97cd4bc817c..84605a4d0715 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -91,7 +91,7 @@ module_param(dma_mode, ushort, 0644);
  *      mode 2 == ep-a 1k, ep-b 1k, ep-c 512db
  *      mode 3 == ep-a 1k, ep-b disabled, ep-c 512db
  */
-static ushort fifo_mode = 0;
+static ushort fifo_mode;
 module_param(fifo_mode, ushort, 0644);
 
 /*
@@ -100,7 +100,7 @@ module_param(fifo_mode, ushort, 0644);
  * USB suspend requests will be ignored.  This is acceptable for
  * self-powered devices.  For bus powered devices set this to 1.
  */
-static ushort enable_suspend = 0;
+static ushort enable_suspend;
 module_param(enable_suspend, ushort, 0644);
 
 static void assert_out_naking(struct net2272_ep *ep, const char *where)
-- 
2.35.1

