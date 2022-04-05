Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B59BC4707A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 08:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbiDEIn0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 04:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiDEIC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:02:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE83580E3;
        Tue,  5 Apr 2022 01:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B7C3B81B90;
        Tue,  5 Apr 2022 08:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FDCC340EE;
        Tue,  5 Apr 2022 08:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649145642;
        bh=gEk4RkBXFrR/2z0F7FTlWAGPlXH/JhpdoxTHvJntnts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vTy9t6kJ40JSyerDn/N630ym3xi/pJDjSrXEYgHju5u2SQREJKH2yk9jEDlVU0qRI
         RY3ZwZy1Leyhm5viUataDPn7fqZ9jYVFo98YhIqfbGbOpoPm9RjZcebzU3dPU56HSz
         sTfTB+kqQfUL0qh3HZGOUkEew62MlpB3GddNmZso=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Robert Foss <robert.foss@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0478/1126] drm/bridge: lt9611: Fix an error handling path in lt9611_probe()
Date:   Tue,  5 Apr 2022 09:20:25 +0200
Message-Id: <20220405070421.657785788@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 9987151a90567785beebcbd5c8ac58d05f254137 ]

If lt9611_audio_init() fails, some resources still need to be released
before returning an error code.

Add the missing goto the error handling path.

Fixes: 23278bf54afe ("drm/bridge: Introduce LT9611 DSI to HDMI bridge")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Robert Foss <robert.foss@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/9c20eb74d42f6d4128e58e3e46aa320482472b77.1643468761.git.christophe.jaillet@wanadoo.fr
Reviewed-by: Robert Foss <robert.foss@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index dafb1b47c15f..00597eb54661 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -1164,7 +1164,11 @@ static int lt9611_probe(struct i2c_client *client,
 
 	lt9611_enable_hpd_interrupts(lt9611);
 
-	return lt9611_audio_init(dev, lt9611);
+	ret = lt9611_audio_init(dev, lt9611);
+	if (ret)
+		goto err_remove_bridge;
+
+	return 0;
 
 err_remove_bridge:
 	drm_bridge_remove(&lt9611->bridge);
-- 
2.34.1



