Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8742BC3527C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 11:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384195AbiBGLZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 06:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382541AbiBGLTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:19:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77DAC043181;
        Mon,  7 Feb 2022 03:19:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3BD4B80EC3;
        Mon,  7 Feb 2022 11:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA96C004E1;
        Mon,  7 Feb 2022 11:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644232776;
        bh=2sGDfbpEYoz/FUbxO44JrioVvH7wDLjr+zfw4fDKx1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QMO9O2tSmbcjqUeLlOU/vm7eClpiYLK/I2RLttBdcji8TaBJJDM8nMEZcjYkPTxOm
         aPBX8nqT36hOK2iksgJHVt0P/jMtuznP+rMCEd4o62wMShLyuOA34FfO5CCXIxFizs
         vS2lhHFg5lL1pemlw5Rt9PQyXhSuwG0y0G4xpqXA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 04/44] ASoC: ops: Reject out of bounds values in snd_soc_put_xr_sx()
Date:   Mon,  7 Feb 2022 12:06:20 +0100
Message-Id: <20220207103753.305011309@linuxfoundation.org>
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

From: Mark Brown <broonie@kernel.org>

commit 4cf28e9ae6e2e11a044be1bcbcfa1b0d8675fe4d upstream.

We don't currently validate that the values being set are within the range
we advertised to userspace as being valid, do so and reject any values
that are out of range.

Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20220124153253.3548853-4-broonie@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/soc-ops.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -910,6 +910,8 @@ int snd_soc_put_xr_sx(struct snd_kcontro
 	unsigned int i, regval, regmask;
 	int err;
 
+	if (val < mc->min || val > mc->max)
+		return -EINVAL;
 	if (invert)
 		val = max - val;
 	val &= mask;


