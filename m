Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EA7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 19:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352562AbiEQTMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 15:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352600AbiEQTL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:11:28 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2667B3584C;
        Tue, 17 May 2022 12:11:26 -0700 (PDT)
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nr2bL-00043L-Pp; Tue, 17 May 2022 21:11:23 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     zhangqing@rock-chips.com, Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org, sboyd@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: convert rockchip,rk3368-cru.txt to YAML
Date:   Tue, 17 May 2022 21:11:18 +0200
Message-Id: <165281458742.3119039.12700615403743089370.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329180550.31043-1-jbx6244@gmail.com>
References: <20220329180550.31043-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2022 20:05:49 +0200, Johan Jonker wrote:
> Convert rockchip,rk3368-cru.txt to YAML.
> 
> Changes against original bindings:
>  - Add clocks and clock-names because the device has to have
>    at least one input clock.

Applied, thanks!

[1/2] dt-bindings: clock: convert rockchip,rk3368-cru.txt to YAML
      commit: 32a214cd8ccbc361319bcd00b0b1b05a6b53bc61
[2/2] arm64: rockchip: add clocks property to cru node rk3368
      commit: 17c0c5b67353b26a46611cffffd80aadd7215cfa

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
