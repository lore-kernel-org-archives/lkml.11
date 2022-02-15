Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA0EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 08:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiBOIBZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 03:01:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbiBOIBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:01:23 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3576213E36;
        Tue, 15 Feb 2022 00:01:12 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nJslm-00067j-6R; Tue, 15 Feb 2022 09:01:06 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: rk3288: remove status from crypto node
Date:   Tue, 15 Feb 2022 09:01:04 +0100
Message-Id: <164491205724.964490.11065138775660081391.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220213212319.8448-1-jbx6244@gmail.com>
References: <20220213212319.8448-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Feb 2022 22:23:19 +0100, Johan Jonker wrote:
> A node that is not disabled is standard already "okay",
> so remove status from rk3288 crypto node.

Applied, thanks!

[1/1] ARM: dts: rockchip: rk3288: remove status from crypto node
      commit: 5a68ce0a7b89a7005a71d406435a45a24c7e86da

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
