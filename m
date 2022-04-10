Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDDBC433FE
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Apr 2022 20:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243946AbiDJUer (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Apr 2022 16:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243925AbiDJUee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 16:34:34 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70EB36339;
        Sun, 10 Apr 2022 13:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649622731; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=gIHrux1Qx6cY6Pyu4y77mzgZzBjZyceD7oDM7YFkR/mKow87bN1DefCaocxDQfjgqeimJ/WAQS33ic0N0V8cu0nJh9im/KZsru1pPLA4fbe2J8cUiF+mvZ4OXHqCrgIGoYDBDpV+xRr7HbHy0Ywdm1+so3iL+pSIdcJNCeQsqqA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649622731; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=/MOMK34Z6z6C4CqZb8rLYQ4jYbrhj9LEWEwpaErwP4o=; 
        b=XLiSQj5h+xt2fR9KFl/aQJnOAIAJH+F8JK+SPP7MoDqFEYvcnPop1m2C1o3N2+iYxxJa2k1JbcAx74taP/ufzMq7A2Bra2HOJvj93VbKwxioUT/VtSP73P1OU63gWrcIExksd+Ibv3yY21/4BIDQLwSdR6ttmnHiYRJDBZzOnh4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649622731;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=/MOMK34Z6z6C4CqZb8rLYQ4jYbrhj9LEWEwpaErwP4o=;
        b=IEqd05QgWct3oxoPxsxQmyqf/6IlDq+nbX7nej93sqGJqCJiJxW00t9S3XUwi+m+
        K3ZWJHZfC3+l7SXb2VCkjmtO0+Zl/VcWAf91U+Tme95kJe+LFtoI23zC5yI3OMnjv21
        6wo149RY6tWIXTSm7xg1V8aSycanXsH/CpHehsvg=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649622730691527.6330187658422; Sun, 10 Apr 2022 13:32:10 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: [PATCH 3/3] mips: dts: mt7621: remove binding for defining gpio function for pin groups
Date:   Sun, 10 Apr 2022 23:31:38 +0300
Message-Id: <20220410203138.22513-3-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220410203138.22513-1-arinc.unal@arinc9.com>
References: <20220410203138.22513-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All pin groups function as gpio unless set otherwise. Therefore, remove
this unnecessary binding.

Tested on UniElec U7621-06-16M on OpenWrt.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts | 12 ------------
 arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts | 12 ------------
 2 files changed, 24 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
index 75f3b0425487..c307a0edb91f 100644
--- a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
+++ b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
@@ -97,18 +97,6 @@ &pcie {
 	status = "okay";
 };
 
-&pinctrl {
-	pinctrl-names = "default";
-	pinctrl-0 = <&state_default>;
-
-	state_default: state-default {
-		gpio-pinmux {
-			groups = "uart3", "wdt";
-			function = "gpio";
-		};
-	};
-};
-
 &gmac1 {
 	status = "okay";
 	phy-handle = <&ethphy4>;
diff --git a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
index b427ae9e081f..8268d738e74f 100644
--- a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
+++ b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
@@ -81,18 +81,6 @@ &pcie {
 	status = "okay";
 };
 
-&pinctrl {
-	pinctrl-names = "default";
-	pinctrl-0 = <&state_default>;
-
-	state_default: state-default {
-		gpio-pinmux {
-			groups = "wdt";
-			function = "gpio";
-		};
-	};
-};
-
 &gmac1 {
 	status = "okay";
 	phy-handle = <&ethphy7>;
-- 
2.25.1

