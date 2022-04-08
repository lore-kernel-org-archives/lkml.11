Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F949C433FE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 18:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbiDHSlV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 14:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbiDHSkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:40:33 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7607D6307;
        Fri,  8 Apr 2022 11:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649443086;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZPkdrHl7pnEG/Jm43DYMpPO25252qRF02JzIbYPQX9U=;
    b=hCZdKnNiFtpIq0vYy0/7oNfa7Wq7Q7+UMXVU9x03cJxZmMGalUe91akaHB/KlefLDO
    lwrKMNPqiwqY2z0E8x4UqpfM8twGWD/Ypyik7JlydI7/ELdVtwKs/Cc8d9bBwkMDjuph
    UUyskIFLhXh7+wQVJTxDWovHJBBeHhIBDr5/z48itxS5jY75iaLLIDmtZyOH+PVaTliw
    vfdHqllDv6pJEMSHYv8mxK2Ti5p5EeM7fe4rKKyjcaRqmeWOXzcrOjyjGggJQ2F6rHTF
    z+cwELzp0oRzx6lImMOqy1PX7LhOdbsNhtBtgJEXeA0KRERupyLw7tnSY+sQZMsq+Dab
    jb2A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgdr/a"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy38Ic6so5
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
Subject: [PATCH 14/18] MIPS: DTS: CI20: add missing model as reported by dtbscheck
Date:   Fri,  8 Apr 2022 20:37:57 +0200
Message-Id: <3de64cf38ab3345745a5a7e53600c93e0679fbf8.1649443080.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1649443080.git.hns@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/mips/boot/dts/ingenic/ci20.dtb: /: 'model' is a required property
	From schema: dtschema/schemas/root-node.yaml

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index ab6e3dc0bc1d0..cb5257d32b55e 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -11,6 +11,8 @@
 / {
 	compatible = "img,ci20", "ingenic,jz4780";
 
+	model = "Imagination creator CI20";
+
 	aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
-- 
2.33.0

