Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2126C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Feb 2022 00:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354340AbiBLAYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Feb 2022 19:24:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbiBLAYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 19:24:04 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2565C55;
        Fri, 11 Feb 2022 16:24:00 -0800 (PST)
Received: from p508fd6ee.dip0.t-ipconnect.de ([80.143.214.238] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nIgCQ-0003C9-1p; Sat, 12 Feb 2022 01:23:38 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Tianling Shen <cnsztl@gmail.com>,
        Levin Du <djw@t-chip.com.cn>,
        linux-rockchip@lists.infradead.org, Alex Bee <knaerzche@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Liang Chen <cl@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: rockchip: Add Pine64 PineNote board
Date:   Sat, 12 Feb 2022 01:23:36 +0100
Message-Id: <164462530187.853991.5366752507698485779.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220130053803.43660-1-samuel@sholland.org>
References: <20220130053803.43660-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 23:38:01 -0600, Samuel Holland wrote:
> The PineNote is a tablet from Pine64 based on the RK3566 SoC. There are
> two existing variants of the board. v1.1 was contained in some early
> samples, and v1.2 was sold as the "PineNote Developer Edition".

Applied, thanks!

[1/3] dt-bindings: arm: rockchip: Add Pine64 PineNote board
      commit: a7c9013216f399791ca354cc2e0f4a444837fe39
[2/3] arm64: dts: rockchip: rk356x: Add pdm node
      commit: 79c5f0e52d29a688a951fc818394b529e7e77e3e

-> change ordering for pinctrl properties, as suggested by Michael

[3/3] arm64: dts: rockchip: Add Pine64 PineNote board
      commit: d449121e5e8addcee654250cec298c887ecafb32

-> folded in Johan's review comments
   Though mmc0 can stay at sdhci. I don't think we _need_
   aliases for all, but fixing mmc0 for the internal emmc makes
   a lot of sense.

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
