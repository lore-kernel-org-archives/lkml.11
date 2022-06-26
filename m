Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD03C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jun 2022 20:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiFZUAw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jun 2022 16:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiFZUAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 16:00:50 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB888100A;
        Sun, 26 Jun 2022 13:00:49 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E30B12222E;
        Sun, 26 Jun 2022 22:00:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656273647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=E8hYzMsB2tJ/9iawmssvWEusTOMOiUToCGtjtR3G2us=;
        b=nNasie9tNttUIZx6n2lxsYDfswZCnAVn7XSSoOvtxiDmxQqLYrA7oitrSc/DxNn0AbGGIL
        ir3Hx3IpPv5u4qsITDlbC1LriIvurdkajBSLSsVgIuKV9zRVrSfJ1TvcJOZApK8GDF6jsC
        O1TLgkPhNX+F8rfRabd8ZMBLLyJJJ/8=
From:   Michael Walle <michael@walle.cc>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH] MAINTAINERS: nfc: drop Charles Gorand from NXP-NCI
Date:   Sun, 26 Jun 2022 22:00:39 +0200
Message-Id: <20220626200039.4062784-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mails to Charles get an auto reply, that he is no longer working at
Eff'Innov technologies. Drop the entry and mark the driver as orphaned.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c9187635801..e9a7e2d46a54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14471,9 +14471,8 @@ F:	Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
 F:	sound/soc/codecs/tfa989x.c
 
 NXP-NCI NFC DRIVER
-R:	Charles Gorand <charles.gorand@effinnov.com>
 L:	linux-nfc@lists.01.org (subscribers-only)
-S:	Supported
+S:	Orphan
 F:	Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
 F:	drivers/nfc/nxp-nci
 
-- 
2.30.2

