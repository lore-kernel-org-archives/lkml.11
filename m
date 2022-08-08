Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E548AC25B0C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 14:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243522AbiHHOV3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Aug 2022 10:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243461AbiHHOVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:21:22 -0400
X-Greylist: delayed 446 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 Aug 2022 07:21:20 PDT
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0863D101CF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:21:18 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1659968028; bh=tKWeu11aeXQ63OTvc9oUPZOVNW4tJ0tCoIcgd5/QzcY=;
        h=From:To:Cc:Subject:Date;
        b=GGUn9Xxh2AOR8fCPJgCDChOVNwKnSOyuiqs3uIgw/vAXBqML5KNhp08xKmHIplmbG
         u+1g3fkMUTJoNwJlKhId87MCk28tPqAaCnv7TxQerQ8+pOUV+hrvEqO2Gx/b0HYI8E
         9plHX3cuKzWMlrjbVBdJaOYFSg4UL2HW3uKGKUzM=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Stephen Kitt <steve@sk2.org>,
        Frank Shi <shifu0704@thundersoft.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: [PATCH 0/4] TAS2770 fixes
Date:   Mon,  8 Aug 2022 16:12:42 +0200
Message-Id: <20220808141246.5749-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two fixes should be straightforward.

The latter two clean up what looks to me like a mess in the setting of
power levels. However we settle it, we should then do the same changes
to TAS2764, which has the same template (and maybe there are other
drivers).

Martin Povišer (4):
  ASoC: tas2770: Set correct FSYNC polarity
  ASoC: tas2770: Allow mono streams
  ASoC: tas2770: Drop conflicting set_bias_level power setting
  ASoC: tas2770: Fix handling of mute/unmute

 sound/soc/codecs/tas2770.c | 98 +++++++++++++++++---------------------
 sound/soc/codecs/tas2770.h |  5 ++
 2 files changed, 48 insertions(+), 55 deletions(-)

-- 
2.33.0

