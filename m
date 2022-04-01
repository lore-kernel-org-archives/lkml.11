Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83BCC4167D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 14:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347273AbiDAOaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347212AbiDAO3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:29:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64FF28AB03;
        Fri,  1 Apr 2022 07:27:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2049FB824FD;
        Fri,  1 Apr 2022 14:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86889C2BBE4;
        Fri,  1 Apr 2022 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648823238;
        bh=b51VNEiKO+Fx8+RwLfJTXx0nWoth9Ssof+K5dUkMstw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lzRb5qcLN1/53yc5oKT7sO3W6zaQ42oQ3Jca7Tb2yP2UboEfdR/V5+nrf9uI/ET2b
         dRE6ku5jr+MY/+L0VJS6m88I/eXQYZX0Vzl8imU5JPcPP9lZrwuONARZLCqW9FE6yO
         f7ZSbCaHSXF2n936Jsbmpcg1M8ccdLZmlAqAIg/Gc1AtP3dwLTIThIHCMGwzX5uvod
         6o5u3hMQo5QaUDXA3R8/hUS11rULghiEn0RSN0hXkGlIufBTJhkG8iT4IS0rdZW0L7
         o33WLfkdHswI+WXTxg+K6fHgRmniEgrciDxsUFGi5zDoXJ1SuSXCUs4AA8AxqTliIf
         4g13TgkmDEIXg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, robh+dt@kernel.org,
        krzk+dt@kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.17 028/149] powerpc: dts: t104xrdb: fix phy type for FMAN 4/5
Date:   Fri,  1 Apr 2022 10:23:35 -0400
Message-Id: <20220401142536.1948161-28-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401142536.1948161-1-sashal@kernel.org>
References: <20220401142536.1948161-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Kiselev <bigunclemax@gmail.com>

[ Upstream commit 17846485dff91acce1ad47b508b633dffc32e838 ]

T1040RDB has two RTL8211E-VB phys which requires setting
of internal delays for correct work.

Changing the phy-connection-type property to `rgmii-id`
will fix this issue.

Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
Reviewed-by: Maxim Kochetkov <fido_max@inbox.ru>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20211230151123.1258321-1-bigunclemax@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/boot/dts/fsl/t104xrdb.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
index 099a598c74c0..bfe1ed5be337 100644
--- a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
@@ -139,12 +139,12 @@ pca9546@77 {
 		fman@400000 {
 			ethernet@e6000 {
 				phy-handle = <&phy_rgmii_0>;
-				phy-connection-type = "rgmii";
+				phy-connection-type = "rgmii-id";
 			};
 
 			ethernet@e8000 {
 				phy-handle = <&phy_rgmii_1>;
-				phy-connection-type = "rgmii";
+				phy-connection-type = "rgmii-id";
 			};
 
 			mdio0: mdio@fc000 {
-- 
2.34.1

