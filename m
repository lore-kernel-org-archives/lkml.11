Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EDFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 23:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiBVX1t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 18:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiBVX1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:27:45 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E598EB7C;
        Tue, 22 Feb 2022 15:27:16 -0800 (PST)
Received: from [185.156.123.69] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nMeYq-0006wl-4q; Wed, 23 Feb 2022 00:27:12 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-kernel@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Liang Chen <cl@rock-chips.com>,
        frank-w@public-files.de, Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: rockchip: enable work led on rk3568-evb1
Date:   Wed, 23 Feb 2022 00:27:09 +0100
Message-Id: <164557235424.1264579.1250826680856309781.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222175004.1308990-1-michael.riesch@wolfvision.net>
References: <20220222175004.1308990-1-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 18:50:03 +0100, Michael Riesch wrote:
> Enable the blue work LED on the Rockchip RK3568 EVB1.

Applied, thanks!

[1/2] arm64: dts: rockchip: enable work led on rk3568-evb1
      commit: e2bcb9477e48ff7c10d0d3508cd16f0a10e81dd8

- Renamed the node to led-0 (according to binding)
- dropped label (deprecated) and instead moved to
  color and function properties (to try them out)


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
