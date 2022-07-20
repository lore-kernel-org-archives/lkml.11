Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52FBC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 19:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbiGTTMG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 15:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiGTTME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:12:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4617564F3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:12:03 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6D68B6601A9E;
        Wed, 20 Jul 2022 20:12:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658344322;
        bh=kkQwd3wxUQX7bdNBjpHuQW+YDbc3LB9yz4gjn7bhhVI=;
        h=From:To:Cc:Subject:Date:From;
        b=ji34Swd4CqeHPVvpm1X+yU2XBin6/Wr7YMAsscJLyzrD4WwUqGdMf1XV26jPuByh+
         Tcnczy7G5BKdVDKontExvx5FngniqAusjeZr5bhwURoGfO1ji4DrLhWZ14C0BiOrPp
         QRIgfQzQS6yA+ZdxSGtZ04FqK/EIfPy4KYS26QFLQp+d5HxdcIfPybHskLF/yuOBU5
         aEdxKe+OcaIGwBitla8qIacojqOOOHxRZS8XNuVg564A4UFlLRjcpKCuM7Qtvoa6Xu
         y4bIKjYVHmTGyerM/ZkaotZlL/FS/fpOhZENWN5dPBu4+ex0dHyb2BheP+ylu6G586
         tOwsHL9OOWJ8w==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/panel-edp: Add panel entry for B120XAN01.0
Date:   Wed, 20 Jul 2022 15:11:58 -0400
Message-Id: <20220720191158.1590833-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add panel identification entry for the AUO B120XAN01.0 (product ID:
0x1062) panel.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
v1: https://lore.kernel.org/all/20220719203857.1488831-3-nfraprado@collabora.com

Changes in v2:
- Move entry to the top so it respects the sorting

 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index b3536d8600f4..e85d0c56f4a5 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1876,6 +1876,7 @@ static const struct panel_delay delay_200_500_e200 = {
  * Sort first by vendor, then by product ID.
  */
 static const struct edp_panel_entry edp_panels[] = {
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1062, &delay_200_500_e50, "B120XAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),
-- 
2.37.0

