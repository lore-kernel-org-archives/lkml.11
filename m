Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03781C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 15 May 2022 07:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbiEOHzO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 May 2022 03:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiEOHzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 03:55:08 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDE115FD4
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 00:55:07 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r71so11026956pgr.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 00:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6/Muibz0QFDzW+Rnak5M+O7HaeitVg6wSfG2z/JITQ=;
        b=ekXoseY3muuTad5BnEw+7E8cG6I/UXhHin7o/g/uhtPPvQZ8I0M8hSn9jIORsVyxLu
         zpCB1FFb0MIm8DCnlv0o13N3DDMdFX9PIQToXZJKqGHPKhWwBgubeIdItDkaCMwFNc3X
         Uato8H+dY6N5EI68/zsPU5lo7KkCgiMHeSPYKhljO1Zy/FEI0bb18eBr/034lmNnPABX
         uFl+Ij4QzptqRrEJVxZoj0JN5z1r40TXm3yI3aspsUegaTALk6z5oyryhQa14c3+PAro
         GDLmxZxGR6J/ZRLBPIxKM+LQO1a90gyfIq6ghDUaeRYMvq8DUs1NyaPcYQMufJ956IvH
         v+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6/Muibz0QFDzW+Rnak5M+O7HaeitVg6wSfG2z/JITQ=;
        b=YgWekjqcbpBwVmewYMv2YlTV4eBgZ9Fxntn9cBQA8V3gY48n5qL1Hqdom81wY0pEwV
         bkJE4QTqWZSJMd+ptMHuzMnhJgA3c5ycJk22upctakp4SAeBcUx4veK9/BMaCHtte/GR
         dQG4sQTPo0v3EXOYJxtT46hfkQQIk6s/iivmXAoDtq/70bjnJge03h3j3GNbJUufz92q
         w9BA4abi0E++KSliuTn6WOf+Gv20LrTT4fYNzMDvf6y+rENLs01R5toa18j15kNXVnJc
         nm8HAI+fedwOMmNCemu6kGbcS2OuZcG9L94EyYYy1F/6N0IKQIULdhKWLAWDl1r33OmH
         C7Jw==
X-Gm-Message-State: AOAM5336GbWXSSzOk90YkyiAdjUQs2WqxyQD1SrHg3fKBj3ov7fZAVsT
        sf7P0FP6ilhroUTaJJtcB4w=
X-Google-Smtp-Source: ABdhPJz9kwFj3PtEXVSSX2UgQSYLvTLDZSDadS8CJx27tMB+Yo8cRp6dAGaVYRAVOFm5MteOgb9zkQ==
X-Received: by 2002:a63:181f:0:b0:3c6:b0d:2214 with SMTP id y31-20020a63181f000000b003c60b0d2214mr10636380pgl.60.1652601306750;
        Sun, 15 May 2022 00:55:06 -0700 (PDT)
Received: from f34-buildvm.eng.vmware.com ([66.170.99.2])
        by smtp.googlemail.com with ESMTPSA id k4-20020a628404000000b0050dc76281dcsm4624267pfd.182.2022.05.15.00.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 00:55:06 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, yesshedi@gmail.com,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: [PATCH 2/3] char: lp: remove redundant initialization of err
Date:   Sun, 15 May 2022 13:24:54 +0530
Message-Id: <20220515075455.306082-2-sshedi@vmware.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515075455.306082-1-sshedi@vmware.com>
References: <20220515075455.306082-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

err is getting assigned with an appropriate value before returning,
hence this initialization is unnecessary.

Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
---
 drivers/char/lp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index e61060f3c..5e8bd8d6c 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -1018,7 +1018,7 @@ static struct parport_driver lp_driver = {
 
 static int __init lp_init(void)
 {
-	int i, err = 0;
+	int i, err;
 
 	if (parport_nr[0] == LP_PARPORT_OFF)
 		return 0;
-- 
2.36.1

