Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1275DC4167B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 11:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385316AbiBGLbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 06:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382769AbiBGLUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:20:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E81C03FED2;
        Mon,  7 Feb 2022 03:20:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17B54B811A6;
        Mon,  7 Feb 2022 11:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F32BC004E1;
        Mon,  7 Feb 2022 11:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644232820;
        bh=07DXET1mUt27c2qdzB5vxavcElMoUr/eGhq3NzQRh/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ay2woS+Ft2A7HTP2ZNzcnZ6TTRX8udCL7m6OTM7aUllHAg/8MkSWS+vR0RgCKPV74
         9eoCTT/HTWRESdBJCK0NGcoeVEcxeSyum72kQyh7/Kqm0eXkxhfqGwGMCiKCto6hZF
         q4MB0ajE0xUBceS8ZoiHLCNe/DAdueg9HWvwgq7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 35/44] ASoC: max9759: fix underflow in speaker_gain_control_put()
Date:   Mon,  7 Feb 2022 12:06:51 +0100
Message-Id: <20220207103754.299466569@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207103753.155627314@linuxfoundation.org>
References: <20220207103753.155627314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 4c907bcd9dcd233da6707059d777ab389dcbd964 upstream.

Check for negative values of "priv->gain" to prevent an out of bounds
access.  The concern is that these might come from the user via:
  -> snd_ctl_elem_write_user()
    -> snd_ctl_elem_write()
      -> kctl->put()

Fixes: fa8d915172b8 ("ASoC: max9759: Add Amplifier Driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20220119123101.GA9509@kili
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/max9759.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/soc/codecs/max9759.c
+++ b/sound/soc/codecs/max9759.c
@@ -64,7 +64,8 @@ static int speaker_gain_control_put(stru
 	struct snd_soc_component *c = snd_soc_kcontrol_component(kcontrol);
 	struct max9759 *priv = snd_soc_component_get_drvdata(c);
 
-	if (ucontrol->value.integer.value[0] > 3)
+	if (ucontrol->value.integer.value[0] < 0 ||
+	    ucontrol->value.integer.value[0] > 3)
 		return -EINVAL;
 
 	priv->gain = ucontrol->value.integer.value[0];


