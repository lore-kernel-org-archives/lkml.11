Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16F6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 14:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349465AbiCOOzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 10:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbiCOOzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:55:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E8B2898F;
        Tue, 15 Mar 2022 07:54:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id DA64A1F4305E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647356073;
        bh=eIrlImnsszc818O3+euA/0yi4B+s9IYLXKObZEOtXEk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C+Rf1ZFHf3p/MfmKhikakuDwUkemARip+mt7wtoE8algflEjjpeQwLLhCc86KT1uo
         luaUdW68Kz+wWqSpBkHXwh2ES7MgFjBLZTjj+6XyGfOu6ynuITL0/6A/6FLj428v5k
         8VB/xvXbwJbcr1Z/5UIiblsB6TkhjGjTKevv1tqEmaJHnarigML2M9tg5MbzOO22XP
         WDphQRkAB1lDDKwGr+LxydWCQb+jp9dUiYTrwWpd3PwHMRCu1xAWHrI3Vt6z9isfnt
         nVB3Zz5CJwxmD79Z1wIKaUGEZLd4HySwzgNdQvALSHX7u9BRMLKwqAQ28POUwNubrP
         ODe89QOtO0JJA==
Message-ID: <96783335-ef61-81a4-bfa0-380d81f84ae0@collabora.com>
Date:   Tue, 15 Mar 2022 15:54:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 20/21] arm64: dts: mt8192: Add gce info for display
 nodes
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
References: <20220304130809.12924-1-allen-kh.cheng@mediatek.com>
 <20220304130809.12924-21-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220304130809.12924-21-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/03/22 14:08, Allen-KH Cheng ha scritto:
> Add gce info for display nodes
> - It's required to get drivers' CMDQ support
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 

