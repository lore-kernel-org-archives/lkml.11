Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2280C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 16:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355901AbiDOQqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 12:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355902AbiDOQqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:46:32 -0400
X-Greylist: delayed 3352 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Apr 2022 09:44:02 PDT
Received: from 3.mo550.mail-out.ovh.net (3.mo550.mail-out.ovh.net [46.105.60.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261F4DB4AB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 09:44:01 -0700 (PDT)
Received: from player760.ha.ovh.net (unknown [10.109.156.39])
        by mo550.mail-out.ovh.net (Postfix) with ESMTP id D8AFE24077
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 16:06:38 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player760.ha.ovh.net (Postfix) with ESMTPSA id 489F02986A8B4;
        Fri, 15 Apr 2022 16:06:34 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-101G0043b24d311-889e-4edd-ac59-8ff49a2d3389,
                    77125C2C2681624F8512B69FC7A1C9B53E6602B4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 0/7] ASoC: remaining i2c_match_id i2c probe changes
Date:   Fri, 15 Apr 2022 18:06:06 +0200
Message-Id: <20220415160613.148882-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10956694945620592262
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudelhedgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejiedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series covers all the remaining changes to migrate
sound/soc/codecs i2c probes to probe_new, where the const struct
i2c_client * argument is still used. Instead of relying on the
parameter passed in, i2c_match_id is used instead.

With this set of patches, all the sound/soc/codecs i2c probes use the
new probe definition.

Changes since v1: two missing files were added.

Stephen Kitt (7):
  ASoC: ak*: use i2c_match_id and simple i2c probe
  ASoC: alc56*: use i2c_match_id and simple i2c probe
  ASoC: max980*: use i2c_match_id and simple i2c probe
  ASoC: pcm186x: use i2c_match_id and simple i2c probe
  ASoC: tas*: use i2c_match_id and simple i2c probe
  ASoC: tlv320*: use i2c_match_id and simple i2c probe
  ASoC: tpa6130: use i2c_match_id and simple i2c probe

 sound/soc/codecs/ak4613.c            | 10 +++++----
 sound/soc/codecs/ak4642.c            |  8 ++++---
 sound/soc/codecs/alc5623.c           | 24 +++++++++++----------
 sound/soc/codecs/alc5632.c           | 20 +++++++++--------
 sound/soc/codecs/max98088.c          | 21 +++++++++---------
 sound/soc/codecs/max98090.c          | 23 ++++++++++----------
 sound/soc/codecs/max98095.c          | 19 +++++++++--------
 sound/soc/codecs/pcm186x-i2c.c       | 24 ++++++++++-----------
 sound/soc/codecs/tas2562.c           | 25 +++++++++++-----------
 sound/soc/codecs/tas571x.c           | 11 ++++++----
 sound/soc/codecs/tas5720.c           | 21 +++++++++---------
 sound/soc/codecs/tlv320adc3xxx.c     | 21 +++++++++---------
 sound/soc/codecs/tlv320aic31xx.c     | 32 ++++++++++++++--------------
 sound/soc/codecs/tlv320aic32x4-i2c.c | 11 ++++++----
 sound/soc/codecs/tlv320aic3x-i2c.c   | 25 +++++++++++-----------
 sound/soc/codecs/tpa6130a2.c         | 19 +++++++++--------
 16 files changed, 168 insertions(+), 146 deletions(-)


base-commit: 5d763a740e5b24e4a2ca04317255e7e941876338
-- 
2.27.0

