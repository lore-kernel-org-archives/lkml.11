Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237E6C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349166AbiBUJY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:24:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348989AbiBUJLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:11:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E970D29817;
        Mon, 21 Feb 2022 01:04:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5F230CE0E6D;
        Mon, 21 Feb 2022 09:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51390C340E9;
        Mon, 21 Feb 2022 09:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645434276;
        bh=i95IN5wsVP1dRG+L5U0tLCUOsgGqvFbMeSDSTW5ZPDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1xmmCxEq+Cq1381/ErDFjk5MQbKHDtIoivjIwRBj5ti76u5FuwDYULlCMIyC4IlQx
         5EQzelO6EaxCviPFMhrmUFkdBjUmYsy8exD3VFwDNNnBStEa7t7qsdQ4jUOv0wxujB
         8yTYn69KzsiBgjkMT6jUERGT/fruowf6n+n/gRKg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.10 074/121] ASoC: ops: Fix stereo change notifications in snd_soc_put_volsw_range()
Date:   Mon, 21 Feb 2022 09:49:26 +0100
Message-Id: <20220221084923.721764114@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084921.147454846@linuxfoundation.org>
References: <20220221084921.147454846@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

commit 650204ded3703b5817bd4b6a77fa47d333c4f902 upstream.

When writing out a stereo control we discard the change notification from
the first channel, meaning that events are only generated based on changes
to the second channel. Ensure that we report a change if either channel
has changed.

Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20220201155629.120510-4-broonie@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/soc-ops.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -510,7 +510,7 @@ int snd_soc_put_volsw_range(struct snd_k
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 	unsigned int val, val_mask;
-	int ret;
+	int err, ret;
 
 	if (invert)
 		val = (max - ucontrol->value.integer.value[0]) & mask;
@@ -519,9 +519,10 @@ int snd_soc_put_volsw_range(struct snd_k
 	val_mask = mask << shift;
 	val = val << shift;
 
-	ret = snd_soc_component_update_bits(component, reg, val_mask, val);
-	if (ret < 0)
-		return ret;
+	err = snd_soc_component_update_bits(component, reg, val_mask, val);
+	if (err < 0)
+		return err;
+	ret = err;
 
 	if (snd_soc_volsw_is_stereo(mc)) {
 		if (invert)
@@ -531,8 +532,12 @@ int snd_soc_put_volsw_range(struct snd_k
 		val_mask = mask << shift;
 		val = val << shift;
 
-		ret = snd_soc_component_update_bits(component, rreg, val_mask,
+		err = snd_soc_component_update_bits(component, rreg, val_mask,
 			val);
+		/* Don't discard any error code or drop change flag */
+		if (ret == 0 || err < 0) {
+			ret = err;
+		}
 	}
 
 	return ret;


