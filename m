Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD515C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 10:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbiEQKTG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 06:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344051AbiEQKSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:18:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5A34DF61;
        Tue, 17 May 2022 03:15:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E48A91F443AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652782519;
        bh=/ybxZchoatmstITV+vbv8WNDUQQ26yVZNo8ucCimxO0=;
        h=From:To:Cc:Subject:Date:From;
        b=Lat5GG2dhJTa99ZFin3wL/unvgIMD5hfspmaBRa8DIOeK40XUqL++OACY+H9T+M4K
         W2KVp2peUKJROJsBHpPClT2DiZ2v0d6lJWjPbqEl28kSS5s2FpTauqtmdpKkMAud5j
         XK5SzJ++3DY+1cNWfuBuBVVJPrLXakcuBSPgf7l/bWw9w0PiTsMK00ckQhC68ozM/c
         4hg47ViypSbwevMtvor9ucs3m0zt7dW9/JNl3lWZLciPZTWzncL28rY5JBVw0TClmj
         JHJQ6hOksP0XdMPEJg/OGmHWOIGT1ufiyxK3zCAWARnzK7TzelTp5wS/7g88NBFm52
         UB7cXDcQRDctg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, sboyd@kernel.org,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        wenst@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] dt-bindings: arm: MediaTek: Fix clock bindings
Date:   Tue, 17 May 2022 12:15:08 +0200
Message-Id: <20220517101514.21639-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Rob Herring's review [1] on my mt6795 clocks bindings patches, for
which I've used the already upstreamed ones as a base, it was found that
these bindings have some issues.
This series is addressing the issues that were found by Rob on my series,
which are present on all of the already merged bindings.

[1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220513165050.500831-5-angelogioacchino.delregno@collabora.com/#24859953

AngeloGioacchino Del Regno (6):
  dt-bindings: arm: mt8186-clock: Remove unnecessary 'items' and fix
    formatting
  dt-bindings: arm: mt8186: Set #clock-cells as required property
  dt-bindings: arm: mt8195-clock: Remove unnecessary 'items' and fix
    formatting
  dt-bindings: arm: mt8195: Set #clock-cells as required property
  dt-bindings: arm: mt8192-clock: Remove unnecessary 'items'
  dt-bindings: arm: mt8192: Set #clock-cells as required property

 .../arm/mediatek/mediatek,mt8186-clock.yaml   | 29 ++++-----
 .../mediatek/mediatek,mt8186-sys-clock.yaml   |  1 +
 .../arm/mediatek/mediatek,mt8192-clock.yaml   | 46 +++++++--------
 .../mediatek/mediatek,mt8192-sys-clock.yaml   |  1 +
 .../arm/mediatek/mediatek,mt8195-clock.yaml   | 59 ++++++++++---------
 .../mediatek/mediatek,mt8195-sys-clock.yaml   |  1 +
 6 files changed, 71 insertions(+), 66 deletions(-)

-- 
2.35.1

