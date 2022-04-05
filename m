Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A06C35294
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 22:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456248AbiDEWpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 18:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354238AbiDEKM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:12:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8755D199;
        Tue,  5 Apr 2022 02:59:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04BA7B817D3;
        Tue,  5 Apr 2022 09:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67200C385A1;
        Tue,  5 Apr 2022 09:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649152761;
        bh=lQRtMgDTrcSWyqXbZhsMoWU1a+zIBYvvylab8ih+iEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JuQahCh+ESgLohnggOE48fGGLjXZ+6rPmshCXpCTbKSpVBo44s/DbYgFf8Zs5i6pD
         8nhXAGUf9bUj6wCX/qHkqxtQ72facEM4Hg3tBrD/oUUwc1yhZjfMBKFWpRHwMW32lF
         00q/L2beVHLcWLhQx/pDS1U315nTbGkAj0OiA4+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5.15 893/913] ARM: dts: spear1340: Update serial node properties
Date:   Tue,  5 Apr 2022 09:32:35 +0200
Message-Id: <20220405070406.589706088@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070339.801210740@linuxfoundation.org>
References: <20220405070339.801210740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuldeep Singh <singh.kuldeep87k@gmail.com>

commit 583d6b0062640def86f3265aa1042ecb6672516e upstream.

Reorder dma and dma-names property for serial node to make it compliant
with bindings.

Fixes: 6e8887f60f60 ("ARM: SPEAr13xx: Pass generic DW DMAC platform data from DT")
Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lore.kernel.org/r/20220326042313.97862-3-singh.kuldeep87k@gmail.com'
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/spear1340.dtsi |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -136,9 +136,9 @@
 				reg = <0xb4100000 0x1000>;
 				interrupts = <0 105 0x4>;
 				status = "disabled";
-				dmas = <&dwdma0 12 0 1>,
-					<&dwdma0 13 1 0>;
-				dma-names = "tx", "rx";
+				dmas = <&dwdma0 13 0 1>,
+					<&dwdma0 12 1 0>;
+				dma-names = "rx", "tx";
 			};
 
 			thermal@e07008c4 {


