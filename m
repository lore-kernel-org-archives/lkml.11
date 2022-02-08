Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCA1C433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 22:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386370AbiBHWZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386268AbiBHT4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:56:36 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE47C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:56:35 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id i186so430207pfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bEuFabhi4s5RnjxPIYxj4DedlRPIZTHUi8+c7RPZuTQ=;
        b=kAQDIqOT6WCY2iQ9AJkcW6T11cnNzYM1j3b3VJBw+2Ch3J16G3vr1jAAjw6lK5SgZn
         +7WgvEwrTtBa8r+Wt/NwjqM3WNNK4mRnc4RAOFAwSLa51JPsP+9rZCt2pj011l5lLoNP
         OCHOFppzgh8DeQXzOTRta0ByM/oLoHH31b04sagveg0XMKJ8xK0IU/LlwQL2iQ/9gdDj
         mwTQOZH1B59tkRS6gJ7UqH+FRWo/LC5sMsJJYqfIgI80VejXkFbgEnd6NcgLQp03sKtq
         fh+P+Lfv0iBlkpcRrX1sf8UQq7OTEqCTBASwtqSIWHcP1f4Q2NwzVTp2HnyTAzLfOtEx
         0mmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bEuFabhi4s5RnjxPIYxj4DedlRPIZTHUi8+c7RPZuTQ=;
        b=i72uZ57+VdNw70Mt2t/fidxgcIdaROWHoCqKRhplBzUbzy+m39UEsRyozSyLB2+FY8
         SLnjLSIOMa2vRnSC1n5cIS4X8igcORYdVNb8wr0XJYE2/unoj3Q/Soy+t8PmeKaehYQt
         H+7EjXoaAtkU7v2UQjvVv3XoZ9G0jqNo9YGo2GB8fBCvlpYrh6K8MyZ1JhZs+9Y5pa2F
         0pkou0rlHDHrHeDngh78XaIZ7yADPXpGstQWnHxA+m84s2rTPfjZzZdlLZg/gF+cW6E5
         vnv4NTIR8mfaVfb6Dqw4mcqBUGsUB3bgCH/uB+9CdYOagI4d1HNNTohR7L2N+o3U+jhN
         WWrQ==
X-Gm-Message-State: AOAM5315WUCaSKQWZAr2/doo35MgI3vKY6JgnCBqsOhV7HIG07xSZvrL
        7LzYBcTcZgsjA8KBQJ4arg==
X-Google-Smtp-Source: ABdhPJwWAFT8woVj8haxkOvEJO/MUnrJm7rG6nT5yWEm52lmYBTYqTSs/iR7m6hNH93Qshw8QB1UWQ==
X-Received: by 2002:a63:4f49:: with SMTP id p9mr4810023pgl.133.1644350195200;
        Tue, 08 Feb 2022 11:56:35 -0800 (PST)
Received: from localhost.localdomain ([121.165.123.189])
        by smtp.gmail.com with ESMTPSA id s29sm2874839pfw.159.2022.02.08.11.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:56:34 -0800 (PST)
From:   JaeSang Yoo <js.yoo.5b@gmail.com>
X-Google-Original-From: JaeSang Yoo <jsyoo5b@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        JaeSang Yoo <jsyoo5b@gmail.com>
Subject: [PATCH v3] trace: param: fix tp_printk option related with tp_printk_stop_on_boot
Date:   Wed,  9 Feb 2022 04:54:22 +0900
Message-Id: <20220208195421.969326-1-jsyoo5b@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel param "tp_printk_stop_on_boot" starts with "tp_printk" which is
the exact as the other kernel param "tp_printk".
In compile & build process, It may not guaranteed that
"tp_printk_stop_on_boot" always checked before "tp_printk".
(By swapping its __setup() macro order, it may not work as expected.)
Some kernel params which starts with other kernel params consider this
problem. See commit 745a600cf1a6 ("um: console: Ignore console= option")
or init/do_mounts.c:45 (setup function of "ro" kernel param)

Kernel param "tp_printk" can be handled with its value(0 or off) or
it can be handled without its value. (maybe it won't effect anything)
Fix setup function to ignore when the "tp_printk" becomes prefix of
other kernel param.

Signed-off-by: JaeSang Yoo <jsyoo5b@gmail.com>
---
from v2, I thought the changes were obvious that I didn't even tried to
check whether it has obvious typo. Sorry about that.

 kernel/trace/trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c860f582b078..48f34ab29db2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -252,6 +252,9 @@ __setup("trace_clock=", set_trace_boot_clock);
 
 static int __init set_tracepoint_printk(char *str)
 {
+	/* Ignore the "tp_printk_stop_on_boot" param */
+	if (*str == '_')
+		return 0;
 	if ((strcmp(str, "=0") != 0 && strcmp(str, "=off") != 0))
 		tracepoint_printk = 1;
 	return 1;
-- 
2.25.1

