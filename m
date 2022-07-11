Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66978C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 10:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbiGKKEG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 06:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbiGKKD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:03:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5E2AB7FE;
        Mon, 11 Jul 2022 02:29:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DA2EB80D2C;
        Mon, 11 Jul 2022 09:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84111C34115;
        Mon, 11 Jul 2022 09:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657531756;
        bh=u6uVBS3Wdb5rawdD2BPm9jKCU9OiNfMRMgbErBXsGM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p00QI4gpTObjuY34jKGrNjMVHnw5sKSsX0tp5wTbCIGa5xiT4siH0M3k18+67qXqW
         2XPQMIPpVhWqpSyHWfyBqC8tX5v1nJZum6TVDzy9mDK84ZjDEQdGfih3sP42pn03hJ
         EaBdZjqnDc9b+lWGLI+mfDmC6ECxOeFhg77NSzSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 179/230] ASoC: rt711: Add endianness flag in snd_soc_component_driver
Date:   Mon, 11 Jul 2022 11:07:15 +0200
Message-Id: <20220711090609.189791935@linuxfoundation.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711090604.055883544@linuxfoundation.org>
References: <20220711090604.055883544@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 33f06beac3ade10834a82ad4105dcd91d4b00d61 ]

The endianness flag is used on the CODEC side to specify an
ambivalence to endian, typically because it is lost over the hardware
link. This device receives audio over a SoundWire DAI and as such
should have endianness applied.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20220504170905.332415-31-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt711.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt711.c b/sound/soc/codecs/rt711.c
index a7c5608a0ef8..9cc7283a19c2 100644
--- a/sound/soc/codecs/rt711.c
+++ b/sound/soc/codecs/rt711.c
@@ -943,6 +943,7 @@ static const struct snd_soc_component_driver soc_codec_dev_rt711 = {
 	.num_dapm_routes = ARRAY_SIZE(rt711_audio_map),
 	.set_jack = rt711_set_jack_detect,
 	.remove = rt711_remove,
+	.endianness = 1,
 };
 
 static int rt711_set_sdw_stream(struct snd_soc_dai *dai, void *sdw_stream,
-- 
2.35.1



