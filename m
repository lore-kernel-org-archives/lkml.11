Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E596AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 12:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347646AbiETMqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 08:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240986AbiETMq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:46:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3390C5AED3;
        Fri, 20 May 2022 05:46:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 702821F462B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653050785;
        bh=wjZR/q/Koar3Z14wlMyDBlnpLWB8CYxTpYy9Z0nOJxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTvCEyHrN1lzQ6fX3qi9RxhiLsck9Z9hyq/ApXaSpRPfIYGXIfRCFEqiZ195msond
         agxRq9XNH4Pl2hfwhNEGy2gLRNrrd8EGtaep0k6dioRif+6wl6xmRDWRHq41dLs9kt
         WN5o05Mp8dTx3Lv8sUH0l/t0E1PP+8hwgmI9ik0W/uOItXeIWO8Th8d64gsiyA2w7e
         +wPFYrToKGWj0PlKP/LAsGITNp5ZkKGEs5k950LkTtrK9R7ej6CoYCVw6ONbDlljZ9
         cqyXMiO23sPvt3LpGKYkcRC8++CWuz6GiwUBRTnKIrpDK64Vx8yXZRZMtz9lG4doWB
         6D1kgH8bKSwOQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        johnson.wang@mediatek.com, hsin-hsiung.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: mfd: mt6397: Add compatibles for MT6331 RTC and keys
Date:   Fri, 20 May 2022 14:46:16 +0200
Message-Id: <20220520124617.228808-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520124617.228808-1-angelogioacchino.delregno@collabora.com>
References: <20220520124617.228808-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT6331 is a multifunction device, providing RTC, keys and more: add
the necessary compatibles to start implementing the basics.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/mfd/mt6397.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index d59063503b0d..2a9533c47365 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -30,6 +30,7 @@ Optional subnodes:
 - rtc
 	Required properties: Should be one of follows
 		- compatible: "mediatek,mt6323-rtc"
+		- compatible: "mediatek,mt6331-rtc"
 		- compatible: "mediatek,mt6358-rtc"
 		- compatible: "mediatek,mt6397-rtc"
 	For details, see ../rtc/rtc-mt6397.txt
@@ -55,6 +56,7 @@ Optional subnodes:
 - keys
 	Required properties:
 		- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
+			      or "mediatek,mt6331-keys"
 	see ../input/mtk-pmic-keys.txt
 
 - power-controller
-- 
2.35.1

