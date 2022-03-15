Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A3DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 20:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351826AbiCOUw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 16:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351804AbiCOUwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:52:14 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B23954BE8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 13:51:01 -0700 (PDT)
Received: from ipservice-092-217-079-029.092.217.pools.vodafone-ip.de ([92.217.79.29] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nUE8A-00084h-2e; Tue, 15 Mar 2022 21:50:58 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 3/6] staging: r8188eu: remove unused function prototype
Date:   Tue, 15 Mar 2022 21:50:38 +0100
Message-Id: <20220315205041.2714168-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220315205041.2714168-1-martin@kaiser.cx>
References: <20220315205041.2714168-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the prototype for rtl8188eu_recv_hdl. This function does not exist
in the r8188eu driver.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtl8188e_recv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_recv.h b/drivers/staging/r8188eu/include/rtl8188e_recv.h
index 09adffd756de..8d06815d0374 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_recv.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_recv.h
@@ -35,7 +35,6 @@ enum rx_packet_type {
 
 s32 rtl8188eu_init_recv_priv(struct adapter *padapter);
 void rtl8188eu_free_recv_priv(struct adapter * padapter);
-void rtl8188eu_recv_hdl(struct adapter * padapter, struct recv_buf *precvbuf);
 void rtl8188eu_recv_tasklet(unsigned long priv);
 void rtl8188e_process_phy_info(struct adapter * padapter, void *prframe);
 void update_recvframe_phyinfo_88e(struct recv_frame *fra, struct phy_stat *phy);
-- 
2.30.2

