Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99353C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 23 May 2022 11:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiEWLLi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 07:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbiEWLLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:11:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8B66414
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:11:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E65DF1F4306C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653304291;
        bh=T/12/ST+THUvfsBk94S7wmBu9DrZ1MADcsRqx52qnt0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Eue38aHpm4LkUCy9sf7ibt5DbkFjIy6LVmsGQod4zt1XcfyzZQgUSG5IQ1rIxSZN9
         h4Y1HMHwKikZN6dYFhZqQyshSol3KfKoRzJTu2SOu9U2TWvru95A+D1G1+RsW+o3sb
         pHLpAlJJe7fs1vjQBalkndiaKhWzj13oKh/abD/+cqP6i9X5LTbjQ1+I7/ZdI/KmNN
         oOB0W+u3ztXF/EIQ3MF7uJS5es5/2hZqsVNXEoYdX254XraDic2KvXnVDo3naS8c+5
         b1GdtwtZ0wEb+03IynCRHqiBUeG1TPNcCuuzs2iE9fhcpzzc1rDB05nCZSjnSz4LxI
         KH5ZX5cfF+N+A==
Message-ID: <2af6726c-5ff0-07c9-05de-1a67a7358ba2@collabora.com>
Date:   Mon, 23 May 2022 13:11:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [v3 PATCH] soc: mediatek: Add support always on flag
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Min Guo <min.guo@mediatek.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20220520030340.25444-1-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220520030340.25444-1-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/05/22 05:03, Chunfeng Yun ha scritto:
> There is a t-phy shared by PCIe and USB3 on mt8195, if the t-phy is
> used by PCIe, when power off its mtcmos, need software reset it
> (workaround way, usually hardware do it, but has an issue on mt8195),
> but it has side effect to USB2 phy(works with USB3 phy to support
> USB3.2 Gen1), so add support GENPD_FLAG_ALWAYS_ON flag, and make its
> power always on;
> Another reason is that USB3.2 Gen1/2 need keep power always on when
> support runtime-pm due to hardware limitation until now;
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

All these quirks are making this situation very unfortunate. I don't
really like setting GENPD_FLAG_ALWAYS_ON, but I recognize that there's
nothing else to do to fix that.

After all, this power domain is going to stay up for >=95% of the time
anyway even if we handle this in the various drivers instead of setting
it as always on and.. in the end, it's not worth the effort if we're
saving power in the order of a few microamps per hour.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


