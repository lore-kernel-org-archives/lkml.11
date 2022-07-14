Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA02DC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 12:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbiGNMgh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 08:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239386AbiGNMgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:36:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F0A5D0D0;
        Thu, 14 Jul 2022 05:36:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 77FDD6601A44;
        Thu, 14 Jul 2022 13:36:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657802183;
        bh=1boGSd3E5BlI+pti7MwLyV2DGEOWbsbxTHo+R9EUnYA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W37a7cxW5UyPq6hsxX97YLWsqqfyDVHFujtsLTl2NHQ9vnTX/NM+U3q56fssn9iOh
         Twg43jhiBJrL4N8P/qXcv2VG1XT4rUtlYs9WnPHmsga3mddoNZJRwipU7nTwCmof+C
         KjXa+4niI3WIxPrdSbLsYygLSRluZ+bgOnL86DL6qL9eUv5enMtmzHTdwQiYBW3UPj
         dYAyXu83AGu+QgTbeuh43erpV4xkb/N83uRRwz3RRwFIfGDWPFd41W6nO2uqRsNPe9
         GMmvUUVMPphEcv/WLJYhbCmo2qD+Eci7ZknnaWn7yiHXzMCUVxMSFRL/hQajerqrps
         5GZqaz03B8SYw==
Message-ID: <3977c04a-07d4-a8f8-5086-cd1c37dea21f@collabora.com>
Date:   Thu, 14 Jul 2022 14:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 19/19] arm64: dts: mt8195: Add display node for vdosys0
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
References: <20220714122837.20094-1-tinghan.shen@mediatek.com>
 <20220714122837.20094-20-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220714122837.20094-20-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/07/22 14:28, Tinghan Shen ha scritto:
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> 
> Add display node for vdosys0 of mt8195.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

