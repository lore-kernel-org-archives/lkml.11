Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7136FC4332F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 20:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343673AbiBQU37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 15:29:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343667AbiBQU34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:29:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6C9C335F;
        Thu, 17 Feb 2022 12:29:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 49344CE2B9B;
        Thu, 17 Feb 2022 20:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83414C340E8;
        Thu, 17 Feb 2022 20:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129778;
        bh=e7gXUqdQaMp2/D5J/MXBJFTUdTqleGN92ISGm8B0VUg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jl508gxbGjOBw2Nelk0XLCiVUqH1WDwttZn9GycQ9F/XiH6HxYuRbiFH2s2l+P79I
         34vk647I7MWDtyWdCx9xoRFwndeeBgNPGETuMNzZSwMy7GsuOl+LRIEGCth1gMfR3H
         yy5j5KPwImwXLHvNIwMBLcGhEsI/WU46q4HBCnwMawXAvF+hRHIrjsueEXCwpIP5Mi
         +GlR01yGeLJQzSkBdHZ2y1fhvClG/cG4oecAbAvisfjYuK1WIj8wGNQzPAGVeE9pEk
         C4ZtDzjG2wYwWTdIih9om/PHnp/rWO6Tehqq3iP7IRLaFq2LcpyPGxJj/jS1f55iL3
         omsR62w3U277g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-30-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-30-wenst@chromium.org>
Subject: Re: [PATCH v3 29/31] clk: mediatek: mt8195: Implement error handling in probe functions
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
Date:   Thu, 17 Feb 2022 12:29:36 -0800
User-Agent: alot/0.10
Message-Id: <20220217202938.83414C340E8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:32)
> Until now the mediatek clk driver library did not have any way to
> unregister clks, and so all drivers did not do proper cleanup in
> their error paths.
>=20
> Now that the library does have APIs to unregister clks, use them
> in the error path of the probe functions for the mt8195 clk drivers
> to do proper cleanup.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Applied to clk-next
