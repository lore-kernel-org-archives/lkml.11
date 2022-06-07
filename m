Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C55C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 06:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbiFGG5j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 02:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbiFGG5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:57:33 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E873CA6D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 23:57:21 -0700 (PDT)
X-QQ-mid: bizesmtp73t1654585032t8s42oo4
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 07 Jun 2022 14:57:10 +0800 (CST)
X-QQ-SSF: 01400000002000B0I000B00A0000000
X-QQ-FEAT: 3uawQE1sH+0UENyeZvBC2+CqJpj1X/QUXqr0o5erVBPRI3rYEoJGAe8aH2Z25
        8OgPf7MwX9EgjwGBudMmQ6qGoUtpJ/S+lJ5tB7hvZq8BsklQ+Yt7UcoTMhRoxww78M7Z13o
        iDaqoANJdy69LLTTKtKCmYTYlUpyehXGDJj/kzTX3ue0Z1JpMbs0FU+VyjkWV4fSWaFBXWM
        Fa/2ovqlMsZoPK+4dnDWbht8YPZRCTwnNq/UIIh6wMehcRPW0Puw+R201pgKlRyRzNUEAHm
        A3cxriZ4W2WkpbJw3dttm5tp3gA28bJn4a+G/1/aU/geTTbxGN2WrP/9wwV7rorXT7kTYfC
        xdcd8dN2/bOVpFbf54=
X-QQ-GoodBg: 2
From:   huangwenhui <huangwenhuia@uniontech.com>
To:     tiwai@suse.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        huangwenhui <huangwenhuia@uniontech.com>
Subject: [PATCH] ALSA: hda/conexant - Fix loopback issue with CX20632
Date:   Tue,  7 Jun 2022 14:56:31 +0800
Message-Id: <20220607065631.10708-1-huangwenhuia@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign9
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a machine with CX20632,Alsamixer doesn't have 'Loopback
Mixing' and 'Line'.

Signed-off-by: huangwenhui <huangwenhuia@uniontech.com>
---
 sound/pci/hda/patch_conexant.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index aa360a0af284..1248d1a51cf0 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1052,6 +1052,13 @@ static int patch_conexant_auto(struct hda_codec *codec)
 		snd_hda_pick_fixup(codec, cxt5051_fixup_models,
 				   cxt5051_fixups, cxt_fixups);
 		break;
+	case 0x14f15098:
+		codec->pin_amp_workaround = 1;
+		spec->gen.mixer_nid = 0x22;
+		spec->gen.add_stereo_mix_input = HDA_HINT_STEREO_MIX_AUTO;
+		snd_hda_pick_fixup(codec, cxt5066_fixup_models,
+				   cxt5066_fixups, cxt_fixups);
+		break;
 	case 0x14f150f2:
 		codec->power_save_node = 1;
 		fallthrough;
-- 
2.20.1



