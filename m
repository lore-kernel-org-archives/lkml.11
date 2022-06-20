Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5883C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jun 2022 09:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239904AbiFTJwF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jun 2022 05:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbiFTJwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:52:03 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C20312740
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:52:03 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 23so3688579pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ScavJ5HfhBRFtp0zZHKVoMhJivP0tHPP6Uwhse7r8IM=;
        b=Ay8c6qhZEr9qS+H3ohWqGjxavZZoUZ9K/gG55l2mPfw+JckNDtHZcrD0Q91o2jGE/X
         hS2mObt+EUFJDgpnJo2UroCnBFqBt6R5UOonPvu50q0qmntDMklPlsRefXBbZ7IM6GW2
         WXY9rmxVieb5wSAN+BMRX0tRnTp3csftG3OzNa4maomwjsmd6e5g5H6hB1sCm5Vaboz6
         MQLASFkSKm2nvdgfyJnzOmghGyYaTPk8mnY2aMPQs8en75qq5yyk57k4tP6+olxzeO6t
         TcvwmA9xLq45d6wbe+/RHEfDhp47NnmkShtAoKgRrwTnv470waP3L3dkcWbr+GhqWCcE
         j+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ScavJ5HfhBRFtp0zZHKVoMhJivP0tHPP6Uwhse7r8IM=;
        b=6cJL6uol52sS6Y8DoAgVgb/rwJ8+uWD21RhJ00r6mMRn3ZDr1rxCmtfUfUPv8Ae2C2
         Pp4OdYh2mTF7STcOppM3jWmQpNlvWXIVnMQMxTkyG9gdTARoX/kpT+cRZIUoP1YSgFAR
         y4xNB1hUXE9s5cKVltGoZu0UG3dsyiLI4eBwjjRfeknkGTE7jvQMCrYKW+jLMDZvTVd7
         xbXKM4Lm6Ug1X53YzeRWa+S41oclCEADPNCqf7JwyxVODf7+gHrfX7Pta40itp54sz1D
         7Ox4z+tf6FCLTqDwElUnNg501Ks2Pt8haUhI12K1iKdg4+NlSP7bLuw8PyGigs3yZGmW
         49FA==
X-Gm-Message-State: AJIora/W+rdTVmQyanEdiW2cUE9Q6c+Y+5hdeSUYpemQv5aiLqQXcX6B
        cfvefJRL3oHmk05GFCKb20M=
X-Google-Smtp-Source: AGRyM1sJ+XVyiAZN4I6bNRgTaeRUvlGZ9noyuAJnlzPP9FBFZf1QXqijDgY2zwWgiiodkgcxRxRDbQ==
X-Received: by 2002:a05:6a00:2999:b0:51b:e3c8:9e30 with SMTP id cj25-20020a056a00299900b0051be3c89e30mr23574088pfb.41.1655718722912;
        Mon, 20 Jun 2022 02:52:02 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:5ba:aaeb:5bc7:ad59])
        by smtp.gmail.com with ESMTPSA id u23-20020a17090ae01700b001e31803540fsm4856710pjy.6.2022.06.20.02.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:52:02 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] xtensa: change '.bss' to '.section .bss'
Date:   Mon, 20 Jun 2022 02:51:35 -0700
Message-Id: <20220620095135.1203323-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason (ancient assembler?) the following build error is
reported by the kisskb:

  kisskb/src/arch/xtensa/kernel/entry.S: Error: unknown pseudo-op: `.bss':
  => 2176

Change abbreviated '.bss' to the full '.section .bss, "aw"' to fix this
error.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index e3eae648ba2e..ab30bcb46290 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -2173,7 +2173,7 @@ ENDPROC(ret_from_kernel_thread)
 
 #ifdef CONFIG_HIBERNATION
 
-	.bss
+	.section	.bss, "aw"
 	.align	4
 .Lsaved_regs:
 #if defined(__XTENSA_WINDOWED_ABI__)
-- 
2.30.2

