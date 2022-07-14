Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA349C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 04:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiGNEir (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 00:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiGNEh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:37:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947B83DBFA;
        Wed, 13 Jul 2022 21:27:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF662B82372;
        Thu, 14 Jul 2022 04:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72259C3411C;
        Thu, 14 Jul 2022 04:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657772830;
        bh=iE5yQa2DJlA8HOw9QQ5apeEo47lHRTArshMl4xWFAGI=;
        h=From:To:Cc:Subject:Date:From;
        b=kMuFYAGbFPfW5H4Jg9m2bgovBuRotrdRroqC/XUZzW8U75j95hkrx3yvvxCLYysn3
         jR9f99Q3oxjvXvpPWXDg+SCSaP9jH33rHmoeeg3UXOBrtta716yI/uaOiDVeuCyok+
         Sh2Q7O2wAoW0vpkq/jaJcUaWpxrqqtg6QlKbZMiZwlkX39lHJmUD5rBrkGb4wraD+p
         Q1MxwIedGPdlGNuM0QhA70IKQiMTOMd80DSxksL4jfEwNogTI7KV8NnTcSjBilZzgo
         OPmvbN8yyXZAtwpU8sRWw2pXsq8dbX+bkF+no4VuRwMrLyyNaFSUOdrIodh689X5c2
         DIrRyifqsnn/Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Sasha Levin <sashal@kernel.org>,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.9 1/4] ASoC: ops: Fix off by one in range control validation
Date:   Thu, 14 Jul 2022 00:27:04 -0400
Message-Id: <20220714042707.282675-1-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 5871321fb4558c55bf9567052b618ff0be6b975e ]

We currently report that range controls accept a range of 0..(max-min) but
accept writes in the range 0..(max-min+1). Remove that extra +1.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20220604105246.4055214-1-broonie@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 90ba5521c189..4fda8c24be29 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -535,7 +535,7 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 		return -EINVAL;
 	if (mc->platform_max && tmp > mc->platform_max)
 		return -EINVAL;
-	if (tmp > mc->max - mc->min + 1)
+	if (tmp > mc->max - mc->min)
 		return -EINVAL;
 
 	if (invert)
@@ -556,7 +556,7 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 			return -EINVAL;
 		if (mc->platform_max && tmp > mc->platform_max)
 			return -EINVAL;
-		if (tmp > mc->max - mc->min + 1)
+		if (tmp > mc->max - mc->min)
 			return -EINVAL;
 
 		if (invert)
-- 
2.35.1

