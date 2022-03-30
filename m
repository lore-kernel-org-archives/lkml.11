Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87470C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 18:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiC3ScB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350534AbiC3Sbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:31:35 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4361E5BE42
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:28:25 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e68c93bb30so177293977b3.18
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=69G4sVrTM6Oebk85axmgqm6tVz3OwOvgPCpKMqCiPco=;
        b=KAkhCBn3gEwaVnHCrhjznheQGY1GcCBdnWrxtjIFYBR2rk4OJFJ31gVI8tVCx6sj8u
         qH85S3m5RZXFjlMJBVo/mTONjglm5wXv+jTcfufhRlcZqejW8H7XgGLqfVP7AjC7n0eM
         7HP9ssmEL+278QYUiKC/5WDRmyP8ixj8xgNdY32mOx/HXCVXCuVV9Pph2dXMjjR241g7
         88UR6Tcb5NmhsduVZ3TtT9jvmrKJ8ZDTdhVTVRCgo9WleoyQZenniBdvfpVvf5VKcQQo
         r3TTQuLFB3NO9NQ0VcFYFrU0Mu4m9p5k/wtYCBS20lw+TSK2QCq174JUxbx4rg6qxAxC
         gR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=69G4sVrTM6Oebk85axmgqm6tVz3OwOvgPCpKMqCiPco=;
        b=ONZA3/87QodjSB6ut5pHbxg9I7X931v+jI3h0Obl78u+zW62yj+8DwGQbkuNv8dwA5
         n2z8RZl1Ws2Piy4RFadP05GrPVSbjEWxH5HP2ZGpXwD1mJEJrcAvJR/7LsyPiIouAevL
         S83WrYWUmWVWuL1y8NeRwv34m9losqp0XRNFCz/z8P/GW2FC+815MDhdmJDBOE7sbghW
         10RkSM9iUxJZjyfj/tWBmvM5vU9TUS4uttaOMd1iYK9A1/CytLU8ESjtw8sgn8Lwn/ob
         1b4qAvmww/BgF9f4eLsDK3yCgCbDlci2Tqu4mdLkIKCyxtTwarwH/7puThA471mzIu5U
         a4uQ==
X-Gm-Message-State: AOAM531VL0N04RlgDpUrAoaexAOFMwhZGGCdxmyjHI5N6iqCroZrpVkT
        5Y+J4e7V5KCTjgFKPz7i3nHrygzODwhV
X-Google-Smtp-Source: ABdhPJypHixg49BP/nRHIZXftzFoLrN29bvmk/CgxMF7bcwNtHjoOkCy1TnNXK6tDuqfVn+gOXleajOvms2h
X-Received: from pigloo.svl.corp.google.com ([2620:15c:2c5:13:1db:3f32:3ad1:f38])
 (user=jmeurin job=sendgmr) by 2002:a81:af4c:0:b0:2e5:b051:6353 with SMTP id
 x12-20020a81af4c000000b002e5b0516353mr1068237ywj.518.1648664904545; Wed, 30
 Mar 2022 11:28:24 -0700 (PDT)
Date:   Wed, 30 Mar 2022 11:28:13 -0700
In-Reply-To: <20220207163409.19c3bc4c@xps13>
Message-Id: <20220330182816.1177341-1-jmeurin@google.com>
Mime-Version: 1.0
References: <20220207163409.19c3bc4c@xps13>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH] Fix the size of the header read buffer.
From:   Jean-Marc Eurin <jmeurin@google.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jean-Marc Eurin <jmeurin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The read buffer size depends on the MTDOOPS_HEADER_SIZE.

Tested: Changed the header size, it doesn't panic, header is still
read/written correctly.

Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>
---
 drivers/mtd/mtdoops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 227df24387df..09a26747f490 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -223,7 +223,7 @@ static void find_next_position(struct mtdoops_context *cxt)
 {
 	struct mtd_info *mtd = cxt->mtd;
 	int ret, page, maxpos = 0;
-	u32 count[2], maxcount = 0xffffffff;
+	u32 count[MTDOOPS_HEADER_SIZE/sizeof(u32)], maxcount = 0xffffffff;
 	size_t retlen;
 
 	for (page = 0; page < cxt->oops_pages; page++) {
-- 
2.35.0.rc2.247.g8bbb082509-goog

