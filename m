Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C81C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 11:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242759AbiEULMI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 May 2022 07:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiEULL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:11:57 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043EA2980B;
        Sat, 21 May 2022 04:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9rNZC50FyEC3dXd4iqi0InhhNWKvB2/su8ouG+co16E=;
  b=bd/cjqYiC7Bpgo62xWS12uKdKNP05etKAoBX4HEHrh6AbJxy6pt3L14+
   700iUlRgpcJiaXNjeM7VkG1xdAD1n5NpD8enQH1dFJ+YKiCW/TG24im4B
   wHzJdtqGZ3nJ+JcjrM+dU3IzEPeBlqGEIRTSWWBRz5OhDMttAdNPNDjT/
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727885"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:52 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jaya Kumar <jayakumar.alsa@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: cs5535audio: fix typo in comment
Date:   Sat, 21 May 2022 13:10:11 +0200
Message-Id: <20220521111145.81697-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 sound/pci/cs5535audio/cs5535audio_pcm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/cs5535audio/cs5535audio_pcm.c b/sound/pci/cs5535audio/cs5535audio_pcm.c
index 5ff10fec7b90..0db24cc4d916 100644
--- a/sound/pci/cs5535audio/cs5535audio_pcm.c
+++ b/sound/pci/cs5535audio/cs5535audio_pcm.c
@@ -129,7 +129,7 @@ static int cs5535audio_build_dma_packets(struct cs5535audio *cs5535au,
 		return 0;
 
 	/* the u32 cast is okay because in snd*create we successfully told
-   	   pci alloc that we're only 32 bit capable so the uppper will be 0 */
+	   pci alloc that we're only 32 bit capable so the upper will be 0 */
 	addr = (u32) substream->runtime->dma_addr;
 	desc_addr = (u32) dma->desc_buf.addr;
 	for (i = 0; i < periods; i++) {

