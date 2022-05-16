Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2B5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 03:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239561AbiEPDJL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 May 2022 23:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiEPDJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 23:09:06 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F01811A35
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 20:09:04 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id w17-20020a17090a529100b001db302efed6so13051858pjh.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 20:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LeS293Xoyn/IdDJSLF6A/QhWhktSea8yiSvRbWcIXpo=;
        b=RYy4hmQC7F0YhLYyxhwtQGpFqj6NiybxZ5pHdp3xv5VfOxxeeDSRxpzf4sI5ZYk9/m
         jZ25mHuBePqFjQmP4iv2+uWQ1PJ+jnFVZp5xU2cZ1v6xPeSzDpNnwNPGmmAfC1Oy3k5v
         f5Inm+r8lRECqbOXN43fV9ytzbhLmBlRD5bqZtRcvNTm8EJthYXmQzay9KqiVxkJ1OFd
         vp/NW5SN2aY9OFQ5Y1KcT0Tk5f1It+ucfcfKjZg+Uo2Dkz0s4mS/36ysqFw8b6fNFlRh
         ZJlUAbGYyH6I2Y2/EeLZbH+TI9AMR45YxZAg1ziZ6wq2tV52zqAHnLqhZkuXqc1IWdON
         4pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LeS293Xoyn/IdDJSLF6A/QhWhktSea8yiSvRbWcIXpo=;
        b=J3rM9+o46aTO2EvQd/1PyWZwBys+F63+j3A3awpz1gYIPKLH5Jyuxnmz6svN/GGrMR
         Xjmvq0iTLRf+enm6vwyFnRi7g13iZTMr7zcPjPtxq/yM2IBY5Qf5LQm6KFttDX/Qd9el
         ZkV1NPiHHQ9nFaMIntdgzbQVAwgsbb3UGFWgr7auqE8kPkvkrV28Dz4amNdu84wRF14f
         MExeaNO5re+vaAV/EwKMbcGhfIPnC8oj2rSRAJH6/FyUt8mUE4uCHUZG7VskS//7VFEx
         /HaY5Nlyj8+N+s/BTgoh8dbiguMuz4wyUdk18ZVZxrkmYMMkg/8oQO1Rdg1byrv+WFnI
         AvMw==
X-Gm-Message-State: AOAM530uoYfiARz/abqsUv1b38c4L7zurJ/FQMltnXVPeFs2BiZK7Uen
        QH8malLZIKGL77sQwO3J8/A=
X-Google-Smtp-Source: ABdhPJw0i44O3ltUZTj8glVC8asPuQYo/hnz7aP/vNjjGYNJJG/q1ZpDxwNRT2xDUR91PX/rB0osRA==
X-Received: by 2002:a17:90b:795:b0:1df:10a3:84e3 with SMTP id l21-20020a17090b079500b001df10a384e3mr10482308pjz.197.1652670543929;
        Sun, 15 May 2022 20:09:03 -0700 (PDT)
Received: from localhost (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id h125-20020a62de83000000b0050dc7628173sm5650872pfg.77.2022.05.15.20.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 20:09:03 -0700 (PDT)
From:   bh1scw@gmail.com
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Fanjun Kong <bh1scw@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm/page_owner.c: Add missing __initdata attribute
Date:   Mon, 16 May 2022 11:00:42 +0800
Message-Id: <20220516030039.1487005-1-bh1scw@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fanjun Kong <bh1scw@gmail.com>

This patch fix two issues:
1. Add __initdata attribute according to include/linux/init.h:
> For initialized data:
> You should insert __initdata between the variable name and equal
> sign followed by value

2. Fix below error reported by checkpatch.pl:
ERROR: do not initialise statics to false

Special thanks to Muchun Song :)

Suggested-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Fanjun Kong <bh1scw@gmail.com>
---
 mm/page_owner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 9185ff4eacb6..e4c6f3f1695b 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -34,7 +34,7 @@ struct page_owner {
 	pid_t tgid;
 };
 
-static bool page_owner_enabled = false;
+static bool page_owner_enabled __initdata;
 DEFINE_STATIC_KEY_FALSE(page_owner_inited);
 
 static depot_stack_handle_t dummy_handle;
-- 
2.36.0

