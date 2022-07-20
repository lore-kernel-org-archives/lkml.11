Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAA7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 19:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiGTT6r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 15:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGTT6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:58:46 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0DC54C81
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:58:40 -0700 (PDT)
X-QQ-mid: bizesmtp85t1658347100t3i1qnje
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 21 Jul 2022 03:58:10 +0800 (CST)
X-QQ-SSF: 0100000000200030C000B00A0000020
X-QQ-FEAT: hoArX50alxH98OUvPUVBbyqiVwZNp3TNDC56TczZlb7YsKlmcTzFVWQWGteBb
        4snqm2P3EAmLSQNyGA2hrlpCyscabIAHeMmrizKGjnBYNHzG89eYRZ4qkIOIzFHsJ95ds59
        5pgLofybb576NkhqHdVNRiSVWho4n9EJb4/j3ztRwS/3mnyUJg9vYRH0frOiQ9kbtkm8Uhq
        fnC1g2PqGoL2bLzxt7s+BVuYnkqvKZUedem1mpO1m1VziYwWaQvLnnW8CNSV5b79m7MdVgA
        F+e2AqbCo8ejuQQFKEP//wPTntgSYDli/V+c3F6wl3MDLpx0XZE/XJejcAcSDhOasYdk8HW
        LyZA4YtLA/fq6CnqENHyv8F9xbAu76W4zWoEsk7xyXh2tTXQo/Ep7erPSrDTQ==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     fred.oh@linux.intel.com, akihiko.odaki@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] ASoC:do not initialise statics to 0.
Date:   Thu, 21 Jul 2022 03:58:09 +0800
Message-Id: <20220720195809.9470-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do not initialise statics to 0.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 45c301ea5e00..8a8b25589c55 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -50,7 +50,7 @@ struct cht_mc_private {
 #define CHT_RT5645_SSP0_AIF2     BIT(18)
 #define CHT_RT5645_PMC_PLT_CLK_0 BIT(19)
 
-static unsigned long cht_rt5645_quirk = 0;
+static unsigned long cht_rt5645_quirk;
 
 static void log_quirks(struct device *dev)
 {
-- 
2.30.2

