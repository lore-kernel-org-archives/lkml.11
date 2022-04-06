Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B3EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 16:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbiDFQQh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbiDFQQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:16:19 -0400
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C85D7904
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 20:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649216977;
        bh=5jdw8RKiZGnQQuDSxJ+xf7FKkPdpchd+2LUxqYBwJ+k=;
        h=From:To:Cc:Subject:Date;
        b=i4k9tghv69uNF7YNIBOp8+C/4kQbtBZvmQZjqA9a0jWyawbDIZlURWuD0KXO7KATf
         peeOC4TPPzgUon6dH6Q8ubhqVP2b6jWRqpXtEyht+MvR5o1lA24n1Z4LUfcnOCcfva
         EatKsPgN2DLaDCdtSg69RKZjXMyE/e9Kwi3U7JBw=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrszc11.qq.com (NewEsmtp) with SMTP
        id C62BE879; Wed, 06 Apr 2022 11:49:34 +0800
X-QQ-mid: xmsmtpt1649216974td65ko7ki
Message-ID: <tencent_5A192E178D4393A235FC57A9E9BF12E49305@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBnIOY+fAUH+8MAtlSqWU1AoaNZRDnEzg80bxBn+3QSlas6n6CKH5
         qAnzYE5xPX2rLbKpqSJ40XXPOlZ+gXyt5VQI6oUHRvXNJYqdaB10l+X6/4TjqwUuC/lyPIlYRJN7
         vNdTDMqADsJ8gOW3A/7o9YhwtUZp7ihijiTdVpjskx6uzrSv0EThPzkp9TCTKp9rdRVLmXuNUejt
         Gtlteq8Vry+U82ENL/RnlXZ0Pp1aLsEID05achHNIJ6Bc1VWiha3/fx1E2jt8Iu2mOswLX10bWpd
         PGDyzGMEjsLEGx69LX0MdVKIvIOAiqhUV7gS6WSDk4L5gOtxSjndd49wxOmadDflzwdA0yEgeBfs
         wIpeuxHIFRrVBWXvu7WiFW4Azbq8GQ9RDLs3iKSAnj5mdeUvPW/QZXBW+2vuhWlreEr0Y3WVIZjJ
         I9biaTU9DODO4V2VQ3CPN79Wa2ksQYJy1AOyuGth7tDFxqz3wG/xmz5oZpElzBQlHWvFPzc5g5Z+
         DX9ArgfAyaU8ZYoLp5OKbXlPg8/TlbWrrQcymLF0VHw5VewUiKOjYAtkWaN6tAZrO3Z2ND/eXAs3
         v1PtLMKI14pkEnbzI3fmXQFr8lKgaSwVN5EimFY21zNCRx+Bp74aUnIYko3gzz+51iGErJFa/1W9
         8xWxph+QKJS3fd9r6UV8J54o10XXxCfSs11JyRCV0ix7QYoclQGmHyqFgp5LiPqd9MfnDON/kD/r
         fEcTHTmDCupZia/UrWM2sagCsWaw3eYVgiwheU1zdvkO2J8905lzV3UM4W+3qPte1bsE0ZfTIOXs
         Eohwf3BUOIOp0/z6AssL6ww+dTF4zBY/xQtr1Mm2DXUsfFISQo39WJUHyi2UiMuePLYKnFw2Obz0
         TIwwSNq0p4gE7nB6x6PcmbcUyfb9ae8jNgxkkkwSQsQJo7Qbc3OiE/sV6wch6bjyGecgq5rdyhdg
         FHyvjygMkNooW9/EKlaSXy5DTkPmHHsHh6P0VyfHxAm1vg2QWuzg==
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2] staging: rtl8723bs: fix a potential memory leak in rtw_init_cmd_priv()
Date:   Wed,  6 Apr 2022 11:49:23 +0800
X-OQ-MSGID: <20220406034923.12717-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

In rtw_init_cmd_priv(), if `pcmdpriv->rsp_allocated_buf` is allocated  
in failure, then `pcmdpriv->cmd_allocated_buf` will be not properly 
released. Besides, considering there are only two error paths and the 
first one can directly return, so we do not need implicitly jump to the 
`exit` tag to execute the error handler.

So this patch added `kfree(pcmdpriv->cmd_allocated_buf);` on the error 
path to release the resource and simplified the return logic of 
rtw_init_cmd_priv().

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 update the description.
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index e574893..9126ea9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -161,8 +161,6 @@ static struct cmd_hdl wlancmds[] = {
 
 int rtw_init_cmd_priv(struct	cmd_priv *pcmdpriv)
 {
-	int res = 0;
-
 	init_completion(&pcmdpriv->cmd_queue_comp);
 	init_completion(&pcmdpriv->terminate_cmdthread_comp);
 
@@ -175,18 +173,17 @@ int rtw_init_cmd_priv(struct	cmd_priv *pcmdpriv)
 
 	pcmdpriv->cmd_allocated_buf = rtw_zmalloc(MAX_CMDSZ + CMDBUFF_ALIGN_SZ);
 
-	if (!pcmdpriv->cmd_allocated_buf) {
-		res = -ENOMEM;
-		goto exit;
-	}
+	if (!pcmdpriv->cmd_allocated_buf)
+		return -ENOMEM;
 
 	pcmdpriv->cmd_buf = pcmdpriv->cmd_allocated_buf  +  CMDBUFF_ALIGN_SZ - ((SIZE_PTR)(pcmdpriv->cmd_allocated_buf) & (CMDBUFF_ALIGN_SZ-1));
 
 	pcmdpriv->rsp_allocated_buf = rtw_zmalloc(MAX_RSPSZ + 4);
 
 	if (!pcmdpriv->rsp_allocated_buf) {
-		res = -ENOMEM;
-		goto exit;
+		kfree(pcmdpriv->cmd_allocated_buf);
+		pcmdpriv->cmd_allocated_buf = NULL;
+		return -ENOMEM;
 	}
 
 	pcmdpriv->rsp_buf = pcmdpriv->rsp_allocated_buf  +  4 - ((SIZE_PTR)(pcmdpriv->rsp_allocated_buf) & 3);
@@ -196,8 +193,8 @@ int rtw_init_cmd_priv(struct	cmd_priv *pcmdpriv)
 	pcmdpriv->rsp_cnt = 0;
 
 	mutex_init(&pcmdpriv->sctx_mutex);
-exit:
-	return res;
+
+	return 0;
 }
 
 static void c2h_wk_callback(struct work_struct *work);
-- 
