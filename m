Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA421C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 10:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbiBYKBp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 05:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiBYKBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:01:43 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC807186B9B;
        Fri, 25 Feb 2022 02:01:11 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4A1691F45ACF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645783270;
        bh=D5PHixB15iSbClBF6eHaM6GctJ2rJbHgaj2nP9Jozuk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mjVcXZnNlW9ZVL7GKoFEZzXM0b+Zr6KGezNedLUYcvvMGbPWl61e2mDXP3oNgdZSv
         voYqQWRBgW1JkWT8kXgZoT6rqFd/CVPNVQLJdivWoqHH0q9qoQkm3KA1cvAWH5IHwv
         jnFV4BvrBaYD13EFrQTs5WpgCrakuVkeyAv+gbGLEn7WURu/J11Ex4lGF/5Jvh9v3v
         RHUDLjQ33tO9C6cqh/ojf7YGSz5EcyBWv3DnaclIzdp6/RFiIbeqw/GZsPtTiFamnX
         4KOQigzfY7zB1futUMHMfJA7Ai9C0+APpG3eDmfyvj3zfqUnLrn8KRi1iEEEjDvXco
         vtG97qB46Fe3A==
Message-ID: <ae3e077b-2e3a-8ca3-d359-040c5288f2c8@collabora.com>
Date:   Fri, 25 Feb 2022 11:01:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] arm64: dts: mt8195: add display node for vdosys0
Content-Language: en-US
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        maciej.szmigiero@oracle.com, David Matlack <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org,
        chunfeng.yun@mediatek.com, Seiya Wang <seiya.wang@mediatek.com>,
        moudy.ho@mediatek.com, roy-cw.yeh@mediatek.com,
        nancy.lin@mediatek.com, singo.chang@mediatek.com,
        Macpaul.Lin@mediatek.com
References: <20220225021535.2655-1-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220225021535.2655-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/02/22 03:15, jason-jh.lin ha scritto:
> Add display node for vdosys0.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
> This patch depends on series [1]
> [1] Add Mediatek Soc DRM (vdosys0) support for mt8195
> - https://patchwork.kernel.org/project/linux-mediatek/list/?series=608548
> 
> This patch is based on [2][3][4]
> 
> [2] arm64: dts: Add mediatek SoC mt8195 and evaluation board
> - https://patchwork.kernel.org/project/linux-mediatek/patch/20220112114724.1953-4-tinghan.shen@mediatek.com/
> [3] arm64: dts: mt8195: add IOMMU and smi nodes
> - https://patchwork.kernel.org/project/linux-mediatek/patch/20210615173233.26682-15-tinghan.shen@mediatek.com/
> [4] arm64: dts: mt8195: add gce node
> - https://patchwork.kernel.org/project/linux-mediatek/patch/20220126090109.32143-1-jason-jh.lin@mediatek.com/
> ---
> Hi Angelo,
> 
> I'm sorry I couldn't find your last reply mail, so I reply you so late.
> 
> Thanks for the reviews!
> I have fixed them.
> 
> Regards,
> Jason-JH.Lin

Hi Jason-JH,

no worries about that. Thank you for sending a v2.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 123 +++++++++++++++++++++++
>   1 file changed, 123 insertions(+)
> 
