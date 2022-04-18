Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0F5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 18:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347330AbiDRSMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 14:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiDRSMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:12:50 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF29DDEFD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:10:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso14762494pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uMrcwYlsopVDqMWUTs3qkmmFIb/yivyw+8YXRb2YVA0=;
        b=bXiQ6T1FgzxyPdZKJtm0Tm1b6DC5PC0FjlGDaX043FwoLMk1zsc04G6GITsPVVyNH0
         9wdjzK3P6xbnqSYDNnVTzdvu5YKrFdL7L9/1ei1zvawLgVctKiA6Ojwp5Gwsky9nZY1B
         GWXa28WnNn1RUNB4BofS3LtBSdtONh5Mz0qKIXwG4Aexb9Do+XXptyXX4JGG9rxuokdx
         V/VwF1O9Jl0AQqLCoR2FlMOQLDr/bAcx/Qf75m2GLV1zbTUpdjtaYiN9CyBOAvyspnGo
         mIb1HZ/oh1D4DVwl64zVwmEnSnl88paSlDTe9weE7KxR6MZSMU9Q6ENo0uJqTztO2RGk
         j5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uMrcwYlsopVDqMWUTs3qkmmFIb/yivyw+8YXRb2YVA0=;
        b=1MOXPUR9WSKm5NxhRB1J/yJwsRRqWtXa83DPmHDInxSE2BJGmXg/7u1/PVe277Q23R
         UCg2Gi50iThys/Y+jV0ksocrZkIiIj4xe5/0LDxe+hBV3r44cUOBK7ZfCLfY0Ya0RiMo
         Yoky8rk818q/mEBBgafitxxIFTMI2gWN5qrW2Ynyo2pI8pX7s3iP4wDKrJ1tjkp/IpYJ
         Vy/VTIaahus3svQbad2wRiGVFAiq6UV9hBp86hXOKrVrOOJcTYWZFdSfRNPB9ZhtdZev
         9sYyPQmSNt0TrvxLbLrr2c3SaWXPzI9hn9QrT6Z5fzrtPjARE3fTtmHjG9jSrakkf+od
         4DJg==
X-Gm-Message-State: AOAM530wr3SGBI0Tkjch8rexMJJtgI0ZZcM63a+1OoRoKmoATLlt7B2y
        a8a5mpL/5CThyr4MD9+8pto=
X-Google-Smtp-Source: ABdhPJwcnn/UGh09oo4BTd8LWL5E9cjB11+kD7eHuSt0qMNAnLH37OC9uK12Fxk3xukJIjTAu12ixw==
X-Received: by 2002:a17:902:7c17:b0:158:f6ef:497e with SMTP id x23-20020a1709027c1700b00158f6ef497emr8092615pll.134.1650305410270;
        Mon, 18 Apr 2022 11:10:10 -0700 (PDT)
Received: from aliyar-HP-Laptop-15-da1xxx.domain.name ([14.139.241.88])
        by smtp.gmail.com with ESMTPSA id b10-20020a056a00114a00b004f784ba5e6asm14416578pfm.17.2022.04.18.11.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 11:10:09 -0700 (PDT)
From:   Aliya Rahmani <aliyarahmani786@gmail.com>
To:     mchehab@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Aliya Rahmani <aliyarahmani786@gmail.com>
Subject: [PATCH] staging: media: av7110: comparison to NULL could be written "fe_func"
Date:   Mon, 18 Apr 2022 23:39:00 +0530
Message-Id: <20220418180859.18488-1-aliyarahmani786@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed coding style for null comparisons to be more
consistent with the rest of the kernel coding style.

Signed-off-by: Aliya Rahmani <aliyarahmani786@gmail.com>
---
 drivers/staging/media/av7110/av7110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/av7110/av7110.c b/drivers/staging/media/av7110/av7110.c
index d74ee0ecfb36..bdc6adf70d72 100644
--- a/drivers/staging/media/av7110/av7110.c
+++ b/drivers/staging/media/av7110/av7110.c
@@ -107,7 +107,7 @@ static int av7110_num;
 
 #define FE_FUNC_OVERRIDE(fe_func, av7110_copy, av7110_func) \
 {\
-	if (fe_func != NULL) { \
+	if (fe_func) { \
 		av7110_copy = fe_func; \
 		fe_func = av7110_func; \
 	} \
-- 
2.25.1

