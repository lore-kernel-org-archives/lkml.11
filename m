Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3607C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 03:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiF0DZt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jun 2022 23:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiF0DZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 23:25:39 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63EFF272C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 20:25:29 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 34A691E80D11;
        Mon, 27 Jun 2022 11:24:37 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1vS-1UF097dy; Mon, 27 Jun 2022 11:24:34 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 65D031E80D5E;
        Mon, 27 Jun 2022 11:24:34 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] sound: It seems that the code format could be cleaner
Date:   Mon, 27 Jun 2022 11:25:21 +0800
Message-Id: <20220627032521.259750-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the condition statement and return statement could be
tidied up by adding blank lines.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 sound/pci/emu10k1/p16v.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/pci/emu10k1/p16v.c b/sound/pci/emu10k1/p16v.c
index 18a1b0740e6b..d594c874f61a 100644
--- a/sound/pci/emu10k1/p16v.c
+++ b/sound/pci/emu10k1/p16v.c
@@ -510,7 +510,9 @@ snd_p16v_pcm_pointer_playback(struct snd_pcm_substream *substream)
 	ptr3 = snd_emu10k1_ptr20_read(emu, PLAYBACK_LIST_PTR, channel);
 	ptr1 = snd_emu10k1_ptr20_read(emu, PLAYBACK_POINTER, channel);
 	ptr4 = snd_emu10k1_ptr20_read(emu, PLAYBACK_LIST_PTR, channel);
-	if (ptr3 != ptr4) ptr1 = snd_emu10k1_ptr20_read(emu, PLAYBACK_POINTER, channel);
+	if (ptr3 != ptr4)
+		ptr1 = snd_emu10k1_ptr20_read(emu, PLAYBACK_POINTER, channel);
+
 	ptr2 = bytes_to_frames(runtime, ptr1);
 	ptr2+= (ptr4 >> 3) * runtime->period_size;
 	ptr=ptr2;
@@ -703,9 +705,10 @@ static int snd_p16v_capture_source_put(struct snd_kcontrol *kcontrol,
 	u32 mask;
 	u32 source;
 
-	val = ucontrol->value.enumerated.item[0] ;
+	val = ucontrol->value.enumerated.item[0];
 	if (val > 7)
 		return -EINVAL;
+
 	change = (emu->p16v_capture_source != val);
 	if (change) {
 		emu->p16v_capture_source = val;
@@ -741,9 +744,10 @@ static int snd_p16v_capture_channel_put(struct snd_kcontrol *kcontrol,
 	int change = 0;
 	u32 tmp;
 
-	val = ucontrol->value.enumerated.item[0] ;
+	val = ucontrol->value.enumerated.item[0];
 	if (val > 3)
 		return -EINVAL;
+
 	change = (emu->p16v_capture_channel != val);
 	if (change) {
 		emu->p16v_capture_channel = val;
@@ -813,6 +817,7 @@ int snd_p16v_alloc_pm_buffer(struct snd_emu10k1 *emu)
 	emu->p16v_saved = vmalloc(array_size(NUM_CHS * 4, 0x80));
 	if (! emu->p16v_saved)
 		return -ENOMEM;
+
 	return 0;
 }
 
-- 
2.18.2

