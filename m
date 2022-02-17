Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB24C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 20:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343553AbiBQU0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 15:26:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343532AbiBQU0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:26:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9281662E1;
        Thu, 17 Feb 2022 12:25:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E844B82486;
        Thu, 17 Feb 2022 20:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44F3C340E8;
        Thu, 17 Feb 2022 20:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129552;
        bh=F56jf0lsMIV7JzWwGs9VyV/0PlxgQNzNy9P6DuyhSBc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=h0pF0tnGV1u/PtVKkqfQivXmkANDsTzytkZMxqHRGb40wGnl7DH29txeynNMlLHCd
         65lQqZ1OIyYfC6/kdWiIWTHYrUytP+HQXAPYTXMEBigvLyhSKMDe7cRPSuTtTX1mS/
         yGk7BR6A51jnP0JohKs64enaO2FkUP+tOCRLUOlDthK1+1p4swsxmSuBbWeaNqGKAh
         6GOUiG8oklEUXJcOaxP4FNZ/Knk7lCq/pF1T9QhBmwkGf2p/wY27SZpl4nX2gsSyA6
         MSTSpeEi38FvfWNiAaKkAkyFEWJ8P6rAy0qsomJnvH2bLsFEcdS94choCdfDKfNomP
         drpPQQk3CDVNw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-16-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-16-wenst@chromium.org>
Subject: Re: [PATCH v3 15/31] clk: mediatek: Implement mtk_clk_unregister_fixed_clks() API
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
Date:   Thu, 17 Feb 2022 12:25:51 -0800
User-Agent: alot/0.10
Message-Id: <20220217202552.D44F3C340E8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:18)
> mtk_clk_register_fixed_clks(), as the name suggests, is used to register
> a given list of fixed rate clks. However it is lacking a counterpart
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
