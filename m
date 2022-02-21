Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0FFC35276
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 10:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353850AbiBUKCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 05:02:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352304AbiBUJyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:54:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F4837A8B;
        Mon, 21 Feb 2022 01:23:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59935608C4;
        Mon, 21 Feb 2022 09:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE73C340E9;
        Mon, 21 Feb 2022 09:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645435437;
        bh=ihAIbfYlvinEEfGKUNpuvcQtGz1ie3/Qc9/kth+Vujs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eNaMmqcjaqNC3lVQCnju0t5knYvFJ9SbE2PWnUIEXHok/34TKqz/kEAAKJBWklFd7
         bMsjeuUZrDHdYkkirKWeud/YsO0H9zdKTZzbtyndPuHcKU56r40M08k1vcGrpYNO5v
         9pOFcLltGyl4iziGMkkbUTbQjT29f3UDahPcSs1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.16 146/227] ASoC: ops: Fix stereo change notifications in snd_soc_put_xr_sx()
Date:   Mon, 21 Feb 2022 09:49:25 +0100
Message-Id: <20220221084939.685159541@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084934.836145070@linuxfoundation.org>
References: <20220221084934.836145070@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

commit 2b7c46369f09c358164d31d17e5695185403185e upstream.

When writing out a stereo control we discard the change notification from
the first channel, meaning that events are only generated based on changes
to the second channel. Ensure that we report a change if either channel
has changed.

Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20220201155629.120510-5-broonie@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/soc-ops.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -895,6 +895,7 @@ int snd_soc_put_xr_sx(struct snd_kcontro
 	unsigned long mask = (1UL<<mc->nbits)-1;
 	long max = mc->max;
 	long val = ucontrol->value.integer.value[0];
+	int ret = 0;
 	unsigned int i;
 
 	if (val < mc->min || val > mc->max)
@@ -909,9 +910,11 @@ int snd_soc_put_xr_sx(struct snd_kcontro
 							regmask, regval);
 		if (err < 0)
 			return err;
+		if (err > 0)
+			ret = err;
 	}
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_xr_sx);
 


