Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0828C282E7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 18:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbiHOSRZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 14:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbiHOSQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:16:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AA82B192;
        Mon, 15 Aug 2022 11:14:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F91B61255;
        Mon, 15 Aug 2022 18:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0FAC433C1;
        Mon, 15 Aug 2022 18:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660587291;
        bh=blS0VXUuDeGoODmIARLmWCjHHJbjbJG1WxzFTGnnuUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X/IKbGIURt6CtV7s8I7pFUFIo1jYtOC1NVB+45g4yIWBmFH5h69e60/IupQHeCPzH
         aNhgHtBs8o+KYjXeDqHub93Vh9d5GtIXNodgOMsMJuwnO8C61NU7MHzATKYsZIa3MR
         LkSQ6q8Tvf1n/GnAVm4x3zwdbZVKmroFlNb/h+gw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bedant Patnaik <bedant.patnaik@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 038/779] ALSA: hda/realtek: Add a quirk for HP OMEN 15 (8786) mute LED
Date:   Mon, 15 Aug 2022 19:54:42 +0200
Message-Id: <20220815180338.855541272@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180337.130757997@linuxfoundation.org>
References: <20220815180337.130757997@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bedant Patnaik <bedant.patnaik@gmail.com>

commit 30267718fe2d4dbea49015b022f6f1fe16ca31ab upstream.

Board ID 8786 seems to be another variant of the Omen 15 that needs
ALC285_FIXUP_HP_MUTE_LED for working mute LED.

Signed-off-by: Bedant Patnaik <bedant.patnaik@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20220809142455.6473-1-bedant.patnaik@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8879,6 +8879,7 @@ static const struct snd_pci_quirk alc269
 		      ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8783, "HP ZBook Fury 15 G7 Mobile Workstation",
 		      ALC285_FIXUP_HP_GPIO_AMP_INIT),
+	SND_PCI_QUIRK(0x103c, 0x8786, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8787, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),


