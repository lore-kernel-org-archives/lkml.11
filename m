Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51745C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 00:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343993AbiCHAEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 19:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243897AbiCHAEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 19:04:41 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CC53466B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 16:03:45 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q76-20020a25d94f000000b00628bdf8d1a9so13010522ybg.17
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 16:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+EaaN9rrO3ntvRkcqCnT36NX3bdOataMRNYTDOWB4Hc=;
        b=lJQd7e3/lr+iipERF0USMu3L7FPdeoWWOBqyphwmo+CH34oFlfmCXIHP/OIgpx1gt9
         xxdz51I6tg0FVaFbCNjDleQRCDPdoLwd2konWOj7y2nmel2vgFzt6+CVm2EfbVGC27dj
         RoyUUoSQ85nVqnLq5Nvv+agVX9lrpJ8d1ByH8aQx4UnP+RnNcm7fnVl5UyjhGlkna3LF
         UvC5VYj+gnG9JM1aWtLGrXUq4tvdnez56p2Ou0glohHnuPD74vQXZyj4fBXzjX31P/w/
         TNjfFR+ePZ3ZPmyt4cb/qXx9iKkaR1OwUyGNIIgPLXYjp9HhZehMzOzTl50R0Qkrce//
         FknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+EaaN9rrO3ntvRkcqCnT36NX3bdOataMRNYTDOWB4Hc=;
        b=B44WdBSPsiLsCdMTt3BnSTt/lg6XtBiDZfdAC/IVzmtso8t3mIvvqzk52uwO2rRLwq
         S0+6SYRGR1b6T7kq7eG9YXpXNHslOE33ObDQN3bH9A/7XNOZOLWdxOPqvnUJ6yD5EjtJ
         3TxEAcyOE8d+27X1v4xhgDRs/qttG0V8lVAg9Irnj7pqdKlHJcVtE7fK2b+TClknGBf+
         e46Rytsn3jT+zmMCt3NvHcG7iFyes+uK0N2Ai2c3KWFH0PkNCBdU4xDLKjhRgCdISMqP
         hhMr+U0yTQcLqGLgUi2vYipdkBXQi9FVTbamWkRUC7GSUxhuJ7PiTNplzLUisETAQKwU
         DsmQ==
X-Gm-Message-State: AOAM531p9Fe7wBlBbM38i45wwjHOpeESnUvlsazjkOD7EX06i3ZcCiln
        WrctdjQCwudHYFZ5G0O+GbcUX5U0HbY=
X-Google-Smtp-Source: ABdhPJxOxCli3zIPDkGfJiqLTWAJLHb8P4M9PCUnTnb76hVlgOVnfnlLiDQDUTy18FLi5SiqTvhUuEmIeKQ=
X-Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2cd:202:9113:6b5:b00c:3d40])
 (user=khazhy job=sendgmr) by 2002:a25:e54a:0:b0:628:b77e:5352 with SMTP id
 c71-20020a25e54a000000b00628b77e5352mr9911259ybh.445.1646697824483; Mon, 07
 Mar 2022 16:03:44 -0800 (PST)
Date:   Mon,  7 Mar 2022 16:02:53 -0800
Message-Id: <20220308000253.645107-1-khazhy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH] bfq: default slice_idle to 0 for SSD
From:   Khazhismel Kumykov <khazhy@google.com>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This improves performance on SSDs dramatically, and was default for CFQ

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/bfq-iosched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 36a66e97e3c2..f3196036940c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7105,7 +7105,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->bfq_fifo_expire[1] = bfq_fifo_expire[1];
 	bfqd->bfq_back_max = bfq_back_max;
 	bfqd->bfq_back_penalty = bfq_back_penalty;
-	bfqd->bfq_slice_idle = bfq_slice_idle;
+	/* Default to no idling for SSDs */
+	bfqd->bfq_slice_idle = blk_queue_nonrot(q) ? 0 : bfq_slice_idle;
 	bfqd->bfq_timeout = bfq_timeout;
 
 	bfqd->bfq_large_burst_thresh = 8;
-- 
2.35.1.616.g0bdcbb4464-goog

