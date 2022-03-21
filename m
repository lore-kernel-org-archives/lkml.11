Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB100C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 12:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347154AbiCUMFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 08:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346449AbiCUMFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:05:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1E344757;
        Mon, 21 Mar 2022 05:04:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CE1361F42BDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647864252;
        bh=WbFzhlbNau/l00k2LRhQPa7MQnCfmYTQC+k5zFwh3WQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GQZUMmB49+tfChFQRdydbY3ytMIMzjIoWX0HvG3oCV6BHoE/cSf+lM3lr8lqK+YMN
         OutUpC0/NJby/DhsLru2H70dNKBVXx1npTprjCDhQ0ieItuGZapyefnPi7PdFG9nhI
         98dPI6cvm9cnY+39MpNPUFd9sL2cR54Tw+SkJt5GLXbPdPs9qVdt3F6cPZ+R5eqt4+
         q5h3Dah6JGc7kv+tPQUtYhK8xSRe6tr3WK9txWVDK3bC8HwxHlHtC0PVYc4qRg87py
         vNKQM1y2klYMBSsVJvb+HSWF5FTb2mnm6iED2Wembc1FJAJZOG/E8oE9z5w53/l3cE
         ACOitAZDpyjdQ==
Message-ID: <d4635ac8-5510-844b-caa9-19c1786a5605@collabora.com>
Date:   Mon, 21 Mar 2022 13:04:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 20/22] arm64: dts: mt8192: Add dsi node
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
 <20220318144534.17996-21-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220318144534.17996-21-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/03/22 15:45, Allen-KH Cheng ha scritto:
> Add dsi ndoe for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
