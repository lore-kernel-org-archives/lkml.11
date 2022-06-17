Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BD1C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 22:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbiFQW3h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 18:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245162AbiFQW33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:29:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C2461634;
        Fri, 17 Jun 2022 15:29:26 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6BDB166017A7;
        Fri, 17 Jun 2022 23:29:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655504965;
        bh=2DDhEoaBfgt4wsHVlUpB8ibamMdj8d9hk/UycwO7uRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oC2rTTJGncm3bu3b6euHGrSLiC6DZw7mLdunOZZq1rYYiX71DAAW1dA0oBmrd4IeZ
         pGy/EU2lS44XbWAQFEUwnJxYn9UD7cd+kg/NpOht8vGR/qaix7M6Km1Tg2vtqVGCX3
         V8HgGeAMMYfaUwCbtV2YRE79SPT+sQM2DJwm5uafklRFBD5KstnLCXB+BBsQbdJCZf
         EFED2M0LxmElwxLvwZynXfDD9LqOCcaPDjzjuHA0W6h9Ft+9OV9TatSO3uDn+5xQ5f
         nAnuxHfrtxB2Mwclsg07Sz8eVktoZ+KVTrZnfWHmUazgTU1vWYlrqUAxdgjr3pFcW4
         GDzTc8hs+yb2A==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: usb: mtk-xhci: Allow wakeup interrupt-names to be optional
Date:   Fri, 17 Jun 2022 18:29:14 -0400
Message-Id: <20220617222916.2435618-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617222916.2435618-1-nfraprado@collabora.com>
References: <20220617222916.2435618-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing "minItems: 1" to the interrupt-names property to allow the
second interrupt-names, "wakeup", to be optional.

Fixes: fe8e488058c4 ("dt-bindings: usb: mtk-xhci: add wakeup interrupt")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 892718459d25..63cbc2b62d18 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -57,6 +57,7 @@ properties:
       - description: optional, wakeup interrupt used to support runtime PM
 
   interrupt-names:
+    minItems: 1
     items:
       - const: host
       - const: wakeup
-- 
2.36.1

