Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B87C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Apr 2022 16:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359594AbiDCQ5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Apr 2022 12:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359558AbiDCQ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:56:54 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81523393C1
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:54:59 -0700 (PDT)
Received: from dslb-094-219-033-178.094.219.pools.vodafone-ip.de ([94.219.33.178] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nb3V4-0008D7-Cv; Sun, 03 Apr 2022 18:54:50 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 05/11] staging: r8188eu: to_fr_ds cannot be 3 here
Date:   Sun,  3 Apr 2022 18:54:32 +0200
Message-Id: <20220403165438.357728-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220403165438.357728-1-martin@kaiser.cx>
References: <20220403165438.357728-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove two unnecessary ternary operators in validate_recv_data_frame.
pattrib->to_fr_ds cannot be 3 in these places. If it was 3, we'd already
have returned an error to the caller.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 200d8c6c6e11..47d4fd01824f 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1001,13 +1001,13 @@ static int validate_recv_data_frame(struct adapter *adapter,
 		pattrib->priority = GetPriority((ptr + 24));
 		pattrib->ack_policy = GetAckpolicy((ptr + 24));
 		pattrib->amsdu = GetAMsdu((ptr + 24));
-		pattrib->hdrlen = pattrib->to_fr_ds == 3 ? 32 : 26;
+		pattrib->hdrlen = 26;
 
 		if (pattrib->priority != 0 && pattrib->priority != 3)
 			adapter->recvpriv.bIsAnyNonBEPkts = true;
 	} else {
 		pattrib->priority = 0;
-		pattrib->hdrlen = pattrib->to_fr_ds == 3 ? 30 : 24;
+		pattrib->hdrlen = 24;
 	}
 
 	if (pattrib->order)/* HT-CTRL 11n */
-- 
2.30.2

