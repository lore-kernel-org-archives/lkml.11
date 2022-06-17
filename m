Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A35C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 22:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378430AbiFQW3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 18:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245202AbiFQW33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:29:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79F26163E;
        Fri, 17 Jun 2022 15:29:28 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1307766017C8;
        Fri, 17 Jun 2022 23:29:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655504967;
        bh=oVlNccAWXofCU1rOW8Wgk44NVgnvXfyJSycx5cQ756M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L2L0Z+39SRcUlLM8Q14KmtnBdkik0nW0Xwl/uqTRuD/oODMJYjJKW/aN0+vbwH+At
         MJFqWrpxklyeNec+W4YpaPJ3pr1+iQHLR+/QsTWniE8s9GimUvlzJx+16I9S2BEBVH
         Qy/zRTjf8DqVrWp8aZ8r/DGwwXmbZPZaqoBRhDLrGyzkwANIwf8RymB7wJipZhcAsP
         xasmWbZiOX/ADwadbDmbfRgQWNIGmc+B4O+ZFUs7uza3YtLQ1GHcC9mMaBZ9tDrAbF
         aASUpk76bW6CDoerCKvewSf3E4VZgHmZLNPF9ipFi7824O9Ztr9aBzXLjrO7mzibri
         IbbLLf9cJnuwg==
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
Subject: [PATCH 2/3] dt-bindings: usb: mtk-xhci: Allow middle optional clocks to be missing
Date:   Fri, 17 Jun 2022 18:29:15 -0400
Message-Id: <20220617222916.2435618-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617222916.2435618-1-nfraprado@collabora.com>
References: <20220617222916.2435618-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current clock list in the binding doesn't allow for one of the
optional clocks to be missing and a subsequent clock to be present. An
example where this is an issue is in mt8192.dtsi, which has "sys_ck",
"ref_ck", "xhci_ck" and would cause dtbs_check warnings.

Change the clock list in a way that allows the middle optional clocks to
be missing, while still guaranteeing a fixed order. The "ref_ck" is kept
as a const even though it is optional for simplicity, since it is
present in all current dts files.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml       | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 63cbc2b62d18..99a1b233ec90 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -80,8 +80,13 @@ properties:
     items:
       - const: sys_ck  # required, the following ones are optional
       - const: ref_ck
-      - const: mcu_ck
-      - const: dma_ck
+      - enum:
+          - mcu_ck
+          - dma_ck
+          - xhci_ck
+      - enum:
+          - dma_ck
+          - xhci_ck
       - const: xhci_ck
 
   assigned-clocks:
-- 
2.36.1

