Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C737BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 05:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242898AbiC3FWo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiC3FWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:22:40 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11F09137F65;
        Tue, 29 Mar 2022 22:20:54 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Mar 2022 14:20:54 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 65AE42058443;
        Wed, 30 Mar 2022 14:20:54 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 30 Mar 2022 14:20:54 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id ACB3EB62B7;
        Wed, 30 Mar 2022 14:20:53 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 0/5] dt-bindings: phy: Fix uniphier descriptions
Date:   Wed, 30 Mar 2022 14:20:46 +0900
Message-Id: <1648617651-9004-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes dt-schema descriptions for all PHYs implemented in
UniPhier SoCs.

Changes since v1:
- Add "Reviewed-by:" line to patch 1 and 2
- Remove result messages about unpublished nodes in patch 3
- Add patch 4 for fixing incorrect properties in ahci-phy
- Add patch 5 to rewrite properties using allOf-if-then in all phys

Kunihiko Hayashi (5):
  dt-bindings: phy: uniphier-usb2: Add vbus-supply
  dt-bindings: phy: uniphier-usb3ss: Treat vbus-supply as optional
  dt-bindings: phy: uniphier-ahci: Fix missing reset-names
  dt-bindings: phy: uniphier-usb3hs: Fix incorrect clock-names and
    reset-names
  dt-bindings: phy: uniphier: Clean up clock-names and reset-names using
    compatible string

 .../phy/socionext,uniphier-ahci-phy.yaml      | 74 ++++++++++++-----
 .../phy/socionext,uniphier-pcie-phy.yaml      | 37 ++++++---
 .../phy/socionext,uniphier-usb2-phy.yaml      |  3 +
 .../phy/socionext,uniphier-usb3hs-phy.yaml    | 71 ++++++++++++----
 .../phy/socionext,uniphier-usb3ss-phy.yaml    | 80 ++++++++++++++-----
 5 files changed, 194 insertions(+), 71 deletions(-)

-- 
2.25.1

