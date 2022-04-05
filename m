Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1514FC433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 08:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbiDEI30 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 04:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbiDEIAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:00:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A55A49243;
        Tue,  5 Apr 2022 00:58:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3682C61545;
        Tue,  5 Apr 2022 07:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0DFC3410F;
        Tue,  5 Apr 2022 07:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649145534;
        bh=mMs8cEwxxXca6Fv/Ju+e15x+v/0X/GOCyC5VUwCK5YA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pBWNBlqI+J/gtxITJDyCgpV2X/1dcjG/KwY8FoWsauC9cFk3cbDG/Uyr6qHOcBuca
         p7z/r6ogqCtWlGmj4wpwUMRVYo2jMjDRw02j6jge2hrMmLh/OM/PtqTR4zrJZNLIB/
         C6PjTWvIguou0tsmvjjwNgHxB0tEo8kDOVo12Seg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0441/1126] drm/selftests/test-drm_dp_mst_helper: Fix memory leak in sideband_msg_req_encode_decode
Date:   Tue,  5 Apr 2022 09:19:48 +0200
Message-Id: <20220405070420.567913454@linuxfoundation.org>
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

From: José Expósito <jose.exposito89@gmail.com>

[ Upstream commit ba3a5ddcf1e5df31f2291006d5297ca62035584f ]

Avoid leaking the "out" variable if it is not possible to allocate
the "txmsg" variable.

Fixes: 09234b88ef55 ("drm/selftests/test-drm_dp_mst_helper: Move 'sideband_msg_req_encode_decode' onto the heap")
Addresses-Coverity-ID: 1475685 ("Resource leak")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20220108165812.46797-1-jose.exposito89@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
index 6b4759ed6bfd..c491429f1a02 100644
--- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
+++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
@@ -131,8 +131,10 @@ sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
 		return false;
 
 	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
-	if (!txmsg)
+	if (!txmsg) {
+		kfree(out);
 		return false;
+	}
 
 	drm_dp_encode_sideband_req(in, txmsg);
 	ret = drm_dp_decode_sideband_req(txmsg, out);
-- 
2.34.1



