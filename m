Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EDAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349216AbiBUJY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:24:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348944AbiBUJLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:11:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9626528E22;
        Mon, 21 Feb 2022 01:04:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 13DC4CE0E6D;
        Mon, 21 Feb 2022 09:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF485C340E9;
        Mon, 21 Feb 2022 09:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645434268;
        bh=uZgeIOlLsvVD5iElQGJhHXz3bdc7jZQ5AEpDpH33PSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eTbN4fXay8qJzB/oM/05ZXCIH/D+91IO3oO8rNJDkUoclSJBj7lVBbfNPAdEgVKgi
         TEH0yQE0MM4y/NwSdGhbRSEG1n2NGuwIrFzgy5qP+rwLv5As0TZeGLvd1EBXVffmGc
         m4YxkMy698xNIkbum5KNVw9GSL3mrg5FzjSzXc1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, dmummenschanz@web.de,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10 071/121] ALSA: hda: Fix regression on forced probe mask option
Date:   Mon, 21 Feb 2022 09:49:23 +0100
Message-Id: <20220221084923.608959658@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084921.147454846@linuxfoundation.org>
References: <20220221084921.147454846@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 6317f7449348a897483a2b4841f7a9190745c81b upstream.

The forced probe mask via probe_mask 0x100 bit doesn't work any longer
as expected since the bus init code was moved and it's clearing the
codec_mask value that was set beforehand.  This patch fixes the
long-time regression by moving the check_probe_mask() call.

Fixes: a41d122449be ("ALSA: hda - Embed bus into controller object")
Reported-by: dmummenschanz@web.de
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/trinity-f018660b-95c9-442b-a2a8-c92a56eb07ed-1644345967148@3c-app-webde-bap22
Link: https://lore.kernel.org/r/20220214100020.8870-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/hda_intel.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1837,8 +1837,6 @@ static int azx_create(struct snd_card *c
 
 	assign_position_fix(chip, check_position_fix(chip, position_fix[dev]));
 
-	check_probe_mask(chip, dev);
-
 	if (single_cmd < 0) /* allow fallback to single_cmd at errors */
 		chip->fallback_to_single_cmd = 1;
 	else /* explicitly set to single_cmd or not */
@@ -1866,6 +1864,8 @@ static int azx_create(struct snd_card *c
 		chip->bus.core.needs_damn_long_delay = 1;
 	}
 
+	check_probe_mask(chip, dev);
+
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
 	if (err < 0) {
 		dev_err(card->dev, "Error creating device [card]!\n");


