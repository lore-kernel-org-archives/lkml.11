Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23062C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 13:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244195AbiDNN1H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 09:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239639AbiDNNYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:24:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D097D9AE71;
        Thu, 14 Apr 2022 06:18:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DE6961672;
        Thu, 14 Apr 2022 13:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C99BC385A1;
        Thu, 14 Apr 2022 13:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649942333;
        bh=DGfFICk0ZyhZyp7gehgdnGZsI2rdjdBF6ht5fhvYKxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xpt1XRjrV/TEaewaXicbiXSOpcf1544piEhyxYF2ANaW4wvjqesZqgoaK8zCCxNVK
         +rmNYkmAgfMrIpftozAYuOltwyG8aixqvb7fFwnmhcuFaTvfN6xA1wNT5moTWjMn16
         M4uok9xb3sMjK270iAV0kyH8VTP8joHItz033T0c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 097/338] arm64: dts: ns2: Fix spi-cpol and spi-cpha property
Date:   Thu, 14 Apr 2022 15:10:00 +0200
Message-Id: <20220414110841.659138916@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110838.883074566@linuxfoundation.org>
References: <20220414110838.883074566@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuldeep Singh <singh.kuldeep87k@gmail.com>

[ Upstream commit c953c764e505428f59ffe6afb1c73b89b5b1ac35 ]

Broadcom ns2 platform has spi-cpol and spi-cpho properties set
incorrectly. As per spi-slave-peripheral-prop.yaml, these properties are
of flag or boolean type and not integer type. Fix the values.

Fixes: d69dbd9f41a7c (arm64: dts: Add ARM PL022 SPI DT nodes for NS2)
Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
CC: Ray Jui <rjui@broadcom.com>
CC: Scott Branden <sbranden@broadcom.com>
CC: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
index ec19fbf928a1..12a4b1c03390 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dts
@@ -111,8 +111,8 @@
 		compatible = "silabs,si3226x";
 		reg = <0>;
 		spi-max-frequency = <5000000>;
-		spi-cpha = <1>;
-		spi-cpol = <1>;
+		spi-cpha;
+		spi-cpol;
 		pl022,hierarchy = <0>;
 		pl022,interface = <0>;
 		pl022,slave-tx-disable = <0>;
@@ -135,8 +135,8 @@
 		at25,byte-len = <0x8000>;
 		at25,addr-mode = <2>;
 		at25,page-size = <64>;
-		spi-cpha = <1>;
-		spi-cpol = <1>;
+		spi-cpha;
+		spi-cpol;
 		pl022,hierarchy = <0>;
 		pl022,interface = <0>;
 		pl022,slave-tx-disable = <0>;
-- 
2.34.1



