Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995FEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 13:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242657AbiFNNKl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 09:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239183AbiFNNKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:10:39 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC3D36698
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 06:10:35 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E7D18Y023629;
        Tue, 14 Jun 2022 08:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=YcUpMK2AczftXCxzQom7s5cbS6jwX5ZCnN31VDB+YXM=;
 b=OM+u0In+DWSJNpSoAeCGjcBQM2oyBYb1RpCvka5UL+zWpyCSr2bdJLyrt3L5JY+Bbpom
 KDVh06+qEyKceN5O5pQfTnL97gd41swPIys5yjgfadGZLu7IKslMKXE07i0m0VmBAvE1
 Qj7sNOqmQERXv+/Krt61UQ2Fu8KWIDJI/Sp/GTfOptUKHfcAusC2txe/jqMpvM6Zb4rD
 KWueGH6k7p3087TFleh0VkOUNLKtAKkoXQNJiq4s5S3VdiJ4U5jNiyX4DGvtXL2MTKlB
 BaUQULHZK6lAiBsjbeR4/Ys36VOCb8meU5RIXVKHWEIMMkPZJTAyTPt0tZVwOShT5dC3 gw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gmqfq357n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Jun 2022 08:10:24 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 14 Jun
 2022 14:10:22 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 14 Jun 2022 14:10:22 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A1A09458;
        Tue, 14 Jun 2022 13:10:22 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: cs35l45: Add endianness flag in snd_soc_component_driver
Date:   Tue, 14 Jun 2022 14:10:22 +0100
Message-ID: <20220614131022.778057-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aitggsH-mFGMuIZWhiIx_LPwba7ZFrJ5
X-Proofpoint-GUID: aitggsH-mFGMuIZWhiIx_LPwba7ZFrJ5
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The endianness flag is used on the CODEC side to specify an
ambivalence to endian, typically because it is lost over the hardware
link. This device receives audio over an I2S DAI and as such should
have endianness applied.

Fixes: 0d463d016000 ("ASoC: cs35l45: Add driver for Cirrus Logic CS35L45 Smart Amp")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l45.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
index c94edfce4b720..d15b3b77c7eb0 100644
--- a/sound/soc/codecs/cs35l45.c
+++ b/sound/soc/codecs/cs35l45.c
@@ -500,6 +500,8 @@ static const struct snd_soc_component_driver cs35l45_component = {
 	.num_controls = ARRAY_SIZE(cs35l45_controls),
 
 	.name = "cs35l45",
+
+	.endianness = 1,
 };
 
 static int __maybe_unused cs35l45_runtime_suspend(struct device *dev)
-- 
2.30.2

