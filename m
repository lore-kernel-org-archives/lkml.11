Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC50C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347521AbiBUJFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:05:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347963AbiBUJCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:02:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2999E2A26C;
        Mon, 21 Feb 2022 00:57:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9ECDDB80EA5;
        Mon, 21 Feb 2022 08:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CEAC340F1;
        Mon, 21 Feb 2022 08:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645433839;
        bh=ds2FuH8pOL3cY/92w6Bq0OB6x52HU1C+5zmw1fSGV9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z9/dNLZ6rEuPqUC64J0XxCHrz1+WzmwUaY3kCQ/fITkXqD2Y7Ka5p2E268eIHJUkb
         80lvCt9DbFEWHjQr4HHOH2BHUMzHs+tVpArbl2w/8BBMRcbiSlyWSlIqQHe66nvd9l
         ubPgi3Fsa1KC+rPWuj9GubMbg/dgXwFDEXJBcku4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mateusz Krzak <kszaquitto@gmail.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 53/58] arm64: dts: meson-gx: add ATF BL32 reserved-memory region
Date:   Mon, 21 Feb 2022 09:49:46 +0100
Message-Id: <20220221084913.578903776@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084911.895146879@linuxfoundation.org>
References: <20220221084911.895146879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

[ Upstream commit 76577c9137456febb05b0e17d244113196a98968 ]

Add an additional reserved memory region for the BL32 trusted firmware
present in many devices that boot from Amlogic vendor u-boot.

Suggested-by: Mateusz Krzak <kszaquitto@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lore.kernel.org/r/20220126044954.19069-2-christianshewitt@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index b8dc4dbb391b6..4252119bfd901 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -41,6 +41,12 @@
 			no-map;
 		};
 
+		/* 32 MiB reserved for ARM Trusted Firmware (BL32) */
+		secmon_reserved_bl32: secmon@5300000 {
+			reg = <0x0 0x05300000 0x0 0x2000000>;
+			no-map;
+		};
+
 		linux,cma {
 			compatible = "shared-dma-pool";
 			reusable;
-- 
2.34.1



