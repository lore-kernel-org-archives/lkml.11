Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EAFC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 06:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiGLGA0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 02:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGLGAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 02:00:23 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F9E31DE4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 23:00:21 -0700 (PDT)
X-QQ-mid: bizesmtp69t1657605612tslowixw
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 12 Jul 2022 14:00:07 +0800 (CST)
X-QQ-SSF: 01400000002000G0T000B00A0000000
X-QQ-FEAT: 8mvwyB2Dxk9RiwgK9+fAaoojQwPmzq6NU9cN3uF3lUWLk7SlBvwoIdeI51YTe
        ST+HpJ17tKOBtfx/Pc1hCww1UvZKC18SbfTE3CJqsLjLLym50L9RmWmZRMYlWWe8PSkojB/
        LAMuKxAw1cNYaU2rRUL8j+I8GA3TS3jSn1S2OVTxinKgxXWVDn43iAceZ3GEIk9IF5f4iYP
        OPRXiVyc9sj8B3zuVVgmuVudxsLk8QjOT+jfg8Y2se3MUX9HOX9dum65g8I43YEpc4hECc7
        olGDdzIgfLFkQb1j1Z5FPJDd2SHnySKPqyGIGgphrv2sewvwwq4cQqcuuhsib+B9frgfQ3r
        uqfp7uEfX5kRSTya87t2V17+tjnzfNBLQcr9SC86W+JRA90qKfUV5igUDJxBA==
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com, tcrawford@system76.com,
        kai.heng.feng@canonical.com, tanureal@opensource.cirrus.com,
        cam@neo-zeon.de, kailang@realtek.com,
        sbinding@opensource.cirrus.com, andy.chi@canonical.com,
        yong.wu@mediatek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] ALSA: hda - Add fixup for Dell Latitidue E5430
Date:   Tue, 12 Jul 2022 14:00:05 +0800
Message-Id: <20220712060005.20176-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another Dell model, another fixup entry: Latitude E5430 needs the same
fixup as other Latitude E series as workaround for noise problems.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fe7c1194d052..ecc737342fcc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8896,6 +8896,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x1430, "Acer TravelMate B311R-31", ALC256_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1466, "Acer Aspire A515-56", ALC255_FIXUP_ACER_HEADPHONE_AND_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
+	SND_PCI_QUIRK(0x1028, 0x053c, "Dell Latitude E5430", ALC292_FIXUP_DELL_E7X),
 	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_DELL_XPS),
 	SND_PCI_QUIRK(0x1028, 0x05bd, "Dell Latitude E6440", ALC292_FIXUP_DELL_E7X),
 	SND_PCI_QUIRK(0x1028, 0x05be, "Dell Latitude E6540", ALC292_FIXUP_DELL_E7X),
-- 
2.20.1



