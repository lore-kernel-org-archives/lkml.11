Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D5ACCA479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jul 2022 13:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbiGRNrn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbiGRNrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:47:31 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6A5DFD0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:47:26 -0700 (PDT)
X-QQ-mid: bizesmtp71t1658151970tevd8xum
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:46:08 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: HH6/KuQOBEbe8h1wPC21cD906qpjQ43R/x/qm4uCi/KrEmZTXIRTEdSChNBHZ
        YUsGH1/iNdMQRGpw/WZbVZa3bFKhnz7cySOcQFFL8kDPhkmHJtwABavUgMo13QRWmEnfiPH
        +i+BjBkxK1swlxmd2NPckNYet6OoAcP+GtMvIu3XDMDV7Jq3bWkX6CviAJs0Ovn063Db1lj
        feb1+51xLwBi8hr2QXeps+dsiw4NH8GoGiIhvH7mffo63yRdetS+kXafxcekSBYR2YmYxX0
        /omNLQxr7jO1cpygtNIkGSUvwRW/PmsbNR2DaTwnPFERFP/shEGrgUTLwgqOCsPrP3mmAXJ
        NxRVFxxUXQjiVz5qhVyqdCl0LDni/50mWr0kmuF9UzxJv1bVz91VO9lc1nXd49goEgVd5Kt
        59BQ7kD4HZilGQXZRI7OTg==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     jirislaby@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] tty: Fix comment typo
Date:   Fri, 15 Jul 2022 13:44:01 +0800
Message-Id: <20220715054401.9870-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `should' is duplicated in line 15, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/tty/amiserial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 5458e2b1c125..81e7f64c1739 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -12,7 +12,7 @@
  * (non hardware specific) changes to serial.c.
  *
  * The port is registered with the tty driver as minor device 64, and
- * therefore other ports should should only use 65 upwards.
+ * therefore other ports should only use 65 upwards.
  *
  * Richard Lucock 28/12/99
  *
-- 
2.35.1

