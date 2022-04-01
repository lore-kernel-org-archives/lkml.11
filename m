Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D66C433FE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 17:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349935AbiDAR1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 13:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347896AbiDAR1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:27:13 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEA61B84E9;
        Fri,  1 Apr 2022 10:25:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1648833903; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=esgORXHVrOpO3Czn0rAnrnYpKNIVn8d+JVM+nSW7CX8tILIHIED5l4FuP7ospr6tA8NbpYEIft8NNEBKuJbEF+b3/99Daoe9Uj5J0AonWMdS9KwCxHQ3fVg41uCPdS+TZExann8SvuZVhnCr0SroVvk+HChES5bM+8VnZOrE2Aw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1648833903; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=LSLBsr5LBW/jYP+/PifCznR2P9SDZUg0pGNhQd+caT8=; 
        b=UwA7u+xelYVZxgoMsekEHViOgGbaMaQ2LIjyCW2tlm74pKWe+eiZQ/rgiYlCcEsNm2XUWzPdN+xTmFuN+OT9aPITkIXemz1IdfjB6gyVPCd9+yy9fDTiell8OjxQ6WtPQ0KX0/vwqfsov4Hrt/7VwFmaJ7a+llYgxivcmTS1l4Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1648833903;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=LSLBsr5LBW/jYP+/PifCznR2P9SDZUg0pGNhQd+caT8=;
        b=bOwVgXZQHBHlnHyWgTKgrpSEclPxfCoMi2+SxB+yRZvbahSFp91ZGevsgbTjfmk4
        SCCzxcc6ywaPVRjO/5meSKO/v5l4m6orfK6JdPoP/agwBFLQdqNgO2vgvRtbh4MgVs8
        X3ogSFYCqjUzMLaIs9HGQkTk9W8iaFCbNuFjbIH8=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1648833900675282.76500670298753; Fri, 1 Apr 2022 10:25:00 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: [PATCH 2/2] dt-bindings: arm: bcm: add bindings for Asus RT-AC88U
Date:   Fri,  1 Apr 2022 20:24:28 +0300
Message-Id: <20220401172427.2806-2-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401172427.2806-1-arinc.unal@arinc9.com>
References: <20220401172427.2806-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Asus RT-AC88U under BCM47094 based boards.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
index 8a97ee048053..8b7e87fb6c34 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
@@ -64,6 +64,7 @@ properties:
       - description: BCM47094 based boards
         items:
           - enum:
+              - asus,rt-ac88u
               - dlink,dir-885l
               - linksys,panamera
               - luxul,abr-4500-v1
-- 
2.25.1

