Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6A2C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 16:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376764AbiCYQHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 12:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376785AbiCYQHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:07:43 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D363AAF1FA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:06:03 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E28D93F740;
        Fri, 25 Mar 2022 16:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1648224354;
        bh=OA8100kM+8BvVa/E6bZ9DGd04WTsE6yOkFCC60dlMtE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=klGsK3do1OYdQZDfA2fuzXlRxnhQNtDq8VVOnt+utOHPEnHlsDRL1SzxKJkjXXPaa
         eIWBiHurMaHMYITVzJeFPKaC+k46UBsrn1QKrUZq/+3NjhUkV70nldwj63r4dnSSjP
         EXvBUibKhmgODO/ahn6ulyzxLkp083FCpapYTPTKnXdmZ/N7s+IsE+yuzphAO/pIVF
         hKvncHpVrbVElll2Lpn+E5K7s1fXJyeNsZ2Rvf6ntJepNQXSLMXzxSFwMVIM/XOyK6
         ClOZPVt9uhIg1UVkf0SRbbThS5+Lybv2P0wunvNSUu6h/T0nNfNtb8YGbKTY8xn+2k
         TYTyhsfrpW3XA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>, Sami Loone <sami@loone.fi>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Enable headset mic on Lenovo P360
Date:   Sat, 26 Mar 2022 00:05:00 +0800
Message-Id: <20220325160501.705221-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lenovo P360 is another platform equipped with ALC897, and it needs
ALC897_FIXUP_HEADSET_MIC_PIN quirk to make its headset mic work.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e88fbef57c40c..4c33cb57963db 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11152,6 +11152,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc051, "Samsung R720", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x14cd, 0x5003, "USI", ALC662_FIXUP_USI_HEADSET_MODE),
 	SND_PCI_QUIRK(0x17aa, 0x1036, "Lenovo P520", ALC662_FIXUP_LENOVO_MULTI_CODECS),
+	SND_PCI_QUIRK(0x17aa, 0x1057, "Lenovo P360", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32ca, "Lenovo ThinkCentre M80", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cb, "Lenovo ThinkCentre M70", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cf, "Lenovo ThinkCentre M950", ALC897_FIXUP_HEADSET_MIC_PIN),
-- 
2.34.1

