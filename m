Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FDEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 03:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiFFDhS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jun 2022 23:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiFFDhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 23:37:13 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695C939A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 20:37:11 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so16799904pju.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 20:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NLfIMDkhs8AhvETPVq+iAr24dyts/oFKMffXp6KK4SA=;
        b=dZc4jxqzQaYU6bNMX/oVrNpUuokhFNbSbjUF4Y4tn2uSgQi1wHF3KHqBN33PkyCgaC
         o7U9LIU2UUUYS1Pwu0A3M3cuGouUxUjzLuVyKc2wAC54r9ZJ8Qgx8S58EbPPGJTvhzj2
         nM+BTiEUYm/8FsYSHj5CvG3sdN4NGKGAJeNOc9EHx1kAgnAMadQUI/OAyMHosvsUiC4p
         kClEL8slmh2XMxZ29Y2e2BTs8KFlRoBq+prV65AP55IP0m7I35s3Bm5wtM/92RllXP24
         kp7BPPoNdsdSCvD05MwhaiAEesC289nQTsRnpEfyn7OLr+2a6MPp+7gehUyVtKnVbNn0
         mf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NLfIMDkhs8AhvETPVq+iAr24dyts/oFKMffXp6KK4SA=;
        b=u9P6Zaj8a+mldU7lTs/d4DsiVI3eLlF0XiixerX4qL4EGJZVA4kHppBokYeL+wxTRb
         7x6hao2F7tlQeSxFxw8xjigOqQ+5C3Zkff4aHOWhvdmDbwfPZuEPoqDYOrAjYHN/3cl9
         KtTT7gI7jto6rvPgbRt0XtZQMLA0ii62Hxaj5K2bF7eKJaRAbKoTu85r6ekj+raqnfTT
         OQxdBaBiXYXPBGjMac7ZChk4TXLYE7nr6YhAw7ztLZUjupgn01ybesPzetEBRtNun9If
         W2FXfSK5Bep5VWxKcin2LedrZHKJoKZwE/XxhuQsqnmMHKOYDSsw8ZJ+wpW2GlsDTL83
         1r/A==
X-Gm-Message-State: AOAM530GjpzUrtL7L3bzZg1mQLb3xfKna08fRoTsr9E9bx2aQKSjCfQr
        TZU/KTQRbS1KqKxf0HfxL3vuc2Uewt8=
X-Google-Smtp-Source: ABdhPJzHskn/0nDuJUNh+kkv/i2TwqL9zwM4+pDSLRb9NT1RjQFYEHsVEWABjF0pgTAaI31VavBwGw==
X-Received: by 2002:a17:90b:4b4b:b0:1dc:8724:3f75 with SMTP id mi11-20020a17090b4b4b00b001dc87243f75mr58394066pjb.178.1654486630864;
        Sun, 05 Jun 2022 20:37:10 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902db0a00b0015ee985999dsm9443596plx.97.2022.06.05.20.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 20:37:10 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     shengjiu.wang@gmail.com
Cc:     Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH V2] ASoC: imx-audmux: remove unnecessary check of clk_disable_unprepare/clk_prepare_enable
Date:   Mon,  6 Jun 2022 03:37:05 +0000
Message-Id: <20220606033705.291048-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Because clk_disable_unprepare/clk_prepare_enable already checked NULL clock
parameter, so the additional checks are unnecessary, just remove them.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
v1->v2:
	remove the check of audmux_clk before "clk_prepare_enable"
 sound/soc/fsl/imx-audmux.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index dfa05d40b276..3ba82adace42 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -62,17 +62,14 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 	uintptr_t port = (uintptr_t)file->private_data;
 	u32 pdcr, ptcr;
 
-	if (audmux_clk) {
-		ret = clk_prepare_enable(audmux_clk);
-		if (ret)
-			return ret;
-	}
+	ret = clk_prepare_enable(audmux_clk);
+	if (ret)
+		return ret;
 
 	ptcr = readl(audmux_base + IMX_AUDMUX_V2_PTCR(port));
 	pdcr = readl(audmux_base + IMX_AUDMUX_V2_PDCR(port));
 
-	if (audmux_clk)
-		clk_disable_unprepare(audmux_clk);
+	clk_disable_unprepare(audmux_clk);
 
 	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buf)
@@ -209,17 +206,14 @@ int imx_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
 	if (!audmux_base)
 		return -ENOSYS;
 
-	if (audmux_clk) {
-		ret = clk_prepare_enable(audmux_clk);
-		if (ret)
-			return ret;
-	}
+	ret = clk_prepare_enable(audmux_clk);
+	if (ret)
+		return ret;
 
 	writel(ptcr, audmux_base + IMX_AUDMUX_V2_PTCR(port));
 	writel(pdcr, audmux_base + IMX_AUDMUX_V2_PDCR(port));
 
-	if (audmux_clk)
-		clk_disable_unprepare(audmux_clk);
+	clk_disable_unprepare(audmux_clk);
 
 	return 0;
 }
-- 
2.25.1


