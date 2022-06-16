Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C2EC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 01:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350739AbiFPBxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 21:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354844AbiFPBxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC8017E0E;
        Wed, 15 Jun 2022 18:53:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD2E961D04;
        Thu, 16 Jun 2022 01:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C237C3411A;
        Thu, 16 Jun 2022 01:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655344394;
        bh=PP++1yptzcHC6G8Bb2ynd8Cxm876Mj4V54pJHkxkdvs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=p9cuLWny81mknKSw2Y/PCHv2O3KMHrMot4HMkwVUGATsCkGHLqaXE7CPKeiwvBtZD
         +uoGxvPiOEgANVq6zLDwd0ndpsoO2J5nysB1sQBJ8KcRZNx0GLsWFIRv8ubWg6RcU4
         gwUKqeLzoQApBlffJnGk+iee62mQOVRslQv+x5NdEGgqASKuZI5h4URq/wUWIP6BVx
         srrafaj2UBCsMAupTxwq7h9Uog1ZNBxGa7inRWbKQLSvHEaw3+wXkf7C41psd6dcLQ
         Aucvtd1sUqDwpWBG0zoaMALEkaxxLwQoFqwdutG3vbabsrhujMyRxndxO7jjs6eKCO
         Gu+bBBDw1O8bw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220523093346.28493-12-rex-bc.chen@mediatek.com>
References: <20220523093346.28493-1-rex-bc.chen@mediatek.com> <20220523093346.28493-12-rex-bc.chen@mediatek.com>
Subject: Re: [RESEND v8 11/19] clk: mediatek: reset: Add reset support for simple probe
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, chun-jie.chen@mediatek.com,
        wenst@chromium.org, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Wed, 15 Jun 2022 18:53:10 -0700
User-Agent: alot/0.10
Message-Id: <20220616015314.1C237C3411A@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rex-BC Chen (2022-05-23 02:33:38)
> - Add a pointer of "mtk_clk_rst_desc" to "mtk_clk_desc".
> - Add register reset with device function in mtk_clk_simple_probe().
>=20
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---

Applied to clk-next
