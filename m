Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1932C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jan 2022 17:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352960AbiA2R5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jan 2022 12:57:51 -0500
Received: from gloria.sntech.de ([185.11.138.130]:49014 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346274AbiA2R5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 12:57:42 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nDryj-0005eg-E7; Sat, 29 Jan 2022 18:57:37 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     "quentin.schulz@theobroma-systems.com" 
        <quentin.schulz@theobroma-systems.com>, robh+dt@kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Quentin Schulz <foss+kernel@0leil.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix rk3399-puma eMMC HS400 signal integrity
Date:   Sat, 29 Jan 2022 18:57:40 +0100
Message-Id: <164347899463.1472860.17160610322270835288.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220119134948.1444965-1-quentin.schulz@theobroma-systems.com>
References: <20220119134948.1444965-1-quentin.schulz@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 14:49:48 +0100, quentin.schulz@theobroma-systems.com wrote:
> There are signal integrity issues running the eMMC at 200MHz on Puma
> RK3399-Q7.
> 
> Similar to the work-around found for RK3399 Gru boards, lowering the
> frequency to 100MHz made the eMMC much more stable, so let's lower the
> frequency to 100MHz.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: fix rk3399-puma eMMC HS400 signal integrity
      commit: 7623e16af6bac131305292eb99cea988adbf0484

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
