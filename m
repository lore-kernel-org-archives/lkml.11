Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAA1C04AA5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 10:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbiHYKR2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 06:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbiHYKRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:17:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D597E760F8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:17:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s11so25431943edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=GRYnjCoOv7fVbYVCxvtIrJ8TN8JZyVqLZt43NaKxUoM=;
        b=MkA5Ertcl0rV0VTl6MFoxunlFKjgNYw4ii9oZZFjiQ9nbVkpNJ846hByN55W3qH+y2
         xmi3SY8zqPgJwRleEDWX3UqzBWw4xec0nu5OmJh18SXuDOsymlLxry5XVR19uu/5R3V5
         GZAcmhkfiszfhazV5kOLPzNPugYybWoy1zF1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=GRYnjCoOv7fVbYVCxvtIrJ8TN8JZyVqLZt43NaKxUoM=;
        b=jvTeAodAuabFPBvHCtdPnPSYOpqRAGwdz5R4SkOx1tOf9a8FyAJa1hblSiqVF/z3GE
         OiN8OoH56SAMsBugJbb1dfWJLx9OT10MAkbS45WqxSWlbm3STB9U/YNFvG6u2tHUU7GG
         snEC/4oIrrhKoTimr2+9yDEcGj11whb2z2GR8nOZfPa5IIj9oLUgzD9cxoIvbmpydWio
         UNa8Ip6HIsKk+geau8ZZOYbdHrJ1BehR2dZjIXQxX1A6u8G0Hpm+oKLPDM0juGUdHtPj
         LSapbeEDdl7oOOzN6hKJv7YYMKmdaUvZ5bLcZpFDISvPR473m6svWHxFXxlelQmetMdu
         WSng==
X-Gm-Message-State: ACgBeo0pHSjju5abiUspoepVBCLk0TrO5zT+QzlSXO99Mwov0CHG5JSn
        ZfGPdNjoNtHXCS5hTo1xnPo6/g==
X-Google-Smtp-Source: AA6agR4VZr+45kHmpz4/CpzPzba03L/xyCKRO3rzRdai4aPfScrrrb8n6XRGo0La5yDq6ZtGPbJbyQ==
X-Received: by 2002:a05:6402:1d4d:b0:447:67b:2631 with SMTP id dz13-20020a0564021d4d00b00447067b2631mr2519353edb.243.1661422642447;
        Thu, 25 Aug 2022 03:17:22 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-57-252.cust.vodafonedsl.it. [188.217.57.252])
        by smtp.gmail.com with ESMTPSA id i12-20020a170906698c00b0073c23616cb1sm2320314ejr.12.2022.08.25.03.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 03:17:22 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Stephen Kitt <steve@sk2.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: max98088: add support for noise gate reg
Date:   Thu, 25 Aug 2022 12:17:13 +0200
Message-Id: <20220825101714.81580-1-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Noise Gate Threshold reg (ANTH reg 0x40 bit 4 to 7)

References:
 - https://datasheets.maximintegrated.com/en/ds/MAX98089.pdf, p75

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
 sound/soc/codecs/max98088.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 5ef2e1279ee7..76ef71ab9c83 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -474,6 +474,9 @@ static const struct snd_kcontrol_new max98088_snd_controls[] = {
                        max98088_mic2pre_get, max98088_mic2pre_set,
                        max98088_micboost_tlv),
 
+        SOC_SINGLE("Noise Gate Threshold", M98088_REG_40_MICAGC_THRESH,
+               4, 15, 0),
+
        SOC_SINGLE("INA Volume", M98088_REG_37_LVL_INA, 0, 7, 1),
        SOC_SINGLE("INB Volume", M98088_REG_38_LVL_INB, 0, 7, 1),
 
-- 
2.25.1

