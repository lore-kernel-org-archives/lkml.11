Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0A0C433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 May 2022 12:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiECMlO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 08:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbiECMlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:41:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494852B253;
        Tue,  3 May 2022 05:37:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4F5261F43133
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651581458;
        bh=7VuOPvGY7gfJ1yQFSlWvOMk6/J1XVQumw5PI167sPuQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D3qsFLgG/nlxwB/bxz9aDy4RGpf4k8RSj8GlTpew+AlGOXFco0SNvdi6KQFWSRoev
         EbaZ1YyjWp1t0y3421SwoqnY+d72dlsSHW5MVlJAltDLOolfdj21w2atJE/wKCBmpD
         Dlvc2WStmJLD66Lao0Qvhx2fQQRrtxKPTQwvcfEkl7uwOIOTCrRPYJ34gMYVSwtvfS
         b2hO3o++49k/vrX0vw+F2gbzpK8LSGmwqK/kIjUbLlR8DNAKVWOUoHyZk20V9jw8Ie
         jjcU/8hfQ7ZR+tb7Nd3luwmaOJhNOqfEHAK+McWe49vTC6MHmdqLRc63WbZ81fy54y
         ZkkPl4dXN4Gpw==
Message-ID: <d09c4605-e4c5-bcd4-8212-b1e977b0e3f3@collabora.com>
Date:   Tue, 3 May 2022 14:37:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 12/16] dt-bindings: arm: mediatek: Add #reset-cells
 property for MT8192/MT8195
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, chun-jie.chen@mediatek.com,
        wenst@chromium.org, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220503093856.22250-1-rex-bc.chen@mediatek.com>
 <20220503093856.22250-13-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220503093856.22250-13-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/05/22 11:38, Rex-BC Chen ha scritto:
> We will use the infra_ao reset which is defined in mt8192-sys-clock
> and mt8195-sys-clock.
> The value of reset-cells is 1.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

