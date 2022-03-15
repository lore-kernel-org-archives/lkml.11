Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A93C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 14:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349418AbiCOOrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 10:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238359AbiCOOrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:47:13 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BAD5549B;
        Tue, 15 Mar 2022 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647355561; x=1678891561;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=79o5gBeuclgkLLR0bESNlJlpxKJpRWFQRiAB8i6yArY=;
  b=KxaJGYj0aijlyQ7wPQWA+W7/YDJ94FmWhDxqNaTDWz+FXiWhrWYTNyBA
   i8AEvPGVC15+J62yYSvfhg2FH8YRwm/upr/+xyKxlod21QoSJzZ0vurkk
   bFUJ6JlkOlpYDzAZyisTA0H7ev7a+FItIhCOkUNWxKEvlYDF4DOEDHg7q
   k=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 15 Mar 2022 07:46:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 07:46:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Mar 2022 07:45:53 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 15 Mar 2022 07:45:47 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH] ASoC: codecs: Fix misplaced lpass_macro_pds_exit call
Date:   Tue, 15 Mar 2022 20:15:31 +0530
Message-ID: <1647355531-4150-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update power domains exit function calling from runtime resume
to remove function which was wrongly placed and causing crash in
device suspend and resume.

Fixes: 9e3d83c52844 ("ASoC: codecs: Add power domains support in digital macro codecs")
Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 sound/soc/codecs/lpass-tx-macro.c | 4 ++--
 sound/soc/codecs/lpass-va-macro.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index b492d598..714a411 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1920,6 +1920,8 @@ static int tx_macro_remove(struct platform_device *pdev)
 	clk_disable_unprepare(tx->npl);
 	clk_disable_unprepare(tx->fsgen);
 
+	lpass_macro_pds_exit(tx->pds);
+
 	return 0;
 }
 
@@ -1964,8 +1966,6 @@ static int __maybe_unused tx_macro_runtime_resume(struct device *dev)
 	regcache_sync(tx->regmap);
 	tx->reset_swr = true;
 
-	lpass_macro_pds_exit(tx->pds);
-
 	return 0;
 err_fsgen:
 	clk_disable_unprepare(tx->npl);
diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index 300f4f6..f3cb596 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1503,6 +1503,8 @@ static int va_macro_remove(struct platform_device *pdev)
 	clk_disable_unprepare(va->dcodec);
 	clk_disable_unprepare(va->macro);
 
+	lpass_macro_pds_exit(va->pds);
+
 	return 0;
 }
 
@@ -1532,8 +1534,6 @@ static int __maybe_unused va_macro_runtime_resume(struct device *dev)
 	regcache_cache_only(va->regmap, false);
 	regcache_sync(va->regmap);
 
-	lpass_macro_pds_exit(va->pds);
-
 	return 0;
 }
 
-- 
2.7.4

