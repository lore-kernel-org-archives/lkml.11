Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4A2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 09:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiEXJB7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 05:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbiEXJBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:01:07 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED41E09
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:01:04 -0700 (PDT)
Received: from 162.sub194.ddfr.nl ([83.136.194.162] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ntQPT-0006Y3-3Z; Tue, 24 May 2022 11:00:59 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 08/12] staging: r8188eu: use mgmt to set the dialog token
Date:   Tue, 24 May 2022 11:00:25 +0200
Message-Id: <20220524090029.242584-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220524090029.242584-1-martin@kaiser.cx>
References: <20220521153824.218196-1-martin@kaiser.cx>
 <20220524090029.242584-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the mgmt structure in issue_action_BA to set the dialog token.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index aa73afc6e36a..ce6327dbc534 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5417,7 +5417,8 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 		do {
 			pmlmeinfo->dialogToken++;
 		} while (pmlmeinfo->dialogToken == 0);
-		pframe = rtw_set_fixed_ie(pframe, 1, &pmlmeinfo->dialogToken, &pattrib->pktlen);
+		mgmt->u.action.u.addba_req.dialog_token = pmlmeinfo->dialogToken;
+		pattrib->pktlen++;
 
 		BA_para_set = (0x1002 | ((status & 0xf) << 2)); /* immediate ack & 64 buffer size */
 		le_tmp = cpu_to_le16(BA_para_set);
-- 
2.30.2

