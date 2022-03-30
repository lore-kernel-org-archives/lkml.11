Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5DBC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 05:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238349AbiC3FNO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242855AbiC3FNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:13:07 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA42C6972D;
        Tue, 29 Mar 2022 22:11:22 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Mar 2022 14:11:22 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 3D0002058443;
        Wed, 30 Mar 2022 14:11:22 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 30 Mar 2022 14:11:22 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id B622BB62B7;
        Wed, 30 Mar 2022 14:11:21 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2] dt-bindings: reset: Add parent "resets" property as optional
Date:   Wed, 30 Mar 2022 14:11:18 +0900
Message-Id: <1648617078-8312-1-git-send-email-hayashi.kunihiko@socionext.com>
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

Changes since v1:
- Use maxItems for a single reset

 .../devicetree/bindings/reset/socionext,uniphier-reset.yaml    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml b/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
index 377a7d242323..6566804ec567 100644
--- a/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
@@ -55,6 +55,9 @@ properties:
   "#reset-cells":
     const: 1
 
+  resets:
+    maxItems: 1
+
 additionalProperties: false
 
 required:
-- 
2.25.1

