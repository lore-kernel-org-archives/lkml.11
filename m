Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36AFC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 20:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343583AbiBQU0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 15:26:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiBQU0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:26:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9E4BAB80;
        Thu, 17 Feb 2022 12:26:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C361BB821B1;
        Thu, 17 Feb 2022 20:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6074EC340E8;
        Thu, 17 Feb 2022 20:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129574;
        bh=YDiQDTJ+CjvxKVpah8P3iijxt5wx2VTPTsXT5mpZmow=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sIap85mOJ3YoJEf7RXtfiT8PQES3d2WQ+ffuMOChmNvsBNGDUMuEOnBFX4Ohy/UXB
         TPoBniuzhgE7M0S+e1V1ShxkzNBfWTZZBVsmmb+6ELlEaKm70Ap1pakF68voaRpax9
         OK//9C+LDI7/blVZYcGp5WWUTaa12d/MUdmXsNIrUHfAXnyTZwvbwG8Mm3LCgEkCRc
         CxWu3FCdD17QyTIqjNhmsjXi/d49X+7dMkJ6Sj14gg41aEVAC0nPAndAzFR0WLQukT
         N8cWIheXqQWHLVo3nY2iU/2f8rY3QNR3qlyAYqZXd+LhP3WepG/fCop1c34acs0enI
         Yi/wLrQ3Nns0w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-18-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-18-wenst@chromium.org>
Subject: Re: [PATCH v3 17/31] clk: mediatek: Implement mtk_clk_unregister_divider_clks() API
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 17 Feb 2022 12:26:12 -0800
User-Agent: alot/0.10
Message-Id: <20220217202614.6074EC340E8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:20)
> mtk_clk_register_divider_clks(), as the name suggests, is used to register
> a given list of divider clks. However it is lacking a counterpart
> unregister API.
>=20
> Implement said unregister API so that the various clock platform drivers
> can utilize it to do proper unregistration, cleanup and removal.
>=20
> In the header file, the register function's declaration is also
> reformatted to fit code style guidelines.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
