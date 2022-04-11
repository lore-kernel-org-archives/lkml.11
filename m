Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4215C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 02:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243575AbiDKCaT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Apr 2022 22:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiDKCaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 22:30:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956843878B;
        Sun, 10 Apr 2022 19:28:04 -0700 (PDT)
X-UUID: 5306de0df05e4ad4af52df986cdbefa8-20220411
X-UUID: 5306de0df05e4ad4af52df986cdbefa8-20220411
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 918196037; Mon, 11 Apr 2022 10:27:57 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 11 Apr 2022 10:27:56 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 11 Apr
 2022 10:27:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Apr 2022 10:27:55 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Henry Chen <henryc.chen@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <ryder.lee@kernel.org>, <wenst@chromium.org>,
        <chunfeng.yun@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v14 1/2] dt-bindings: pwrap: mediatek: Update pwrap document for mt8195
Date:   Mon, 11 Apr 2022 10:27:23 +0800
Message-ID: <20220411022724.11005-2-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20220411022724.11005-1-tinghan.shen@mediatek.com>
References: <20220411022724.11005-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Zhiyong.Tao" <zhiyong.tao@mediatek.com>

Update pwrap document description for mt8195

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 .../devicetree/bindings/soc/mediatek/pwrap.txt         | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
index 214a34633824..0581dbda4828 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
@@ -31,20 +31,20 @@ Required properties in pwrap device node.
 	"mediatek,mt8195-pwrap" for MT8195 SoCs
 	"mediatek,mt8516-pwrap" for MT8516 SoCs
 - interrupts: IRQ for pwrap in SOC
-- reg-names: Must include the following entries:
+- reg-names: "pwrap" is required; "pwrap-bridge" is optional.
   "pwrap": Main registers base
   "pwrap-bridge": bridge base (IP Pairing)
 - reg: Must contain an entry for each entry in reg-names.
-- reset-names: Must include the following entries:
-  "pwrap"
-  "pwrap-bridge" (IP Pairing)
-- resets: Must contain an entry for each entry in reset-names.
 - clock-names: Must include the following entries:
   "spi": SPI bus clock
   "wrap": Main module clock
 - clocks: Must contain an entry for each entry in clock-names.
 
 Optional properities:
+- reset-names: Some SoCs include the following entries:
+  "pwrap"
+  "pwrap-bridge" (IP Pairing)
+- resets: Must contain an entry for each entry in reset-names.
 - pmic: Using either MediaTek PMIC MFD as the child device of pwrap
   See the following for child node definitions:
   Documentation/devicetree/bindings/mfd/mt6397.txt
-- 
2.18.0

