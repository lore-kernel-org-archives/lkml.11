Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7D6C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 12:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351390AbiDEMWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 08:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245013AbiDEIxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:53:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA902DC;
        Tue,  5 Apr 2022 01:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 272BF614FD;
        Tue,  5 Apr 2022 08:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A24BC385A3;
        Tue,  5 Apr 2022 08:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148562;
        bh=F2QB7kb0dawbt9xWarnKA2zPFQV/q0hPhE2v5d7TAd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCVzFuxy+LbiIr3bUI3+wUkJbMsL/J1tNP4fVw3LmPwcQ0MjnESUro9MJf1F1qW+0
         aGWIOLwqPGusf2SC+TUeC8ORfCRMTK2OYAhnmE/3cSx4NfBYu28Z8YcMOj8B5eWWH/
         IafUx/8PTjs1Y2BrM47tIIQiPIzJRVAfP8gUfCFA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0401/1017] drm/bridge: Fix free wrong object in sii8620_init_rcp_input_dev
Date:   Tue,  5 Apr 2022 09:21:54 +0200
Message-Id: <20220405070406.189065538@linuxfoundation.org>
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

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 7c442e76c06cb1bef16a6c523487438175584eea ]

rc_dev is allocated by rc_allocate_device(), and doesn't assigned to
ctx->rc_dev before calling  rc_free_device(ctx->rc_dev).
So it should call rc_free_device(rc_dev);

Fixes: e25f1f7c94e1 ("drm/bridge/sii8620: add remote control support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
Signed-off-by: Robert Foss <robert.foss@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20211227092522.21755-1-linmq006@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/sil-sii8620.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 843265d7f1b1..ec7745c31da0 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -2120,7 +2120,7 @@ static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
 	if (ret) {
 		dev_err(ctx->dev, "Failed to register RC device\n");
 		ctx->error = ret;
-		rc_free_device(ctx->rc_dev);
+		rc_free_device(rc_dev);
 		return;
 	}
 	ctx->rc_dev = rc_dev;
-- 
2.34.1



