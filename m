Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC354ECAAA1
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 03:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiIBD0o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 23:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiIBD0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:26:37 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37D3796A6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:26:36 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w139so643273pfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 20:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=s6bst2A0kCUrqDNhcQ/B6E8Aii0yys2KniBEwPWQ3OM=;
        b=V6tNgyVKRSrrQ0mQrbqdGQWb/KuJ0IygBc8Ge8Fw+9ANh7bRUfUgCIf9pHXYUMKXTW
         CCxrHeif6nsL984E4fJF4jw0vhc1eYa9FfZjczRtcwwXJi6thTO3W8eHDoQlMeR9kpz9
         ra60yV1HeUzvL7GiKX3nmomtmr42wOpGJqIIqMszIf9hkvTPBcXLVa9eO+RFx2QF3Y57
         syifW/LzQOEYCn6zlf6NBNXOgRT8JGxBYoE+VXbOrtw5v+VYrwFXSDG3n5SX+4KB5OKX
         oAhlB9YEtVS6pwcorCxBtIrT1oiesQnlJ571Wj5aGLzsDeL/TrY0TxtQuTH3Q3pBSGFZ
         TQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=s6bst2A0kCUrqDNhcQ/B6E8Aii0yys2KniBEwPWQ3OM=;
        b=O55WtwKq2Lx29U0fO/6UuG/DSeVY4442hXk+ajM25YIJWigWKVORQuhw+Iax5REx2z
         6ggfG5EMjwsTQSsrGY40+cAInxi6aBmodyYIPTD+i4iP4JJVgtRnz0Jwc7ealazoPbAT
         YlrIXcRFK66fw7rZ1zakXsKIKn0dAdr45rxw6RXIH3A67Li5M79B81emaphIuh2Rj7Vp
         DhOyFr36tg2HQk8Ow2ds5p7s/oFYmsc6R4BhHAmFqj5F4p+/a2P2ra8SgYCq48OvXi23
         1+tfYwPzCE5sUevh5dQBN55iDdGBd513Ucu3yJQSatA/FCld4uAngopxvZ4ly0oHgwGA
         zwZg==
X-Gm-Message-State: ACgBeo12JJEq+ZCQ+7Q6XiXUN1fsMoIlpOEg7j9Q5SJn4gQStIqyTuEf
        729fx29cvyObiBVPP6GvbBY=
X-Google-Smtp-Source: AA6agR6cREVojBGB71x07geLCkz3NPUB311Jho7jljv31lYg3l61ezbzSqw7GphLcpVmvUtCBY5deg==
X-Received: by 2002:a05:6a00:2291:b0:539:d5b8:4ecc with SMTP id f17-20020a056a00229100b00539d5b84eccmr15866104pfe.79.1662089196077;
        Thu, 01 Sep 2022 20:26:36 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k5-20020a63d845000000b0042a713dd68csm306538pgj.53.2022.09.01.20.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 20:26:35 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lu.fengchang@zte.com.cn
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, lu.fengchang@zte.com.cn, makvihas@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Zeal-Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] Driver: r8188eu: Remove the unneeded result variable Return 0 instead of storing it in another redundant variable.
Date:   Fri,  2 Sep 2022 03:26:28 +0000
Message-Id: <20220902032628.316333-1-lu.fengchang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lufengchang <lu.fengchang@zte.com.cn>

Reported-by: Zeal-Robot <zealci@zte.com.cn>
Signed-off-by: lufengchang <lu.fengchang@zte.com.cn>
---
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index 8e4a5acc0b18..6d1f56d1f9d7 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -149,7 +149,6 @@ static void fill_txdesc_phy(struct pkt_attrib *pattrib, __le32 *pdw)
 
 static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bagg_pkt)
 {
-	int	pull = 0;
 	uint	qsel;
 	u8 data_rate, pwr_status, offset;
 	struct adapter		*adapt = pxmitframe->padapter;
@@ -295,7 +294,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 	ODM_SetTxAntByTxInfo_88E(&haldata->odmpriv, pmem, pattrib->mac_id);
 
 	rtl8188eu_cal_txdesc_chksum(ptxdesc);
-	return pull;
+	return 0;
 }
 
 /* for non-agg data frame or  management frame */
-- 
2.25.1

