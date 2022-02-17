Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4250AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 20:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343598AbiBQU06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 15:26:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343595AbiBQU0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:26:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB828A307;
        Thu, 17 Feb 2022 12:26:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60E4E61DA5;
        Thu, 17 Feb 2022 20:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D4BC340E8;
        Thu, 17 Feb 2022 20:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645129596;
        bh=L08hTw8zTV+JKtdGBctd84i5lTqRbbrmlmUsysrPN5I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BbeqNWiRYfgWP5tn8m+8lWlPis9ecHt9e61Z8xkbqF2zUdk59OfM1tawz0gdfUzTi
         j+i1pC+Jtwsej2GBAfT070p/d+yY5CQ/0lNbvdVTcuN0VRn1McB24sAQ1ULkD5go3b
         IzqzGuTvkG6C93tfNxtg9RmVwh/u4xelud4iD1LjLON8u+pMqvgZGvitY4qcx2vCPP
         4tP20BwT09Hrqo1GiQ5doGJGxsB0p9VALF628oh18JFmX2MmgcK/hHJ/yXj/sVddEV
         cBF1u7Vzi2qbe23PZ+SF19+sxfPYCR/pAkg+67xF9dOJoWyhtw6ysepL8PFisjyEuo
         d6BWdXNadWJJA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220208124034.414635-20-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org> <20220208124034.414635-20-wenst@chromium.org>
Subject: Re: [PATCH v3 19/31] clk: mediatek: Add mtk_clk_simple_remove()
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
Date:   Thu, 17 Feb 2022 12:26:35 -0800
User-Agent: alot/0.10
Message-Id: <20220217202636.B4D4BC340E8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-02-08 04:40:22)
> In commit c58cd0e40ffa ("clk: mediatek: Add mtk_clk_simple_probe() to
> simplify clock providers"), a generic probe function was added to
> simplify clk drivers that only needed to support clk gates. However due
> to the lack of unregister APIs, a corresponding remove function was not
> added.
>=20
> Now that the unregister APIs have been implemented, add aforementioned
> remove function to make it complete.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next
