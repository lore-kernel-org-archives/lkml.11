Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EEDC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 May 2022 14:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbiECOSW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 10:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbiECOST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:18:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3049F1A832;
        Tue,  3 May 2022 07:14:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3E21A1F43427
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651587286;
        bh=/OJe0zKHyv0s6VYqal7THzQhT/MkDhaWtLskuPgNQYY=;
        h=From:To:Cc:Subject:Date:From;
        b=Jidvx/3OhGacb9QpqW4aIYfGTP8NjD8JyWTMWQsQvcUsPjZJKC0ojwAWYZG+6YzFW
         1Sqs9Kbc4Buh6ep+gpa6jxWIXYOwNGow50kkLn34AIeq7Q7sE0fWtzFym1xuhwmPd6
         f09QFD8trUBsYM9cY019MilUJ3S7qB7ecSHAW99Or3rPvcBtbYT3kvC3Ho/o3yA9ku
         I3GtKnaDAgAY4I1guYcsho3TwQqIJN1dNbao5a+mf1vG7psdes6MadYsiCryyVttuJ
         eUH29CcLhEz3zoBUvYQy/yKOxwxDIgSdjoWDgti8xkGTU7khuGBpFx6oaC8VjFwEcU
         d3UNdpsuJIGFw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        matthias.bgg@gmail.com, chun-jie.chen@mediatek.com,
        angelogioacchino.delregno@collabora.com, weiyi.lu@mediatek.com,
        mbrugger@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
Subject: [PATCH v2 0/2] MediaTek Helio X10 MT6795 - power domains
Date:   Tue,  3 May 2022 16:14:39 +0200
Message-Id: <20220503141441.125852-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to give some love to the apparently forgotten MT6795 SoC,
I am upstreaming more components that are necessary to support platforms
powered by this one apart from a simple boot to serial console.

This series introduces support for the MTCMOS power domains found on
the Helio X10.

Tested on a Sony Xperia M5 (codename "Holly") smartphone.

Changes in v2:
 - Changed license header for mt6795-power.h binding as per
   Krzysztof's review.

AngeloGioacchino Del Regno (2):
  dt-bindings: power: Add MediaTek Helio X10 MT6795 power domains
  soc: mediatek: pm-domains: Add support for Helio X10 MT6795

 .../power/mediatek,power-controller.yaml      |   2 +
 drivers/soc/mediatek/mt6795-pm-domains.h      | 112 ++++++++++++++++++
 drivers/soc/mediatek/mtk-pm-domains.c         |   5 +
 include/dt-bindings/power/mt6795-power.h      |  16 +++
 4 files changed, 135 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt6795-pm-domains.h
 create mode 100644 include/dt-bindings/power/mt6795-power.h

-- 
2.35.1

