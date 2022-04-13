Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AD1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 20:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237635AbiDMUOJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbiDMUOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:14:06 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638857CB24
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:11:44 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id hf18so1719652qtb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B8hL0jBT5xZ4aSX/GQ3ksV9bgLPofPyPWC/LZsNauFo=;
        b=Fvco4OsoRe9//Bop+KfXjpKPJGHg+bRdqjIjlvrvP3icpf1wlted+OlJEW64lm15es
         7FLfGw6tH6FRHiffjDad3H2s8uLQpfwJuR/tP3uCofwmODJj6wbaQSsB+QgWHuDksjYD
         wtFHOvIyMQ4db1QT0cjQTfUn5fIR0/G+BwRWxhz7Ztz0naDzTbwjxq/14hPz5gnPrLqw
         kVBg+PMXkvFMDKZ1xrsMR3GWPoV2mh7rR/aGoXBL/MKSFZWbauVD5By0MuATi0F1Xzo/
         nT8uglCRy9V9tulKuBcuoZFioLXGvRwD5dmwBod45tgX0tZ9uV2h74mCse8CkuXq1qsZ
         r1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B8hL0jBT5xZ4aSX/GQ3ksV9bgLPofPyPWC/LZsNauFo=;
        b=uknhyUBCraPmHQWZ3pXPdFUQNVxcTGCX1MmBiCV8Q+bsQCmFHQ1C0wp9CHjD6HdQxz
         UEsLnLTfYH27qzyZ2ywpbTR4knKn187NeIsZysC3cPI8IWqstJ1vQ5TvJVrahubp/Pyq
         LKZo0MxShYZ/fylFIKC45WwGN+/0UlDFoPs0w6DgzNvRAmYEjz5k2AsEldb6awrnUWTK
         +G2HEdA4hZcjwdTnGk5/Vq68teCEvONNmUItPZPi+IXniymL2GmiIEGPEqSKJswThDwD
         /Bafv3wnS8v9cFCnEXzh0Hnt/wwZZIVTpmsir5AYPE/M7th5TlCCcHKYw3VIfULVatis
         rghA==
X-Gm-Message-State: AOAM531Uhcva6QeK/2+MrtQzp13v0BsOIZSOxB3mWGZD94IPUeAcFf4w
        bM7AJm580ieDyLR738skHRM=
X-Google-Smtp-Source: ABdhPJztoHGzRxQSLTi5Pjyws08NIOE9mJO0O3azoPPDeWOKUAl4LGSLQOpS892tebrsrhzUL0aQlQ==
X-Received: by 2002:ac8:604b:0:b0:2f1:d064:35c with SMTP id k11-20020ac8604b000000b002f1d064035cmr3610036qtm.162.1649880703506;
        Wed, 13 Apr 2022 13:11:43 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id 7-20020a370907000000b0069c5598584esm1469827qkj.105.2022.04.13.13.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:11:42 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH 1/6] staging: r8188eu: remove unnecessary braces in single statement block
Date:   Wed, 13 Apr 2022 16:11:29 -0400
Message-Id: <4a0f2a0f24321c5b2039f0f8e6132cec4a2ef068.1649880454.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649880454.git.jhpark1013@gmail.com>
References: <cover.1649880454.git.jhpark1013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove braces for single statement block to minimize the number of
empty lines, without loss of readability. Issue found with checkpatch.
WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 3e9882f89f76..d3f4d7cdfa08 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -112,9 +112,8 @@ void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 
 	rtw_free_mlme_priv_ie_data(pmlmepriv);
 
-	if (pmlmepriv) {
+	if (pmlmepriv)
 		vfree(pmlmepriv->free_bss_buf);
-	}
 
 }
 
-- 
2.25.1

