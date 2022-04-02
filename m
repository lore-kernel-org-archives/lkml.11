Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52B6C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Apr 2022 11:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354653AbiDBLDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Apr 2022 07:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243308AbiDBLCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:02:51 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A431D5C64B;
        Sat,  2 Apr 2022 04:00:59 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout2.routing.net (Postfix) with ESMTP id 2B1FF604EA;
        Sat,  2 Apr 2022 11:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1648897258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fiF2czy3fSgLbpJlx4zoA+bi17AwyEhQirvjS4BVRRE=;
        b=iP1O0hVPiTthtWFeD4dE15aC9ANGrl9odXgMAEBpwJgF6bD2qPpJF5905I4vY8lXL874Ob
        Z29u7xYCg/QXUArxsa/DvjMICUAL7hgqfd28Z19Lc9DRwnwgcWXPZw81PiExiawh+QUD49
        B4M1pJ0kRAo2y51O6x4K8Rem50wRnqk=
Received: from localhost.localdomain (fttx-pool-80.245.79.107.bambit.de [80.245.79.107])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 4CBEC36062B;
        Sat,  2 Apr 2022 11:00:57 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] arm64: dts: rockchip: Change io-domains of bpi-r2-pro
Date:   Sat,  2 Apr 2022 13:00:44 +0200
Message-Id: <20220402110045.104031-2-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402110045.104031-1-linux@fw-web.de>
References: <20220402110045.104031-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 6d6b9b5d-3d03-4486-aed8-edb06c31f801
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

New Hardware revision has different io domain settings than the first
board.

First version was not sold, so the setting can be savely overridden.

Fixes: f901aaadaa2a ("arm64: dts: rockchip: Add Bananapi R2 Pro")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
index a01886b467ed..a0388ff85ddf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
@@ -345,9 +345,9 @@ &pmu_io_domains {
 	pmuio2-supply = <&vcc3v3_pmu>;
 	vccio1-supply = <&vccio_acodec>;
 	vccio3-supply = <&vccio_sd>;
-	vccio4-supply = <&vcc_1v8>;
+	vccio4-supply = <&vcc_3v3>;
 	vccio5-supply = <&vcc_3v3>;
-	vccio6-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcc_1v8>;
 	vccio7-supply = <&vcc_3v3>;
 	status = "okay";
 };
-- 
2.25.1

