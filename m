Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CEEC4332F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Apr 2022 17:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243725AbiDJRPV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Apr 2022 13:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239314AbiDJRPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:15:15 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ABD34B88;
        Sun, 10 Apr 2022 10:13:04 -0700 (PDT)
Received: from p508fdda7.dip0.t-ipconnect.de ([80.143.221.167] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ndb7T-0006hD-O7; Sun, 10 Apr 2022 19:12:59 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] enable usb support on rk356x
Date:   Sun, 10 Apr 2022 19:12:56 +0200
Message-Id: <164961074165.23152.8964489836130801474.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408151237.3165046-1-pgwipeout@gmail.com>
References: <20220408151237.3165046-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2022 11:12:32 -0400, Peter Geis wrote:
> Good Morning,
> 
> This is my patch series that I have maintained out of tree until the
> combophy driver landed.
> 
> This has been rebased on v5.18-rc1, several patches in the previous
> series already landed and have been dropped.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: soc: grf: add rk3566-pipe-grf compatible
      commit: 2a872dd86eeb349f169df0a204668afa578a94b2
[2/5] soc: rockchip: set dwc3 clock for rk3566
      commit: 5c0bb71138770d85ea840acd379edc6471b867ee
[3/5] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
      commit: 9f4c480f24e2ce1d464ff9d5f8a249a485acdc7f
[4/5] arm64: dts: rockchip: enable dwc3 on quartz64-a
      commit: e432309ff8bf2a148bbdd4946ca1580c6b5b610c
[5/5] arm64: dts: rockchip: add usb3 support to rk3568-evb1-v10
      commit: d6cfb110b0fdfb4e61ef4e3c3ab89a8f21b4d1b8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
