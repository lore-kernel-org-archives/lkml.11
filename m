Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A328C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 13:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357322AbiFVNpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 09:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245358AbiFVNo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:44:59 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E7D22BC4;
        Wed, 22 Jun 2022 06:44:59 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8C22F2D0; Wed, 22 Jun 2022 15:44:57 +0200 (CEST)
Date:   Wed, 22 Jun 2022 15:44:56 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     yong.wu@mediatek.com, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org, miles.chen@mediatek.com
Subject: Re: [PATCH v4 0/5] mtk_iommu: Specify phandles to infracfg and
 pericfg
Message-ID: <YrMc2EUBDIxnoWiB@8bytes.org>
References: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 01:08:25PM +0200, AngeloGioacchino Del Regno wrote:
> AngeloGioacchino Del Regno (5):
>   dt-bindings: iommu: mediatek: Add mediatek,infracfg phandle
>   iommu/mediatek: Lookup phandle to retrieve syscon to infracfg
>   arm64: dts: mediatek: mt8173: Add mediatek,infracfg phandle for IOMMU
>   arm64: dts: mediatek: mt2712e: Add mediatek,infracfg phandle for IOMMU
>   iommu/mediatek: Cleanup pericfg lookup flow
> 
>  .../bindings/iommu/mediatek,iommu.yaml        | 17 +++++++
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |  2 +
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  1 +
>  drivers/iommu/mtk_iommu.c                     | 50 +++++++++++--------
>  4 files changed, 49 insertions(+), 21 deletions(-)

Applied, thanks.
