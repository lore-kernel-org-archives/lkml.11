Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C8BC433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 08:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347133AbiETIdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 04:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347178AbiETIci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:32:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90ED15A76C;
        Fri, 20 May 2022 01:31:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1C7681F46108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653035512;
        bh=QRFxM5xnexzlS51zoP6W7RzQXPnornFvrWlpoug6lkM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=An3qIq16ZokHIpyt0U5J8hp8A37HfFC8qTPcSum+dVEkQWYWzWAi112LA7A18DTDV
         oKtn5ik1JNUz1RWNBQ6duQy9MzT7cuAj5zwwopbR+bGtsI8JE+9gvJ830z0yCDVJ60
         W873v4TsN8LHjxGefnFIx/sYKuEOBYnJ2lHF6Y34sqrEagrTT+T5jj+Gt1C053ricX
         QxfE6hcSdp69583+3ale3LG6eSPsMyhlvO98IThkVy8z01SZAZHVexp6D5vLAGw+hg
         PuDNWuPIbLQ5gklay2nAqpqZQ110h4n46KGkwRp38+CWHO2BFDd94Dmvhnho9XznOR
         6+6+dta7/ePkw==
Message-ID: <13f49bf1-6623-eea8-0563-466876db4eb3@collabora.com>
Date:   Fri, 20 May 2022 10:31:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/6] clk: mediatek: gate: Export
 mtk_clk_register_gates_with_dev
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220519134728.456643-1-y.oudjana@protonmail.com>
 <20220519134728.456643-2-y.oudjana@protonmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220519134728.456643-2-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/05/22 15:47, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> This allows it to be used in drivers built as modules.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Thumbs up!

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

