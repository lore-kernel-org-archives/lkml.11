Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C36C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 14:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346886AbiC3OeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 10:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344905AbiC3OeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:34:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B554141323
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:32:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id o10so41960831ejd.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4HEXf5bJegxbPFYILind4ceZ9VvazmZ4A+tRQUfmjs0=;
        b=Mcfj8/2h/OuFSeZPYtDlWUjxtRAdiSb7q46RXDwoaoGqE99HOtLDIkpevbBUlq0osC
         VdbLZD8SGc48JKQEach/2Nh5BzOCMc6f37kiO5qCbR+upbmVa8z2lmRhNscpRIg7zwqS
         B2YYoO6nuFQteB25RFQ/yiXrQdyHWGKj8AqYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4HEXf5bJegxbPFYILind4ceZ9VvazmZ4A+tRQUfmjs0=;
        b=Aq9CYeEe7U2P/j+n5rRMbY3rf51Ice+J5SlFr67MpZlrBGDAH5nkml7jxz+/sem7ii
         wMXJuNsJ2yR6JnMp7oTKBBCLbwhgfhOvWXcsmm6YVPIs/IGBudHA+A1UZzwYm1bhwOs0
         hp6Fig5vkS+q+SRY/5U2ty/z/j317/kRzJOnGYy3MIsAe38OHlodIkx44mBKY78Ge10z
         1M3nWADp3hyrhLao1qqxynoljQmMF1j4034HOt80P/ARCZ1a4rcnUl6GpOGkJfifSQBP
         lP3HBVm4eyg8pol5DuCsGekMYiC/GPMfcdeCE/P4S56hUZasagPvwoY3EsFiiXiM/nRj
         j1vA==
X-Gm-Message-State: AOAM5337wXgjZPeibl+KEr0VDRmnAlRBrC1YHsvZzT5AsQy55dFrdBeh
        smLob+DhqHqQla4NjHuIHUz4CelYgETg/w==
X-Google-Smtp-Source: ABdhPJwoCIq2KonUFpyv2LZLErdDddLT4k68M920fyErp8SSpTugsud1DhXzIhwN+uwAmmCNKRsirA==
X-Received: by 2002:a17:907:2ce6:b0:6df:a489:d2e1 with SMTP id hz6-20020a1709072ce600b006dfa489d2e1mr40916757ejc.264.1648650741963;
        Wed, 30 Mar 2022 07:32:21 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:c1bb])
        by smtp.gmail.com with ESMTPSA id g2-20020aa7dc42000000b00418ef55eabcsm9913692edu.83.2022.03.30.07.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 07:32:21 -0700 (PDT)
Date:   Wed, 30 Mar 2022 15:32:20 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>, kernel-team@fb.com
Subject: [PATCH] MAINTAINERS: Add printk indexing maintainers on mention of
 printk_index
Message-ID: <YkRp9IhToTmTnkl7@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.2 (aa28abe8) (2022-03-25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will primarily catch new and changed printk_index_subsys_emit
calls, but it's also worth catching changes to other printk indexing
infrastructure outside of kernel/printk/index.c.

This avoids churn due to missing ccs when adding new printk indexes, as
was the case recently for the first round of the XFS printk indexing
patches.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Petr Mladek <pmladek@suse.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3b11033e628..45121b9e943d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15404,6 +15404,7 @@ PRINTK INDEXING
 R:	Chris Down <chris@chrisdown.name>
 S:	Maintained
 F:	kernel/printk/index.c
+K:	printk_index
 
 PROC FILESYSTEM
 L:	linux-kernel@vger.kernel.org
-- 
2.35.1

