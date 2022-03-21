Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCB1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 12:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347150AbiCUMFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 08:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344372AbiCUMFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:05:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B827659B;
        Mon, 21 Mar 2022 05:04:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6D4CC1F41AD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647864250;
        bh=juB9ncatAw5tBbLICYJf9adbDnlB0mhtknonKfRigfo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LNfk/yFRVJb+YGgQfgF6LW7EDRJBX/qj4Tqt0oeQIhrJG5PlV26AG65D8k0UweCP9
         wp9rcHBOA5mCaR7g7UZvkZWlmeKyJ42C6TQhqqPXpmCinlMVxfswclq7dwKphWGIax
         DM896VSxIDIoDv44L1/ZA6sgvV0iwwsdIGe009LNef/1AFBftocX2ntjFdAQk+hVwO
         n2jZzjgQ73CdAdWYkTMP4yl0FMadeWzc2bO0CHCjBSs+uWz6t0d+NYyND8LjyoXsFN
         dJnywNHz+PQFaF1+Gd9rb3NqC5a8CI8LMmw3AtfCuMXWeL9xc3g+gzCh5+XT2a1/p1
         KXOv1rrnPvIsg==
Message-ID: <c1dfb526-1daf-5c14-2e4e-9ac2785eec20@collabora.com>
Date:   Mon, 21 Mar 2022 13:04:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 22/22] arm64: dts: mt8192: Add pwm node
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
 <20220318144534.17996-23-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220318144534.17996-23-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/03/22 15:45, Allen-KH Cheng ha scritto:
> Add pwm node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
