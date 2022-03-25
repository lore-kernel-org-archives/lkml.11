Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21D2C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 15:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353283AbiCYPQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 11:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359838AbiCYPMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:12:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DC963BC6;
        Fri, 25 Mar 2022 08:09:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1604861BF5;
        Fri, 25 Mar 2022 15:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9E0C340EE;
        Fri, 25 Mar 2022 15:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648220960;
        bh=Aguwb+9KguJ4/q4pa7ohP9HdU154UMOl/+9GBH2lNh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GuL4eDB3oe6ge9famQAdsnuAZDmvguFNaKwS4fc+U4v+zvCElC0BE9SYkUCb27Qyv
         BpZmLt4x74uam3ilvXbTHtUlqH42cZ7RfQq2MFNwukbinXDReryPyelbR+pTYaalhy
         HNLmyHLweHllY5lz1SgwT6c0EfUh5tcZFK3aZcw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Zheng <jasonzheng2004@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10 18/38] ALSA: hda/realtek: Add quirk for ASUS GA402
Date:   Fri, 25 Mar 2022 16:05:02 +0100
Message-Id: <20220325150420.280540487@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325150419.757836392@linuxfoundation.org>
References: <20220325150419.757836392@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Zheng <jasonzheng2004@gmail.com>

commit b7557267c233b55d8e8d7ba4c68cf944fe2ec02c upstream.

ASUS GA402 requires a workaround to manage the routing of its 4 speakers
like the other ASUS models. Add a corresponding quirk entry to fix it.

Signed-off-by: Jason Zheng <jasonzheng2004@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20220313092216.29858-1-jasonzheng2004@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8801,6 +8801,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_GA401),
+	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),


