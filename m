Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E915C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245627AbiBUJER (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:04:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347164AbiBUJAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:00:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E7924BF1;
        Mon, 21 Feb 2022 00:55:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EEE461132;
        Mon, 21 Feb 2022 08:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410F9C340E9;
        Mon, 21 Feb 2022 08:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645433757;
        bh=0IHBxBj+mSzRF3pqjgSMPF1nRShF3VDoFYEXzinVlzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tEIDohYIVnzEy9Ek0gxGu0m3QqFNvA/LzKfRaUFQfkjwuvEcYTMOE2Ttwc2EEi17r
         4nwikq/DLVXBP+HzwPDYkZeOJFCUvGCmbsZZq7I3tsc/J0CBdeaQmoicVeH3x3/DAv
         ucrRsJ8Vf2hkWyEQiy8qTkZ769Bv1rF1QuNdDy8g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, dmummenschanz@web.de,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 32/58] ALSA: hda: Fix missing codec probe on Shenker Dock 15
Date:   Mon, 21 Feb 2022 09:49:25 +0100
Message-Id: <20220221084912.919869748@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084911.895146879@linuxfoundation.org>
References: <20220221084911.895146879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit dd8e5b161d7fb9cefa1f1d6e35a39b9e1563c8d3 upstream.

By some unknown reason, BIOS on Shenker Dock 15 doesn't set up the
codec mask properly for the onboard audio.  Let's set the forced codec
mask to enable the codec discovery.

Reported-by: dmummenschanz@web.de
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/trinity-f018660b-95c9-442b-a2a8-c92a56eb07ed-1644345967148@3c-app-webde-bap22
Link: https://lore.kernel.org/r/20220214100020.8870-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/hda_intel.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1674,6 +1674,7 @@ static struct snd_pci_quirk probe_mask_l
 	/* forced codec slots */
 	SND_PCI_QUIRK(0x1043, 0x1262, "ASUS W5Fm", 0x103),
 	SND_PCI_QUIRK(0x1046, 0x1262, "ASUS W5F", 0x103),
+	SND_PCI_QUIRK(0x1558, 0x0351, "Schenker Dock 15", 0x105),
 	/* WinFast VP200 H (Teradici) user reported broken communication */
 	SND_PCI_QUIRK(0x3a21, 0x040d, "WinFast VP200 H", 0x101),
 	{}


