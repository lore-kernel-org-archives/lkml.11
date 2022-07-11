Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF342C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 12:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiGKMZL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 08:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiGKMZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:25:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D58145046;
        Mon, 11 Jul 2022 05:25:09 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2614266019FC;
        Mon, 11 Jul 2022 13:25:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657542307;
        bh=NaK1O1ALqqqYyyotd1Wb4JqV/Lt7Z/P9Hh/CnZJsMbY=;
        h=From:To:Cc:Subject:Date:From;
        b=Nr8dgLy3A9CaE1HpvbyhJOk8spxDst5WhwkXDS+mRbP56eiZukAsYRnxb1Vkj0qtE
         XulesiWfB1A1KWqjMSfYClDGjD5cv9tbQm27GccCdtkKE+a4AHTqQ7NoLa5l44pc2O
         K5rrxA1lWeXZQKD1KodjHQnsZtfaHlm5mL6Y1ObD3M7c2It9qnc3GFzQf+8PqbMNsr
         xRJhSNQimQDzkk7qJC3+kn3eM2UhtuLx2utEBPPZorA5/fVF6GIzPMAqWcqHI0dt7A
         EFrCqk1TO7kOE3KvgZDrXhsIFg+xLbEfM5RYU21uRWpaOYQ08ZlIETS6tc3Cq+y2vN
         97holStZYfZBQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, weiyi.lu@mediatek.com,
        mbrugger@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
Subject: [PATCH 0/3] mtk-pm-domains: Use 'syscon' phandle for SCPSYS regmap
Date:   Mon, 11 Jul 2022 14:25:00 +0200
Message-Id: <20220711122503.286743-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After an attempt by MediaTek to upstream MT8186, MT8192 and MT8195
devicetrees, Krzysztof brought up a discussion in which it emerged
that the usage of a 'simple-mfd' device is not an optimal choice for
a number of reasons [1].

Reading that made me just write this simple code to stop nesting the
SPM power-controller node inside of a "syscon", "simple-mfd" node,
also allowing to move it outside of the main soc bus.

[1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220704100028.19932-9-tinghan.shen@mediatek.com/

AngeloGioacchino Del Regno (3):
  dt-bindings: power: mediatek: Document phandle to SCPSYS syscon node
  dt-bindings: power: mediatek: Update example to use phandle to syscon
  soc: mediatek: pm-domains: Grab SCPSYS registers from phandle to
    syscon

 .../power/mediatek,power-controller.yaml      | 130 +++++++++---------
 drivers/soc/mediatek/mtk-pm-domains.c         |  16 ++-
 2 files changed, 77 insertions(+), 69 deletions(-)

-- 
2.35.1

