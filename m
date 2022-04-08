Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C55C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 18:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbiDHSl1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 14:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238810AbiDHSkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:40:25 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B77D37A02;
        Fri,  8 Apr 2022 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649443087;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ETNE/MKzh6NgI9nMo4TPL/Mpswq36h3lQFrpbRqGpA8=;
    b=nBfInLmJfWD0q0dyPG1nlJ4AfRr9tmR7DNBuTHR6s22q0TLXUnQWRW/MKJgPGNTwVa
    swcxOgQ+FtdRIWMm8X3QZ4BWy9fg7CQC9ZOp00mnAW0Bk/USwfLhlX31PQJ2Ja6ObMTQ
    7MOG8r3Pz6oSuXVKHayZeZuvO3bfkkuUwbfG04R3HVXEsWy9QtGrh4g4uV0lvgBxM4eM
    xMbPbeMNCl5eBmcKcZ/ePOvRVaOFpvGhFa+QKiKeDTQVnfe8c0oZMaBSnyJO15Vu75Ie
    MrOdvpdx2PJYKQ7iuK15I9Drg2Bhe/yUr9z3flE4MNz/wvgIse8AWbG3trVKlGAcDHBb
    ++uw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgdr/a"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy38Ic6so7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 8 Apr 2022 20:38:06 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 16/18] MIPS: DTS: CI20: fix /memory as reported by dtbscheck
Date:   Fri,  8 Apr 2022 20:37:59 +0200
Message-Id: <47ec9070f9bb5f525017668e8659e3fb0d592d0a.1649443080.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1649443080.git.hns@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/mips/boot/dts/ingenic/ci20.dtb: /: memory: False schema does not allow {device_type: [memory], reg: [[0, 268435456], [805306368, 805306368]]}
	From schema: python/site-packages/dtschema/schemas/root-node.yaml

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index c045c4f75895e..98f0a5ccbb4da 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -24,7 +24,7 @@ chosen {
 		stdout-path = &uart4;
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x10000000
 		       0x30000000 0x30000000>;
-- 
2.33.0

