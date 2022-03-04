Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AA4C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 09:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbiCDJ4A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 04:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbiCDJzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:55:53 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7744C3B034;
        Fri,  4 Mar 2022 01:55:06 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id F14D01F46484
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646387705;
        bh=5NfY/OJo8jqAhMoYvWFCELHiFzPVbvYo7BtN/XmNlig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DPnVo17AchbcX1D6AJFR5p0tyDHCjx99Esxk+83qV7geF2q0lS2SLQp7ICsRZEZHb
         2O1WBR/t6S1KKLt4z05Bb28WIBfhQLkaqE7d7FSJJP5BtOMQW+yspONmpoz6SD8kwa
         mbw2HB9CHwyYwB1oOGgzbCG6zcFRLNnJbX0PwQOgzpnpmErvJtdqwxwI16I3h3AZ3L
         rmurszwu/YQhiMy1sy/pekCLuaLantfHqFCUxXYe7+Z5Sr9M21Z8kzZN+gPe3m5eOE
         NlXdWk5FVwohdv9m1p957p3qNgPrubrrPSkLCjbwAPTKZmNozxAYZygTNxQUAN5VTT
         B2nv9/mnJNOqQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        matthias.bgg@gmail.com, ck.hu@mediatek.com, jitao.shi@mediatek.com,
        jason-jh.lin@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/3] dt-bindings: display: mediatek,mutex: Fix mediatek,gce-events type
Date:   Fri,  4 Mar 2022 10:54:56 +0100
Message-Id: <20220304095458.12409-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304095458.12409-1-angelogioacchino.delregno@collabora.com>
References: <20220304095458.12409-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mediatek,gce-events property needs as value an array of uint32
corresponding to the CMDQ events to listen to, and not any phandle.

Fixes: 4ed545e7d100 ("dt-bindings: display: mediatek: disp: split each block to individual yaml")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,mutex.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
index 6eca525eced0..842ba7b07a34 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
@@ -58,7 +58,7 @@ properties:
       The event id which is mapping to the specific hardware event signal
       to gce. The event id is defined in the gce header
       include/dt-bindings/gce/<chip>-gce.h of each chips.
-    $ref: /schemas/types.yaml#/definitions/phandle-array
+    $ref: /schemas/types.yaml#/definitions/uint32-array
 
 required:
   - compatible
-- 
2.35.1

