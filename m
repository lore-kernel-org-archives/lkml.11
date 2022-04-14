Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD3DC3A5A7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 13:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbiDNNs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 09:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344004AbiDNNaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:30:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2B791557;
        Thu, 14 Apr 2022 06:26:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32CDBB82941;
        Thu, 14 Apr 2022 13:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816FCC385A1;
        Thu, 14 Apr 2022 13:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649942759;
        bh=cOWNMoWg3qlnPk/yhEttGH1oR7VfOw0Ae+GeojOdPBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sNn9zgyitU+xs+FHw9ENgnTkvDhYCv3GDGBUgizZZvIcMNYYvRzhS0jnyiRu9hOEk
         yZkNDiHy0lDgRM82193a3gQYBHlCj5LVEsy88nWYIVvJU5kpLUZWmlyDbg7WDPPNvE
         4mqhsvIIlMjFnY651bX/x94Lr6qQVZETEh0FDh24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.19 252/338] ARM: dts: spear13xx: Update SPI dma properties
Date:   Thu, 14 Apr 2022 15:12:35 +0200
Message-Id: <20220414110846.063809742@linuxfoundation.org>
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

commit 31d3687d6017c7ce6061695361598d9cda70807a upstream.

Reorder dmas and dma-names property for spi controller node to make it
compliant with bindings.

Fixes: 6e8887f60f60 ("ARM: SPEAr13xx: Pass generic DW DMAC platform data from DT")
Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lore.kernel.org/r/20220326042313.97862-2-singh.kuldeep87k@gmail.com'
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/spear13xx.dtsi |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -290,9 +290,9 @@
 				#size-cells = <0>;
 				interrupts = <0 31 0x4>;
 				status = "disabled";
-				dmas = <&dwdma0 4 0 0>,
-					<&dwdma0 5 0 0>;
-				dma-names = "tx", "rx";
+				dmas = <&dwdma0 5 0 0>,
+					<&dwdma0 4 0 0>;
+				dma-names = "rx", "tx";
 			};
 
 			rtc@e0580000 {


