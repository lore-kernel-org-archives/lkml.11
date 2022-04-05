Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A35C4167E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 00:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445482AbiDEXpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 19:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390763AbiDENnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:43:16 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A09A252A8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:43:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g15-20020a17090adb0f00b001caa9a230c7so2376278pjv.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=32znQNcCvJk/J0LQPqfBrFopN6gveol4Y5sCPC/EtaM=;
        b=MZMONg6evm1b06ebf10VUy5qFruE2ufypLDORfiNPGI9Nm0V2d8NKPNfbuYFXbxynU
         Ew5pEiXL+/KwKou273b4JRujttgweTrjxe1fAy9x5lxWCMC0drqctxQwhyb95FPOLZgA
         M2GCBt9hNOFC4/fXKhg8UBwwjYM3MxkKj0saUBeRaN6TZeFpC4g51PHtvYi8xJQ6OGra
         eoa1gHvqGo83aGXxWV+nlgrBMVEmlWLj0Rbn48iMd00FALXO0M21yLmHguVJCwSsKS42
         ySxbWr3ZrLtYfyGkDI3Ry/aerkx5NxGRDDuG+fXVHARuTb+F1Bn5hI0ft1DrvENkaJ/z
         XDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=32znQNcCvJk/J0LQPqfBrFopN6gveol4Y5sCPC/EtaM=;
        b=Xj1eBXm/ipYgw+C+tOeRDpH8gaaVcL5NxRCeU/38b5dSKLhMM9+Ww9IQooJmN0utzF
         9+OAWdzxI9ajVP0ZjQnXpZku5Neg6H8Sodx37jnIsDWAJ9z5sBeD6C/GnzLE2UIDAQVG
         ZOyPkK3N5ryOHFBH8oKbc8gmExF7sLqFD+4n9SigUWGwb8FDDqwNHYRCSM0eoMheEnh+
         VN4yZrMpYt2+WBGrBoPy2sPwJx9yPKdi168co5c4Js0SEugcPujGwGL3P91q1cifITFk
         dYMsHh8WNGO3UXFBN+xD7noZqDDRRw6QurNd78Q3rzwm0RFz4NFDEqDbXdZp1GlTF2ue
         jbRA==
X-Gm-Message-State: AOAM532SGO4CUBurhjLi5++M7+jHdu/YHxHx2pQ58yMivSADCtXTpiMc
        qLAyzVvIF0qsNvnV5zlrcGu7wFvYKgr9aw==
X-Google-Smtp-Source: ABdhPJzr7+HkHfXYcUBAah+Burhp6afkKXykookxCMdIonn8reMbllmPBZT9DGXRbz4AgS+4r6fW0A==
X-Received: by 2002:a17:90b:1994:b0:1ca:9b45:405e with SMTP id mv20-20020a17090b199400b001ca9b45405emr3861657pjb.22.1649162625300;
        Tue, 05 Apr 2022 05:43:45 -0700 (PDT)
Received: from vihas.localhost.com ([103.85.9.59])
        by smtp.gmail.com with ESMTPSA id nl17-20020a17090b385100b001c70883f6ccsm2760014pjb.36.2022.04.05.05.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 05:43:45 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: simplify rtw_inc_and_chk_continual_urb_error
Date:   Tue,  5 Apr 2022 18:12:40 +0530
Message-Id: <20220405124239.3372-4-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405124239.3372-1-makvihas@gmail.com>
References: <20220405124239.3372-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The if check and variable "value" is redundant. Drop it and simplify
the funciton.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/include/usb_ops.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
index ddc46cb44..c5982704c 100644
--- a/drivers/staging/r8188eu/include/usb_ops.h
+++ b/drivers/staging/r8188eu/include/usb_ops.h
@@ -27,12 +27,7 @@
  */
 static inline bool rtw_inc_and_chk_continual_urb_error(struct dvobj_priv *dvobj)
 {
-	int value = atomic_inc_return(&dvobj->continual_urb_error);
-
-	if (value > MAX_CONTINUAL_URB_ERR)
-		return true;
-
-	return false;
+	return atomic_inc_return(&dvobj->continual_urb_error) > MAX_CONTINUAL_URB_ERR;
 }
 
 /*
-- 
2.30.2

