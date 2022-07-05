Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A02BC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 06:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiGEG6x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 02:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiGEG6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:58:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4234FD1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 23:58:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89638B815B3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74F2C341CD;
        Tue,  5 Jul 2022 06:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657004325;
        bh=wtCX0mhuv6OWF5JECPvFl2ihKCo2T2AiGHFIg2o0AzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUr54vnD8SejPfoxdafHuCuojZ0XoEd3MsOh1GnmfpjoFlNDTtd/vJ+ZvYwpm4IyG
         cttENLMUPiUAlGVx0K1mluiO4qeMh0a/RG/d4nVgp37ERs1e85jrzcSgkD6YNyAkSu
         PToZ7HQamkL0m9KnfTo5NEh+qf54PkQ9dNorWomy9XTmSGLBkBQY4mkpvjgYD0uzLs
         YN+FfvMJbJP2t5RoB0E/5IQZ/w5KFY6U2ItkqyAdvjjgWmFBipF7qevYDtTUsvwKj1
         0x6ZdiBbS7Fnnm4NuBflSb7aM+9RE0+wN2u64N96nykywWvTQl8Uko4baItw5Psy37
         PzNnkw6tyc40w==
Date:   Tue, 5 Jul 2022 12:28:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        chunfeng.yun@mediatek.com, kishon@ti.com, matthias.bgg@gmail.com,
        airlied@linux.ie, msp@baylibre.com, granquet@baylibre.com,
        jitao.shi@mediatek.com, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v12 1/1] phy: phy-mtk-dp: Add driver for DP phy
Message-ID: <YsPhH1sXiT/+unbj@matsya>
References: <20220624062725.4095-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624062725.4095-1-rex-bc.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-06-22, 14:27, Bo-Chen Chen wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> This is a new driver that supports the integrated DisplayPort phy for
> mediatek SoCs, especially the mt8195. The phy is integrated into the
> DisplayPort controller and will be created by the mtk-dp driver. This
> driver expects a struct regmap to be able to work on the same registers
> as the DisplayPort controller. It sets the device data to be the struct
> phy so that the DisplayPort controller can easily work with it.
> 
> The driver does not have any devicetree bindings because the datasheet
> does not list the controller and the phy as distinct units.
> 
> The interaction with the controller can be covered by the configure
> callback of the phy framework and its displayport parameters.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> [Bo-Chen: Modify reviewers' comments.]
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks

-- 
~Vinod
