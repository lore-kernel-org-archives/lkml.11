Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E51C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 13:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383857AbiDENbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 09:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345672AbiDEJWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:22:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65DE50E3B;
        Tue,  5 Apr 2022 02:11:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 730F261564;
        Tue,  5 Apr 2022 09:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810AFC385A0;
        Tue,  5 Apr 2022 09:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649149898;
        bh=v1luuvpj5UTKQupxrRu/rhsBPsNSE/Jx1YwX0tOiZ3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eN5/483ss73iMulDZANbPC39S4pTINezxuiXmTcOMYoVmeii4aCPkUBuaAFOFS/b3
         Nt5T4wya2ACv1RRNz7HX1KSp+E1B2mUepQei8x9769/WwYLPW8PBjqARCbuUk/o2zK
         Dhhf8GXPiV24csOgbp0y2Fx0+ytUTksTg/RSMN08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0843/1017] ASoC: amd: vangogh: fix uninitialized symbol warning in machine driver
Date:   Tue,  5 Apr 2022 09:29:16 +0200
Message-Id: <20220405070419.264098432@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

[ Upstream commit 6f989800639a7a29ab9a02e165b04dc144dd4f2b ]

Fixed below smatch static checker warning.
sound/soc/amd/vangogh/acp5x-mach.c:190 acp5x_cs35l41_hw_params()
error: uninitialized symbol 'ret'.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://lore.kernel.org/r/20220225193054.24916-4-Vijendar.Mukunda@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index 14cf325e4b23..5d7a17755fa7 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -165,6 +165,7 @@ static int acp5x_cs35l41_hw_params(struct snd_pcm_substream *substream,
 	unsigned int num_codecs = rtd->num_codecs;
 	unsigned int bclk_val;
 
+	ret = 0;
 	for (i = 0; i < num_codecs; i++) {
 		codec_dai = asoc_rtd_to_codec(rtd, i);
 		if ((strcmp(codec_dai->name, "spi-VLV1776:00") == 0) ||
-- 
2.34.1



