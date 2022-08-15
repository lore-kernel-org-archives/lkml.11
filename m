Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21FEC28B2B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 20:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345089AbiHOUdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 16:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348003AbiHOU1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB629F19D;
        Mon, 15 Aug 2022 12:03:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 348FE612BF;
        Mon, 15 Aug 2022 19:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2740AC433D7;
        Mon, 15 Aug 2022 19:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660590231;
        bh=lwen1EgOL0WIJxndcyGGj6vv0zvik1mBKliZtD3eSSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UvQ08GC7njX0Ify50xXorXdBe6OQZUblw+wfOCJy5AAMfGqc4gIDwRQhDcb+oy9z6
         KmVT0G1yjEkymGYxti/eYMl5X8HlWopXrzH7N99S5yGjWo8PSSF4BczHWN3p6ctz7R
         rbSZI9hFvbhnEqqS2DbWhvGf9YZUXakLYTCs7y20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 0193/1095] ARM: dts: imx7d-colibri-emmc: add cpu1 supply
Date:   Mon, 15 Aug 2022 19:53:12 +0200
Message-Id: <20220815180437.605854399@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180429.240518113@linuxfoundation.org>
References: <20220815180429.240518113@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

[ Upstream commit ba28db60d34271e8a3cf4d7158d71607e8b1e57f ]

Each cpu-core is supposed to list its supply separately, add supply for
cpu1.

Fixes: 2d7401f8632f ("ARM: dts: imx7d: Add cpu1 supply")
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
index af39e5370fa1..045e4413d339 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
@@ -13,6 +13,10 @@ memory@80000000 {
 	};
 };
 
+&cpu1 {
+	cpu-supply = <&reg_DCDC2>;
+};
+
 &gpio6 {
 	gpio-line-names = "",
 			  "",
-- 
2.35.1



