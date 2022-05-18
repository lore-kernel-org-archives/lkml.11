Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCFAC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 08:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiERIOy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 04:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiERIOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:14:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AC93982B;
        Wed, 18 May 2022 01:14:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AA4611F4204B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652861687;
        bh=bxhlZVwcajiZSFDXfD98BHfzwz+so3WTdIJAkwePssc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y9QnZsP/QoDnDEAOgvnBEzK6pLWaWobcj5rdgAxSDyduLrL0YZoWRhH/ffHzUtX8t
         LKEVbo6qtwxlfD+RUKGOK4r8UMyCnWtEdty3bPBbRDnFJk3snUJGFCyXC3+B4DLpLE
         Wor+uQgSmtlbNhFMP+TWFNF7iadBw24C9KVgNNoULgFR7hjXOuV6xQtdgyYvvEGLa6
         g8Ie3wFKfCq///es3Zu0XxdI7mbX3v3NcmL9qL/gY+piOIlhXb367bDJJrD198KQ5b
         3OvdJJtv94RG1i5xNZLLg5qbqFP28kKJaZ8xZ6s63MLkXA6Aer8qA9ah7Grc0PRLaW
         9qY9EgwPrPiBA==
Message-ID: <4ed63c3a-ec47-5801-ab89-b7d1a597c0da@collabora.com>
Date:   Wed, 18 May 2022 10:14:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 7/8] dt-bindings: iommu: mediatek: Require
 mediatek,infracfg for mt2712/8173
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     yong.wu@mediatek.com, joro@8bytes.org, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
 <20220517132107.195932-8-angelogioacchino.delregno@collabora.com>
 <20220518014143.GA2024242-robh@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220518014143.GA2024242-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/05/22 03:41, Rob Herring ha scritto:
> On Tue, May 17, 2022 at 03:21:06PM +0200, AngeloGioacchino Del Regno wrote:
>> Both MT2712 and MT8173 got a mediatek,infracfg phandle: add that to
>> the required properties for these SoCs to deprecate the old way of
>> looking for SoC-specific infracfg compatible in the entire devicetree.
> 
> Wait, what? If there's only one possible node that can match, I prefer
> the 'old way'. Until we implemented a phandle cache, searching the
> entire tree was how phandle lookups worked too, so not any better.
> 
> But if this makes things more consistent,
> 
> Acked-by: Rob Herring <robh@kernel.org>


Hello Rob,

This makes things definitely more consistent, as it's done like that on
mtk-pm-domains and other mtk drivers as well.

The main reason why this phandle is useful, here and in other drivers, is
that we're seeing a list of compatibles that is growing more and more, so
you see stuff like (mockup names warning):

switch (some_model)
case MT1000:
	p = "mediatek,mt1000-infracfg";
	break;
case MT1001:
	p = "mediatek,mt1001-infracfg";
	break;
case MT1002:
	p = "mediatek,mt1002-infracfg";
	break;
.....add another 20 SoCs, replicate this switch for 4/5 drivers....

and this is why I want the mtk_iommu driver to also get that phandle like
some other drivers are already doing.

By the way, thanks for the ack!

Regards,
Angelo
