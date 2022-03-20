Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8375C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Mar 2022 03:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242209AbiCTDfY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Mar 2022 23:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiCTDfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 23:35:19 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B9439BBF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 20:33:56 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id h196so9563482qke.12
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 20:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AE/BXY7F2KOdTssv98/tsVCVvRVwtSj3MkZKgJjE5vc=;
        b=foBrR5EryWGwNwgjnDx/Obcd/RLWgFzR+sE3TcdOQabxWQUQHQ4mX6taWXpEImn3Yx
         O4MqKBfWvNPpbGOGrTGyebQIqYaVHCRaokkvu6snpTt3IZj2OIV2LQGtMNGSr3bOJKsM
         nOfMgBI/s9VpGnG4RB77QVaE2lal22Ta9sAyrRiJzASFHbZSMVRwwamxL9jpAYuXu2kt
         KIrUX52xO+fEQEtxvXvXVCGEgQ4vBKNN/+F6Q+d/X2BJSenXibdZ6jawCOsKFal5D9Bp
         ozKDDRayHzjbVbzDCk/Tz2JHimrC8ejeNk0MKjlj98vcmqkIZGtsFIXVuAK8JRkVKhG5
         itXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AE/BXY7F2KOdTssv98/tsVCVvRVwtSj3MkZKgJjE5vc=;
        b=S04EKskOoWyC9k1C74HQ2e4tdkN2OMTHCRkt6bP/Z89zx2Qcc5GS8NApa+D+rzcs1W
         e7rqDoK5aYIawRp5LdR+HExfLeUmaONlqvxXuNZStYXhBsxgFm05TXfMR2l0Nfv4g/tB
         7xXWaRpghYf9f8PXXuZhhHLcrRtTSwecSh2Qpf+HK2ohQTym6/UCdUGLyVMhCi1KquDr
         LYimxxaVftV/47Mt7xHTNF4FGtyTT+m0tD0G6ZL6R4j+MsG/uS2HNm2rVaY5gfOfro8U
         vlU98Z2XhkVnqMhr+XXOZkbLXLv5ZGHLjXX+F2KBIgLzOZEwgk3e3gXajUYsHs1LnrI7
         4m3Q==
X-Gm-Message-State: AOAM530f4ulBPfqgPEyb8r9n7aZYpi76mbn3hqtFunyjhtShGChz2SL6
        gQ9YPvPfiw/1PddENpdLpMc=
X-Google-Smtp-Source: ABdhPJz2dyv1mrOQ4RZ3BPPCQ1QJj7P7SK5PWCQUaFblmIjV9r7zPOHHQtCLeh297KhYgXpAXnWNyg==
X-Received: by 2002:a05:620a:2985:b0:67d:b9ac:90b2 with SMTP id r5-20020a05620a298500b0067db9ac90b2mr9923453qkp.436.1647747235069;
        Sat, 19 Mar 2022 20:33:55 -0700 (PDT)
Received: from localhost.localdomain ([159.223.186.39])
        by smtp.gmail.com with ESMTPSA id j4-20020a37c244000000b0067d79a3fd0esm6250340qkm.106.2022.03.19.20.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 20:33:54 -0700 (PDT)
From:   "Ryan C. England" <rcengland@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     arve@android.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        "Ryan C. England" <rcengland@gmail.com>
Subject: [PATCH] staging: android: ashmem: Fixed a struct coding style issue
Date:   Sun, 20 Mar 2022 03:33:37 +0000
Message-Id: <20220320033337.47118-1-rcengland@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Ryan C. England <rcengland@gmail.com>
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index ddbde3f8430e..f2bf7995b403 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -377,7 +377,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
 
 static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	static struct file_operations vmfile_fops;
+	const struct file_operations vmfile_fops;
 	struct ashmem_area *asma = file->private_data;
 	int ret = 0;
 
-- 
2.27.0

