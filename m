Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A602C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 12:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241692AbiGSMss (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 08:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241772AbiGSMs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95BC8CCA2;
        Tue, 19 Jul 2022 05:19:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0B9D6177F;
        Tue, 19 Jul 2022 12:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92823C341C6;
        Tue, 19 Jul 2022 12:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658233120;
        bh=GI93qm+hNCMbPVCaHUDMokRaQgsWxtQUOoMPeSa7lCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZWxxsWCjZUxlwFCne01mJfAe3D1UeKgzCYC7YM3pwNSt8RUMe+3CEd2+2g0RNO1qW
         kmZkwYbEjXSGvEHQr5ameTSMuOMrDiGjBjcsDDv3JrkLqi46Y6K7GZIudXbIxw4dPk
         84xkiQJchf1W0u2odP5Mbj4tj/PnMQSMfV1lW4Jw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Meng Tang <tangmeng@uniontech.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.18 013/231] ALSA: hda/realtek - Enable the headset-mic on a Xiaomis laptop
Date:   Tue, 19 Jul 2022 13:51:38 +0200
Message-Id: <20220719114715.192367792@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719114714.247441733@linuxfoundation.org>
References: <20220719114714.247441733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meng Tang <tangmeng@uniontech.com>

commit 9b043a8f386485c74c0f8eea2c287d5bdbdf3279 upstream.

The headset on this machine is not defined, after applying the quirk
ALC256_FIXUP_ASUS_HEADSET_MIC, the headset-mic works well

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20220713094133.9894-1-tangmeng@uniontech.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9425,6 +9425,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),


