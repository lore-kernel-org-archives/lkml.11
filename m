Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CCFC433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 12:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347197AbiCUMGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 08:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347171AbiCUMGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:06:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9662655752;
        Mon, 21 Mar 2022 05:04:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id DC7991F41AD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647864266;
        bh=XxxTOXcmQzzf/utFY/eul8IymAsv627cSR3PPYKHUsw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fTtEJerib6lvh9W+wETb2/+RMmu7yejkqOA3/sUfJI61TT+daI4wp6Sj08pNWoUYl
         mu5Aul3+1ciTmuVJ/46YKUNnxR3gfEdVsB1wUh0fRaaV9Vvv+TIOz7WehoiHFwK9VV
         n0w8cy+xYdJcfrcDk6hn61DZXHG7opxb1hjZeDlfQYI6cF7umsu0QnLxpam14GHfrw
         Fns3AmiTVCoH3sf1E5jzYv4qQeDPlkXiHwZgL8LvYMc1NvPM2N1t3Yd2tdFRl3R6q/
         OfQW41q0HV4Hq3gfUY5p4X8cCJg/Ls2C+ktpQyJz4fMHmzWuKHe6PFtzCX7SPiP4SF
         XWbaC2qnRJ0Tg==
Message-ID: <1ffc7d8f-466e-22ac-36a8-196d7c5d32d3@collabora.com>
Date:   Mon, 21 Mar 2022 13:04:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 13/22] arm64: dts: mt8192: Add mipi_tx node
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-14-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220318144534.17996-14-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/03/22 15:45, Allen-KH Cheng ha scritto:
> Add mipi_tx node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
