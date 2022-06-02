Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065C5C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 16:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbiFBQVa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 12:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiFBQV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:21:28 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B7A2AD989
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 09:21:27 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252BrAOn027248;
        Thu, 2 Jun 2022 11:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=LLkRrjsu8/hYo9odlMpO0R406tjaPOUvBzHXbM0tbgM=;
 b=qQwQrL8x5R9LbcILhBgTnqXRyTkGnUPYDhJ1V27HcDJWOuJN1QAUu75PP/uY1bWGqXWv
 UoTaLQr0p7PTGKKEkEy3XwrmGTn3gzq9tN+5BOxRvGKG7LtTLI2vRScFc9GBU8B3c78Y
 qjiqGVhRfb3XTBh4Qsg293eVnSFUv7ZhPHodU+uIVWUGLu9+PF96yqKJianos5Yek6Zl
 3zzXbDwFXBk3/cNcq1hdA1kDLojty9PajIfX7oSMMANlsOj7Rjz3D7tn8ESEFFRzuHIR
 WeD6nfi+NucKxRykfrYuF365PcRvZLldKg98Tkvb8RgEd7XO2vanPHcLY8Ww6G8Kuxtt 9A== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gbg5nnqyj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Jun 2022 11:21:21 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 17:21:19 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 2 Jun 2022 17:21:19 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2D1C62A1;
        Thu,  2 Jun 2022 16:21:19 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] ASoC: cs35l36: Update digital volume TLV
Date:   Thu, 2 Jun 2022 17:21:15 +0100
Message-ID: <20220602162119.3393857-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602162119.3393857-1-ckeepax@opensource.cirrus.com>
References: <20220602162119.3393857-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0OPw23O0cNPlvGHZ86tdDgnaLidcIRfq
X-Proofpoint-GUID: 0OPw23O0cNPlvGHZ86tdDgnaLidcIRfq
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The digital volume TLV specifies the step as 0.25dB but the actual step
of the control is 0.125dB. Update the TLV to correct this.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l36.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l36.c b/sound/soc/codecs/cs35l36.c
index 920190daa4d1b..dfe85dc2cd20f 100644
--- a/sound/soc/codecs/cs35l36.c
+++ b/sound/soc/codecs/cs35l36.c
@@ -444,7 +444,8 @@ static bool cs35l36_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static DECLARE_TLV_DB_SCALE(dig_vol_tlv, -10200, 25, 0);
+static const DECLARE_TLV_DB_RANGE(dig_vol_tlv, 0, 912,
+				  TLV_DB_MINMAX_ITEM(-10200, 1200));
 static DECLARE_TLV_DB_SCALE(amp_gain_tlv, 0, 1, 1);
 
 static const char * const cs35l36_pcm_sftramp_text[] =  {
-- 
2.30.2

