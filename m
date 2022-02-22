Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9134C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 12:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiBVMAd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 07:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiBVMAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:00:16 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C30156C61
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:51 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d27so32755522wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86hxaHzF3RhEyMf0w7EdDLKHhFRcTnHl9QY4411LC24=;
        b=UIYqOQ5C+72BzCNoV0Ugv17YE9b5pOJ8j4O4j8v5N3W3spxXNFGYmh+JuMT6dyBZKb
         LgYLALuS0ZRyW1ETyfWUoXYOnHNSlESqQGOuAtDPwGhyqehPgnuqkf2MRw35c5ojGyet
         d+GFubJ4UQzpFdkmNknnaqkjCTknZYI4L01jiQ1kDjKNVKmkGPek9fNkR3DS4A6SKxqp
         KwEdE9xqccsnhLTHECBq0N2JJMy7Z6sLOgz4asz9ckKRmkYEIkjNtX7EhALiFDUSxUlI
         cnSrdT75XERF/adspig2vL09edaCtVQF3noFXpLboD2IJ1N2tuACnHavad6EqLbiVA5w
         +DaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86hxaHzF3RhEyMf0w7EdDLKHhFRcTnHl9QY4411LC24=;
        b=ITqSCwxEupAPJHDC/AnKFrrjxJvStkWALASWpqsKCtAD44L2P+nsObZximsTwQxhiY
         BXUuuGlOW8tb8I+yNQ5bIvmt12YV76JiLAP9E/CWKIzDWG6nKAgFoJeKTl1O8DZxellj
         g1nKJWqmr5S0KuToZzYb8OqRpOJwBSH1P4jb4kJZNLo2DnBi+WLjnQJ8QITXmIz2M1Jn
         1UVNDtLE3wvt/u8KbA6eRgniXsxG2j8hoEo4xs8YDjcWwQOzr2GG4QK8z/FuV0MA6FUw
         IIsoNHlZ3shC8F3UjnJdH1XdRwQN6SrECibN1BxAnDLFj1niqPd/jzBjCrddJs+2hIVe
         khhg==
X-Gm-Message-State: AOAM531aZmyU0V25yCyubIsPgl9PGKsAMgARN3nBmUIwnArTIyAmWvPU
        gf9/kH2qZZStdoZtzXt+jpHZqQ==
X-Google-Smtp-Source: ABdhPJzmGXWQa2fjf4E5qRANCuTFxziwaIr5wdxaoMdvMBH8nLxjraz5vVllu62TnUTDy9y72pbn3Q==
X-Received: by 2002:a5d:5185:0:b0:1e5:78a3:7747 with SMTP id k5-20020a5d5185000000b001e578a37747mr19520727wrv.470.1645531189570;
        Tue, 22 Feb 2022 03:59:49 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a18sm50014661wrg.13.2022.02.22.03.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:59:49 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/16] ASoC: codecs: rx-macro: fix accessing array out of bounds for enum type
Date:   Tue, 22 Feb 2022 11:59:19 +0000
Message-Id: <20220222115933.9114-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
References: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accessing enums using integer would result in array out of bounds access
on platforms like aarch64 where sizeof(long) is 8 compared to enum size
which is 4 bytes.

Fixes: 4f692926f562 ("ASoC: codecs: lpass-rx-macro: add dapm widgets and route")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index a7f86b094a4f..058d8634ce40 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -2273,7 +2273,7 @@ static int rx_macro_mux_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_dapm_to_component(widget->dapm);
 	struct rx_macro *rx = snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] =
+	ucontrol->value.enumerated.item[0] =
 			rx->rx_port_value[widget->shift];
 	return 0;
 }
@@ -2285,7 +2285,7 @@ static int rx_macro_mux_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_dapm_to_component(widget->dapm);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct snd_soc_dapm_update *update = NULL;
-	u32 rx_port_value = ucontrol->value.integer.value[0];
+	u32 rx_port_value = ucontrol->value.enumerated.item[0];
 	u32 aif_rst;
 	struct rx_macro *rx = snd_soc_component_get_drvdata(component);
 
@@ -2397,7 +2397,7 @@ static int rx_macro_get_hph_pwr_mode(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct rx_macro *rx = snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] = rx->hph_pwr_mode;
+	ucontrol->value.enumerated.item[0] = rx->hph_pwr_mode;
 	return 0;
 }
 
@@ -2407,7 +2407,7 @@ static int rx_macro_put_hph_pwr_mode(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct rx_macro *rx = snd_soc_component_get_drvdata(component);
 
-	rx->hph_pwr_mode = ucontrol->value.integer.value[0];
+	rx->hph_pwr_mode = ucontrol->value.enumerated.item[0];
 	return 0;
 }
 
-- 
2.21.0

