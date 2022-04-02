Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF954C4332F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Apr 2022 20:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354391AbiDBUtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Apr 2022 16:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354122AbiDBUtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 16:49:21 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCF48C7F3;
        Sat,  2 Apr 2022 13:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1648932425; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=JjRgk/PQFnoZy8qWV7jAR70UHNZHxzpAduYMhMHABMF6yi2r7HtzTwj+OUMyU+nnBIEeXJrYhvsK6LgCukR+ptl1//Krr+xHMJlndYtwnI5GLabLTNZRbUIOp9oA6lqmjzSHZm1ppwZPl4GP4cQ+99FXhf7OM5PrTfY4jLEjdcU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1648932425; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=1BNa8g2eyHMhOtmtw4ZLZSV0NQRCqOz9ICe0K36j0zs=; 
        b=avSr/pv3lWKstncDiTrKB2+XqQYnk5334uUR2wjyfQcl6o8MNT+TyrWNYK4L0ZuoZuB7mzm3VWAr6KItt50BaKDR6slJ9lVVTXOCdcq+P6W0nDiPRw6DLHd0nQCl3EzdPPzvHFMuYasLgHRm7hudzeREBOpl3BBLQzH24Pp4i6A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1648932425;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=1BNa8g2eyHMhOtmtw4ZLZSV0NQRCqOz9ICe0K36j0zs=;
        b=B/H5IhRsjYt3xuaNagVgl37TCb5M4dL3UeXE9DNTb8czYkj0+TxTGKZ5CQdNymnT
        QjWkydje8wjY6QXg1iNHtZVL/5q2yN/zf7Q58NWA2TDIXBB6JEJ2J8Shgk16tgCIEjW
        nPdVJy2Zr88Rt/0+mQfHd8Pxpe2K4Mf3h8sTqYL4=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1648932422003757.9835180314585; Sat, 2 Apr 2022 13:47:02 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: [PATCH v2 2/4] dt-bindings: arm: bcm: create new description for BCM53016
Date:   Sat,  2 Apr 2022 23:46:20 +0300
Message-Id: <20220402204622.3360-2-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402204622.3360-1-arinc.unal@arinc9.com>
References: <20220402204622.3360-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new description for BCM53016 and move Meraki MR32 under it.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../devicetree/bindings/arm/bcm/brcm,bcm4708.yaml          | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
index f0e2a20d22d5..8a97ee048053 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
@@ -83,8 +83,13 @@ properties:
               - brcm,bcm953012er
               - brcm,bcm953012hr
               - brcm,bcm953012k
-              - meraki,mr32
           - const: brcm,bcm53012
+          - const: brcm,bcm4708
+
+      - description: BCM53016 based boards
+        items:
+          - enum:
+              - meraki,mr32
           - const: brcm,bcm53016
           - const: brcm,bcm4708
 
-- 
2.25.1

