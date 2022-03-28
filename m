Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89116C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 08:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbiC1Ipg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 04:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239468AbiC1Ipc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:45:32 -0400
Received: from mail.meizu.com (edge01.meizu.com [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BA34B1D2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 01:43:51 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 28 Mar
 2022 16:43:43 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 28 Mar
 2022 16:43:43 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <Larry.Finger@lwfinger.net>, <phil@philpotter.co.uk>,
        <gregkh@linuxfoundation.org>, <straube.linux@gmail.com>,
        <martin@kaiser.cx>
CC:     <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Haowen Bai" <baihaowen@meizu.com>
Subject: [PATCH V2] staging: r8188eu: Directly return _FAIL instead of using local ret variable
Date:   Mon, 28 Mar 2022 16:43:42 +0800
Message-ID: <1648457022-4076-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-125.meizu.com (172.16.1.125) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixes coccinelle warning:
./drivers/staging/r8188eu/core/rtw_mlme_ext.c:1518:14-17: Unneeded variable: "ret".
 Return "_FAIL" on line 1549

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1->V2: split into two patches.

 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 10d5f12..931e6f2 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -1515,7 +1515,6 @@ unsigned int OnAtim(struct adapter *padapter, struct recv_frame *precv_frame)
 
 unsigned int on_action_spct(struct adapter *padapter, struct recv_frame *precv_frame)
 {
-	unsigned int ret = _FAIL;
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 *pframe = precv_frame->rx_data;
@@ -1546,7 +1545,7 @@ unsigned int on_action_spct(struct adapter *padapter, struct recv_frame *precv_f
 	}
 
 exit:
-	return ret;
+	return _FAIL;
 }
 
 unsigned int OnAction_qos(struct adapter *padapter, struct recv_frame *precv_frame)
-- 
2.7.4

