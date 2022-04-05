Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D93C4321E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 12:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382879AbiDEMRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 08:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244965AbiDEIwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:52:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194831C91E;
        Tue,  5 Apr 2022 01:48:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD6C7614F9;
        Tue,  5 Apr 2022 08:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE854C385A1;
        Tue,  5 Apr 2022 08:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148482;
        bh=9ayTQoypg7Ma7Hon0Ma1b8RWYUYomggH8SeZpQc0dmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BAWoLJwN2M02LCfqt5WW5EtqlGpHVZsDKzD1Slg3VglF9rNrYZX4NspVi7Zq0VoT6
         NBknvL7XPn5DKPvoEbyNU69QkMSmbh7KUV26oDXABidPfYdBvP/flSH3tp/GHoPgPY
         VpooC6MsAJzypM1u0bFiEd2u2k3mUadxhzUQnYtI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0371/1017] ASoC: cs35l41: Fix max number of TX channels
Date:   Tue,  5 Apr 2022 09:21:24 +0200
Message-Id: <20220405070405.298448305@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

[ Upstream commit 16639d39bdf577168d3fe34315917a94365c8d19 ]

This device only has 4 TX channels.

Fixes: fe1024d50477b ("ASoC: cs35l41: Combine adjacent register writes")
Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20220303173059.269657-3-tanureal@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l41.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 3188a8ba3507..8a2d0f9dd9a6 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1113,7 +1113,7 @@ static struct snd_soc_dai_driver cs35l41_dai[] = {
 		.capture = {
 			.stream_name = "AMP Capture",
 			.channels_min = 1,
-			.channels_max = 8,
+			.channels_max = 4,
 			.rates = SNDRV_PCM_RATE_KNOT,
 			.formats = CS35L41_TX_FORMATS,
 		},
-- 
2.34.1



