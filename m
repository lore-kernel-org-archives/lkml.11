Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6B5C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 08:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiGKIQF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 04:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiGKIPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:15:50 -0400
Received: from smtpbg516.qq.com (smtpbg516.qq.com [203.205.250.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1151DA56
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:15:46 -0700 (PDT)
X-QQ-mid: bizesmtp73t1657527335tdmplea0
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 11 Jul 2022 16:15:29 +0800 (CST)
X-QQ-SSF: 01400000002000G0T000B00A0000000
X-QQ-FEAT: 357G+HpUJafKVCqO/P4HU43U4zyZg+9kBNp/Le0Dv+PEfu7zWOm9YZ67+06Vh
        Twrfj/SaTivXtg17N7qgT0Yok17vf9Fud70QEt2IXdYGeCFqnz8G3fVs3vRZH5C1KWLyUsK
        oRlalOjDdVi1Q90PqFM7MVIAkklbqxxjAuNjDqnU+pz7BSpQm7xkewzGVSEn6AIYWEOx9A2
        cMZ6P6o3GGBXm+rhSB3I4uso9Usk3yL54nd5LLY6xcO9I/Lcd8ZKu3L6NUujd/T3HkZdrN8
        sew5zpffE7kj9FJ6DM6Bv1NRnGasGgr+P8p2/PDC2t7kPUiMTG65eFsCCKJLVVEbbINW86/
        wNeObm9K9uLiAf8AxE5OjJJlgDX7w+Ytx8g1gPCsFHinP6TjqwA4j4M82dxo7ENegHHA/zp
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     tcrawford@system76.com, kai.heng.feng@canonical.com,
        wse@tuxedocomputers.com, tanureal@opensource.cirrus.com,
        cam@neo-zeon.de, kailang@realtek.com,
        sbinding@opensource.cirrus.com, yong.wu@mediatek.com,
        andy.chi@canonical.com, Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] ALSA: hda/realtek: Fix headset mic for Acer SF313-51
Date:   Mon, 11 Jul 2022 16:15:27 +0800
Message-Id: <20220711081527.6254-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign9
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issue on Acer SWIFT SF313-51 is that headset microphone
doesn't work. The following quirk fixed headset microphone issue.
Note that the fixup of SF314-54/55 (ALC256_FIXUP_ACER_HEADSET_MIC)
was not successful on my SF313-51.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 007dd8b5e1f2..fe7c1194d052 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8886,6 +8886,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x129c, "Acer SWIFT SF314-55", ALC256_FIXUP_ACER_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x129d, "Acer SWIFT SF313-51", ALC256_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1300, "Acer SWIFT SF314-56", ALC256_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1308, "Acer Aspire Z24-890", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x132a, "Acer TravelMate B114-21", ALC233_FIXUP_ACER_HEADSET_MIC),
-- 
2.20.1



