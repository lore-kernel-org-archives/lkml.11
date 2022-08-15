Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66550C25B08
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 21:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349602AbiHOVsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 17:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349496AbiHOVoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:44:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ADB102295;
        Mon, 15 Aug 2022 12:29:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E75160FBE;
        Mon, 15 Aug 2022 19:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A0DC433C1;
        Mon, 15 Aug 2022 19:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660591789;
        bh=8VlNj6zxSpDnk3ycq08EdKMqa5hsv3oRypfnomeKsko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=miQ9NeNtltkpHjisp97gxRPj7va0lzizWEydOELhrNRF5gfy17BBGokzBmhEQLU9b
         HPYER/E2FchDkCL8GffRxoQp3cpiBo5tvAngPJpoeXd2PNDzCoacPAEVpwPEIiAAPy
         6TID7biw7ooLBPhVDW8mTCWlW6mbPNPU1xLbpOfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tim Crawford <tcrawford@system76.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.19 0009/1157] ALSA: hda/realtek: Add quirk for Clevo NV45PZ
Date:   Mon, 15 Aug 2022 19:49:25 +0200
Message-Id: <20220815180439.831985351@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180439.416659447@linuxfoundation.org>
References: <20220815180439.416659447@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Crawford <tcrawford@system76.com>

commit be561ffad708f0cee18aee4231f80ffafaf7a419 upstream.

Fixes headset detection on Clevo NV45PZ.

Signed-off-by: Tim Crawford <tcrawford@system76.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20220731032243.4300-1-tcrawford@system76.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9203,6 +9203,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1558, 0x4018, "Clevo NV40M[BE]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x4019, "Clevo NV40MZ", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x4020, "Clevo NV40MB", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x4041, "Clevo NV4[15]PZ", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x40a1, "Clevo NL40GU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x40c1, "Clevo NL40[CZ]U", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x40d1, "Clevo NL41DU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),


