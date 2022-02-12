Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BDAC433FE
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Feb 2022 00:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354433AbiBLA2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Feb 2022 19:28:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354450AbiBLA2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 19:28:42 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75550D89;
        Fri, 11 Feb 2022 16:28:38 -0800 (PST)
Received: from p508fd6ee.dip0.t-ipconnect.de ([80.143.214.238] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nIgHE-0003EL-7u; Sat, 12 Feb 2022 01:28:36 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     krzysztof.kozlowski@canonical.com,
        Corentin Labbe <clabbe@baylibre.com>, robh+dt@kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] ARM: dts: rk3288: fix a typo on crypto-controller
Date:   Sat, 12 Feb 2022 01:28:33 +0100
Message-Id: <164462570821.854738.5709330315457571448.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209120355.1985707-1-clabbe@baylibre.com>
References: <20220209120355.1985707-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2022 12:03:55 +0000, Corentin Labbe wrote:
> crypto-controller had a typo, fix it.
> In the same time, rename it to just crypto

Applied, thanks!

[1/1] ARM: dts: rk3288: fix a typo on crypto-controller
      commit: 3916c3619599a3970d3e6f98fb430b7c46266ada

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
