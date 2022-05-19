Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A97BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 02:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiESCNz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 22:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiESCNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 22:13:52 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AEA53721
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 19:13:51 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p12so3884244pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 19:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rr/Z8lIuwod83sK9/THugMPkDoGeWIkKPvWwosbdeJg=;
        b=JD/qYhP8UezTRIl7mKJGofTp75y3YtKRngrnVQszhFCd4lZCs9pmDCenW24A5jCJ7+
         h4Gk3rVAQVegkmW6Hr9YaC7lprEelCqi9IulyVW8sRGFRmFPqom3LyxAv2/+j/tlEvch
         vK1ACsyddt/yHqV/1U9npLlm7rxM96WbDWGJSCIRpPvd8jgjubMSZt223UTAGCLCLLoF
         0FuLQTB3qOGgnPtineoSO5YNto7RaUE6SIVGzAIeAuS5TNkbBxaScLaUrdlCvY2lLmGk
         +FL3cyjwwY8lDmqRN1S9ktnen8h8hMx/qefPPzebN3SlyORa41CeAaf7E9LXceotYgz/
         HqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rr/Z8lIuwod83sK9/THugMPkDoGeWIkKPvWwosbdeJg=;
        b=iGE6X597vFQitrU4FkjDdcr+LKtusvIaGdZxPqMYun/QRyIU1zsXIHo8MHsVrr7Hp7
         UP6LdK3RlLAUWo8WywwsU/vvPFmATZS6fYcKZ/16LFXx6MdPtSpQcYJFCPNePCrTHzCo
         0JzD6uxYNnTogex7W51o/HJCxzfJtD0FjgMgOUVTQkypCdf91BXPJKBqrhI7pdX/Xtex
         MNKCazJmHUTD1SxJNH89fDYZCwKpsA5iVxB0SRpeFf0G3KDOCrA+NDbwmQ+wgk4or3OE
         FDLpyatijBFK2gTeTx/TeaN+EY3EEhDpEpGazcDC2FcgUY1y8cthaMwsuXvtcotKGYNM
         tv4g==
X-Gm-Message-State: AOAM5333j3LOoRWC0P1lmLxor26Bp3igo4fFjM9Jtf/CXBX209odGmhP
        6tUNM+PHAFDr85t5e6E8J0w=
X-Google-Smtp-Source: ABdhPJyBc/0cVz+8VsM/S5tpnBd7rbXw47kTwP5NVdBeln1UfPz2L1MVm8nKVr7/+pA0z90fFBweuA==
X-Received: by 2002:a63:6a45:0:b0:3c1:47b7:edce with SMTP id f66-20020a636a45000000b003c147b7edcemr1957623pgc.207.1652926431111;
        Wed, 18 May 2022 19:13:51 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:568:8697:c74:ab15:730:f5f3])
        by smtp.gmail.com with ESMTPSA id je4-20020a170903264400b0015ebb3bf277sm2366603plb.238.2022.05.18.19.13.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 May 2022 19:13:50 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     oder_chiou@realtek.com, lgirdwood@gmail.com,
        ritchie_hsieh@richtek.com, allen_lin@richtek.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH 1/2] ASoC: rt9120: Fix 3byte read, valule offset typo
Date:   Thu, 19 May 2022 10:13:37 +0800
Message-Id: <1652926418-8519-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652926418-8519-1-git-send-email-u0084500@gmail.com>
References: <1652926418-8519-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

For RG 3byte read, the value order is  offset [0], [1], and [2].

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 sound/soc/codecs/rt9120.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt9120.c b/sound/soc/codecs/rt9120.c
index cdf8ad2..94d42be 100644
--- a/sound/soc/codecs/rt9120.c
+++ b/sound/soc/codecs/rt9120.c
@@ -372,7 +372,7 @@ static int rt9120_reg_read(void *context, unsigned int reg, unsigned int *val)
 		*val = be32_to_cpup((__be32 *)raw);
 		break;
 	case 3:
-		*val = raw[0] << 16 | raw[1] << 8 | raw[0];
+		*val = raw[0] << 16 | raw[1] << 8 | raw[2];
 		break;
 	case 2:
 		*val = be16_to_cpup((__be16 *)raw);
-- 
2.7.4

