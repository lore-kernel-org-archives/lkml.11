Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F354C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 01:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbiC1B0d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Mar 2022 21:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiC1B0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:26:32 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA8A933A22
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 18:24:51 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 28 Mar 2022 10:24:46 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 9A7692058B50;
        Mon, 28 Mar 2022 10:24:46 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 28 Mar 2022 10:24:46 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 1EC2BB62B7;
        Mon, 28 Mar 2022 10:24:45 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] dt-bindings: reset: Add parent "resets" property as optional
Date:   Mon, 28 Mar 2022 10:24:38 +0900
Message-Id: <1648430678-21631-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LD11 mio reset controller has a reset lines from system controller.
Add parent "resets" property to fix the following warning.

  uniphier-ld11-global.dt.yaml: reset: 'resets' does not match any of the regexes: 'pinctrl-[0-9]+'
      From schema: Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/reset/socionext,uniphier-reset.yaml    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml b/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
index 377a7d242323..f2a848c74f1e 100644
--- a/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
@@ -55,6 +55,9 @@ properties:
   "#reset-cells":
     const: 1
 
+  resets:
+    minItems: 1
+
 additionalProperties: false
 
 required:
-- 
2.25.1

