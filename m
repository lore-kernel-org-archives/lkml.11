Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156F9C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 08:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345521AbiBUIwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 03:52:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345207AbiBUIwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:52:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF63231D;
        Mon, 21 Feb 2022 00:51:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9B47B80EAF;
        Mon, 21 Feb 2022 08:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D79C340E9;
        Mon, 21 Feb 2022 08:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645433505;
        bh=IKosZnxsR4TZjrNqs+GBJ/ZnecQof4vVbduHHjS6+V8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NFzF8jS7ZAzY1zz05H4i7LSrxNyO4JdppSkJ72UxDETtgcg8FF0vKAqe9OZXqrLiH
         UpsjejLS/bxP3VwHAGNgXeLxk9dxifoaB3qyFeCZoyLsYRUVCLawfF0WjUA4tDwaGm
         mI7oXJ81juXK1EtOij2E1Q7OMQB8JNT6rbHSvagM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, dmummenschanz@web.de,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 22/33] ALSA: hda: Fix regression on forced probe mask option
Date:   Mon, 21 Feb 2022 09:49:15 +0100
Message-Id: <20220221084909.492830709@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084908.568970525@linuxfoundation.org>
References: <20220221084908.568970525@linuxfoundation.org>
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
@@ -1609,8 +1609,6 @@ static int azx_create(struct snd_card *c
 
 	assign_position_fix(chip, check_position_fix(chip, position_fix[dev]));
 
-	check_probe_mask(chip, dev);
-
 	chip->single_cmd = single_cmd;
 	azx_check_snoop_available(chip);
 
@@ -1631,6 +1629,8 @@ static int azx_create(struct snd_card *c
 		chip->bus.needs_damn_long_delay = 1;
 	}
 
+	check_probe_mask(chip, dev);
+
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
 	if (err < 0) {
 		dev_err(card->dev, "Error creating device [card]!\n");


