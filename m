Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E04C04A68
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jul 2022 14:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiG0OOz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jul 2022 10:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiG0OOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:14:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3213CBE5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:14:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h8so24437093wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=HlFl4TB+ozKKXomSw+QhNP8jLuIDommpFYIfVxfLtCc=;
        b=rUfK2qdgZHqlVpoXX0nP91/R5TMDc8m05GlXIZ8h+UpC6YIYJWJR18mAsjE0pFzdhW
         J0h+m/HvNlcDWeW2Xeu1hcmxVT2yFGAlR0gaAk8q8FWN2lzsaugcNNKUqTVhpHjofa4u
         GcOAGYDcZcjciNv38yQ2mUiAAobxQbQUnlOwsciaFq/ysk38Il8TKHLOo93MQ0gTchX8
         Rxb0OVDt+5yixxinOqNdDfdLyCDMrsUq0dPHuCFdlwSbqtgolYBff41g+xROdziLLUrO
         fbbwULZU5Dr8QAAdKZQ6Uaj+PuUyEqc2Di70BCEwF0bh+Hr3+hVqOizB4H661FTy2Br2
         BOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=HlFl4TB+ozKKXomSw+QhNP8jLuIDommpFYIfVxfLtCc=;
        b=Rkk3pXktRCpPVHMvRUFbLrR5cyc4BLnfUpmfhsoDqQ6Oc/PrqJerRcKwKPJVlohWog
         FEDgHr6YkecoOnM8ebQthYp+hYiW1yUvU0dtf2iZlbhqrSMY5arrtvHVTFVVkYxfLtQn
         RwGaIgFDQ/rBuklKrehwhE1N3sQ/9SDEq/PyHP0ogLYKLXqI0EwwUi2FfRL2If7PbDhA
         HRYfRBzMTVFr1K5+CQ8Hhw9+lOEJ33n4bfXpbanz9jNrFMSWqf6k59M6x88IJVIFd+er
         e0x2OJT6wr4YpLlEP2NOlsxk4WJFGOooLMwRqetGFo/1S5y68bfrjtCNLqTd5/mdNK9L
         qmBw==
X-Gm-Message-State: AJIora9OnQfKWS0K2zqUuiIJ9UGok9xO9SsqyutIMwzdbyllYjXQAPGa
        fXHikqC5BDoZbvZCK0ge7n6qqQ==
X-Google-Smtp-Source: AGRyM1tmAzBvRGxN5q9WGQAVHCzdtmgiFFKwLKon/HRs50v9bLy+7JJn+oW4qgu8LLZ8X/dDIrmh2A==
X-Received: by 2002:adf:d4c2:0:b0:21e:ddf3:8b14 with SMTP id w2-20020adfd4c2000000b0021eddf38b14mr1589672wrk.355.1658931289199;
        Wed, 27 Jul 2022 07:14:49 -0700 (PDT)
Received: from localhost.localdomain (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id o20-20020a05600c339400b0039c54bb28f2sm2489524wmp.36.2022.07.27.07.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 07:14:48 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     jan.kiszka@siemens.com
Cc:     linux-kernel@vger.kernel.org, narmstrong@baylibre.com,
        kbingham@kernel.org, Amjad Ouled-Ameur <aouledameur@baylibre.com>
Subject: [PATCH 1/3] scripts/gdb: timerlist: use range instead of xrange
Date:   Wed, 27 Jul 2022 16:14:41 +0200
Message-Id: <20220727141443.133094-2-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220727141443.133094-1-aouledameur@baylibre.com>
References: <20220727141443.133094-1-aouledameur@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xrange has been renamed to range in Python 3. Therefore,
timerlist currently fails with NameError exception:

Python Exception <class 'NameError'> name 'xrange' is not defined.

Use range instead of xrange.

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
 scripts/gdb/linux/timerlist.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index 071d0dd5a634..fac951236dc4 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -73,7 +73,7 @@ def print_cpu(hrtimer_bases, cpu, max_clock_bases):
     ts = cpus.per_cpu(tick_sched_ptr, cpu)
 
     text = "cpu: {}\n".format(cpu)
-    for i in xrange(max_clock_bases):
+    for i in range(max_clock_bases):
         text += " clock {}:\n".format(i)
         text += print_base(cpu_base['clock_base'][i])
 
-- 
2.37.1

