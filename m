Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5EBC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 17:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbiCCRcW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 12:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbiCCRcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:32:05 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8348C19E70B;
        Thu,  3 Mar 2022 09:31:19 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2234AADs028599;
        Thu, 3 Mar 2022 11:31:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=iU149EM7M/AHlMwIB50uQiV8rzjtqYcRHDfP9G2pN8o=;
 b=S3mL+7ZHXpt5iQeh5xX/Nr1Sqm63F0HfQjPXijr3cMWPJS1oXgqgTdgWMVp4Dh6B8Fmf
 +9W2mUVLThYj+jRqVnqAmv7GWxaO83OyTWPbSOKczpcFUxV+mn03vKyWR5QeZ2pRSLo/
 1xFvRTEQhKTbkiPhmHciyvuRkJJC4S/evXHxZU24g9PZgbdJOApFrFkx01CboPDHLJoT
 u3LZIaMex/c8CivUI9UFuptEH1JeubQD+lAt9RDKWLPUec0okUjLtiq64sGZXLZxs6Tq
 ltdM0CWUSHG0OLPLOjpoQF9VYJ1ny2ZtOV+kszcQbUIyXPQFD1NKo9SWjIoY4Z41IUdi ew== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ejncq8ybk-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Mar 2022 11:31:05 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 17:31:03 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 3 Mar 2022 17:31:03 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 00E68B1A;
        Thu,  3 Mar 2022 17:31:02 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 02/20] ASoC: cs35l41: Fix max number of TX channels
Date:   Thu, 3 Mar 2022 17:30:41 +0000
Message-ID: <20220303173059.269657-3-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
References: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: enMY_OxG3_DcjfBvyUF6wYo2UOZDFUJI
X-Proofpoint-GUID: enMY_OxG3_DcjfBvyUF6wYo2UOZDFUJI
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device only has 4 TX channels.

Fixes: fe1024d50477b ("ASoC: cs35l41: Combine adjacent register writes")
Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 90c91b00288b..f3787d77f892 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1091,7 +1091,7 @@ static struct snd_soc_dai_driver cs35l41_dai[] = {
 		.capture = {
 			.stream_name = "AMP Capture",
 			.channels_min = 1,
-			.channels_max = 8,
+			.channels_max = 4,
 			.rates = SNDRV_PCM_RATE_KNOT,
 			.formats = CS35L41_TX_FORMATS,
 		},
-- 
2.35.1

