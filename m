Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49809C43217
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 18:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbiDHSka (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 14:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiDHSkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:40:19 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63026177;
        Fri,  8 Apr 2022 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649443083;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=SITN2026XDSoy6o6EydmGwceU4pjnRlT4hLR9OsNWOE=;
    b=WMS3M7qtR9WR6EJQf0b4yAFIO57RuI7Ccfhe3j7sgxMmpnhzmt/eL9hPb3QVskI2pJ
    ZA/vsbc4R7VvLnPrZcurUKtg0rIDiGejbX/j28eUbic20wTbKvzjQMQ4b1KnOi6Il28y
    5W+3Vg1flF5g1VVTlK9qI9d/uhn7sgHKJmkrVoJ1BHKvJ5LkDdNXbwcMOtBy5xt/RoiW
    pCeg2owphmtpGRelCUVIuFC3vDJ+hU2nsfz+6pgV4KMRF0Gf0+CQAObSjvCYxqcCCHav
    a7AXmje4JYRi7hbS6dRrbPKusuRlsIqmdQl/7nzImwQoloJGmOHuK0vjr1Fa6SeItwnt
    GzJw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgdr/a"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy38Ic3snv
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 8 Apr 2022 20:38:03 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 04/18] MIPS: DTS: jz4780: fix ost timer as reported by dtbscheck
Date:   Fri,  8 Apr 2022 20:37:47 +0200
Message-Id: <2b5e2b5b9b1c435043f3eadf4919562dfa9dba70.1649443080.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1649443080.git.hns@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/mips/boot/dts/ingenic/ci20.dtb: timer@10002000: timer@e0:compatible: 'oneOf' conditional failed, one must be fixed:
	['ingenic,jz4780-ost', 'ingenic,jz4770-ost'] is too long
	'ingenic,jz4780-ost' is not one of ['ingenic,jz4725b-ost', 'ingenic,jz4760b-ost']
	'ingenic,jz4760-ost' was expected
	'ingenic,jz4725b-ost' was expected
	'ingenic,jz4760b-ost' was expected
	From schema: Documentation/devicetree/bindings/timer/ingenic,tcu.yaml

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 6027f14c393e3..5f44cf004d473 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -134,7 +134,7 @@ pwm: pwm@40 {
 		};
 
 		ost: timer@e0 {
-			compatible = "ingenic,jz4780-ost", "ingenic,jz4770-ost";
+			compatible = "ingenic,jz4780-ost", "ingenic,jz4760b-ost";
 			reg = <0xe0 0x20>;
 
 			clocks = <&tcu TCU_CLK_OST>;
-- 
2.33.0

