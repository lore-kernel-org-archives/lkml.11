Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B6BC19F2C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Aug 2022 12:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbiHBMIW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiHBMIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:08:20 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A7D32ED6;
        Tue,  2 Aug 2022 05:08:15 -0700 (PDT)
X-QQ-mid: bizesmtp62t1659442089tv8fvdlz
Received: from kali.lan ( [125.69.43.47])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 02 Aug 2022 20:08:08 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: VbOeDQvtdXPzdTP540OXr2V8VXFh4s5efJtqO5kWj/hNmf2ooXxX1+7947pz6
        VamZqYSKESmawH3SIx1Ch7V1vbbMLRuVTzK9PODPxJF+uadV0CjX36lKjIagP4XmsAJtbjp
        FEE5aWcay6CI25BylkhrOX/MaKvprpy2Y4+BKHseu/4okcR+HGjyPxFR3AUpOaVBFnrskJh
        VCpY/+I+H+dVNDDnfsp5OZ5oEW/WDpPK1d18h7wSNB/f7Ob6gzQ2p2rYZ7HS0a2InmziH7k
        nX5VLRDuluDWuSbE0jt1T1mI4zjp5CwKQcq5rla1tgB8esG7rNrMi51Q7rLwBiJeAd7217n
        G1nzgLytdbwX0fcG2+MgPG4MK8XBd/HtggMP3/wdLefLfjbFyVij6ldQN2eN3bunIoJyEnU
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] USB: UHCI: Fix comment typo
Date:   Wed,  3 Aug 2022 04:08:06 +0800
Message-Id: <20220802200806.5902-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second `then' might be a typo, replace it to `the'.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/usb/host/uhci-q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/uhci-q.c b/drivers/usb/host/uhci-q.c
index 35fcb826152c..09b721336b23 100644
--- a/drivers/usb/host/uhci-q.c
+++ b/drivers/usb/host/uhci-q.c
@@ -345,7 +345,7 @@ static int uhci_cleanup_queue(struct uhci_hcd *uhci, struct uhci_qh *qh,
 		goto done;
 	}
 
-	/* If the QH element pointer is UHCI_PTR_TERM then then currently
+	/* If the QH element pointer is UHCI_PTR_TERM then the currently
 	 * executing URB has already been unlinked, so this one isn't it. */
 	if (qh_element(qh) == UHCI_PTR_TERM(uhci))
 		goto done;
-- 
2.35.1

