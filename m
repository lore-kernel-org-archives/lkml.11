Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BD8C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 06:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiBXGCn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 01:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBXGCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:02:41 -0500
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E48F1EB1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:02:11 -0800 (PST)
Received: by mail-ot1-x349.google.com with SMTP id m24-20020a9d4c98000000b005af3b88a817so699946otf.14
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OO7dB9NTGAXAhA+gBMGfXBf6knvYeWfSe3D67/xkaoQ=;
        b=BldGrl8aFcOSbdVR4P9FzFom2hvFMTJ2CdwBc7COsLaKo1cqiF/+Gv99lsd8c1msIk
         3PD3Be4u1NT5Uq9QMkdoXYWRZOLLsqG5XPtMpaeNhTEQG8GTp9GnTdUEAPEl5akR1sNj
         WnqgtfZa3bJx8sd7/c5cCwNm9VXJZY46+8anaKY/zgT/j0wXuns5FpJFZHo2AmBLU4nu
         gf97IPxANjPSyVqDP4u7V9J64qkz7Sb+ZiAHC7iFbec6WNOV9mbmtfUGmS3TLmEr54jN
         LkVheQoAnmVvPsWELK0en87WmNFB7+QZFMwJBc10XRolneDIfLb6xZ22Hqek9MO2leHx
         14dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OO7dB9NTGAXAhA+gBMGfXBf6knvYeWfSe3D67/xkaoQ=;
        b=f0Y4kP31uS2ceY2QYVq+vIFbtqUQOh9al+BUXIKB0JE2VnJpmyPIpz2xzdYSwShRgp
         nMB3Mf/oD3r/Ff8yJFylLNhx1q7aE7n2cZhV0EnVLX2SD1QC0LtyfjMObDqQc1KaIbGB
         ZWfvKTomgvtwBrkuRHzK0fdDP2Fuy3jedYKlt7pxP7i3XIZED1b+OQrZuGzTv6DlUVxR
         u34jGmlGT6Q88G+v/CVRlJM717aVyq3s68OnFwtzwJ5Pv0NBIjl429ZZebcx+ABwKrVo
         SJTr7M15qqsfqLDnfqtzGsAaLASj++QjVE8Rxm/FBJzjsVW4qNbkJ5jpThI9rAh7mG89
         xOfw==
X-Gm-Message-State: AOAM532RmTYdvuevKYqaCpyFubTZQb42Zogw2Tfr6cNfxYlhvklOzlAu
        5qXwQEEhnxIsBWgEQz3gLUTUGRVYD2Wm7w==
X-Google-Smtp-Source: ABdhPJxGY+1TrcGtsNlDkKUCbu8WC3gLD389SbOn70+65fBzfSoK0DWaKfiA2Qns+WaBk+it7Umf54Sz69w5hw==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:8c61:13e8:87c2:e5f0])
 (user=shakeelb job=sendgmr) by 2002:a05:6808:ec7:b0:2cf:acb7:1b50 with SMTP
 id q7-20020a0568080ec700b002cfacb71b50mr6405998oiv.134.1645682530301; Wed, 23
 Feb 2022 22:02:10 -0800 (PST)
Date:   Wed, 23 Feb 2022 22:01:48 -0800
Message-Id: <20220224060148.4092228-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH] MAINTAINERS: add myself as a memcg co-maintainer as well
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have been contributing and reviewing to the memcg codebase for last
couple of years. So, making it official.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>

---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ab8f1621d027..cb97140e7dda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5014,6 +5014,7 @@ CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)
 M:	Johannes Weiner <hannes@cmpxchg.org>
 M:	Michal Hocko <mhocko@kernel.org>
 M:	Roman Gushchin <roman.gushchin@linux.dev>
+M:	Shakeel Butt <shakeelb@google.com>
 L:	cgroups@vger.kernel.org
 L:	linux-mm@kvack.org
 S:	Maintained
-- 
2.35.1.574.g5d30c73bfb-goog

