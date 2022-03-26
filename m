Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2568BC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Mar 2022 18:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiCZSLi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Mar 2022 14:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiCZSLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 14:11:36 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C4862D9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 11:09:59 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d5so18356230lfj.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 11:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9m5Rd6cbLT+02hkj1gkPPi+4zyoAG3SHfMbdx9sHaQQ=;
        b=lpZ2SUYFArgTTFpWmMDS0iV0G4tege7cbfpCXfu15B1Gnaq5SS0Ay2VePEdR3uuMYv
         l3rVH0/ihLQ7tVB6GopPEGOjIwy9NLmzsrJbbRs55MLd5bNSoup3bJfVOAxw1wT/Grja
         V3ZwQRdqj1siq1/Lb5yoE1EuEpUvGnSPSNgtUub9ZRaLWoT0wJDp14ypa/vk9lnozu+j
         1gvdo5lLYz+m2Wqq7yZRhHOmjyz3TaNCEosDoJrk2mPJkP4ntOSBw+6KnC/n3FQax1nI
         j8ss++ttpnhGeV8GOkkKhm0XrGO09BusemrSQjN7lCDuc3NU1BT1zi9kh41V4KWQvtNq
         d2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9m5Rd6cbLT+02hkj1gkPPi+4zyoAG3SHfMbdx9sHaQQ=;
        b=4iso2R5Uh3e5o3zJIEVLbItJrGFASV5IVl/86jE83NG3Yl/E2a+xOBxeBNQOZJO+Dq
         FWD6Xc1LyHlBKwBx92UtsBlxEUyqewfnlK21hfwZdupDy4xTpqma9UnTyp+3/FTAsqIf
         uZB2K+JdQKbkrL34LVUrQVWMQltN9w4V/egU07tNESX9vh86YIy2EKroMf0iujYNPh7z
         Y7N4Lx2dzJ9lbGJKYOm+lgHU5yEKKId+C6vL1Q4GdAs8cBE5JzhCn8y6h7c3Sx1yc65S
         ibtX0TkZuw6uXGiFzNY7gR64F+KyWJePKKTvPsevQjoBpN4sNBN1/AD6VHogCHVlKEs0
         09KA==
X-Gm-Message-State: AOAM531PeSAoWpDwmMkIlGKknTJMi+BD4mUJexDFrLZ7qb90aJFmb9dz
        JtsnFmbcf8tj46bysFlafG0=
X-Google-Smtp-Source: ABdhPJyG52BPqTv2glo4DLEnkeDLYwl5+yRDzvxOMFCaYjOorInwsOcpA8kDs+X4oogvWLNMmL6kVg==
X-Received: by 2002:a05:6512:1382:b0:445:9536:903 with SMTP id p2-20020a056512138200b0044595360903mr12926829lfa.89.1648318197835;
        Sat, 26 Mar 2022 11:09:57 -0700 (PDT)
Received: from morzel-asus.lan (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id h2-20020a05651c124200b002492835aa87sm1107591ljh.118.2022.03.26.11.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 11:09:57 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal Orzel <michalorzel.eng@gmail.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] kexec: Remove redundant assignments
Date:   Sat, 26 Mar 2022 19:09:47 +0100
Message-Id: <20220326180948.192154-1-michalorzel.eng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of redundant assignments which end up in values not being
read either because they are overwritten or the function ends.

Reported by clang-tidy [deadcode.DeadStores]

Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
---
 kernel/kexec_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 68480f731192..d08904a27362 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -768,7 +768,6 @@ static struct page *kimage_alloc_page(struct kimage *image,
 				kimage_free_pages(old_page);
 				continue;
 			}
-			addr = old_addr;
 			page = old_page;
 			break;
 		}
@@ -788,7 +787,6 @@ static int kimage_load_normal_segment(struct kimage *image,
 	unsigned char __user *buf = NULL;
 	unsigned char *kbuf = NULL;
 
-	result = 0;
 	if (image->file_mode)
 		kbuf = segment->kbuf;
 	else
-- 
2.25.1

