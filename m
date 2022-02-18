Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF91C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 12:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiBRMzy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 07:55:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbiBRMzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:55:50 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484542B4614;
        Fri, 18 Feb 2022 04:55:22 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 632611F46910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188921;
        bh=EPiC567TIFwNwEo5C2DPJ8rGuw9NLCQAHV18pXSm2Bc=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=fEPY4GauWbcMLtGvjhm9gQCQU5NUBSDSaQxGTY1R4pS0JIFlfxpVs6l+QniNlV2OA
         YZvYmBkyix3JYbEyvNFtcFPq9RLrgzVSQpKXJD0ZkJomxjRPmhqsrJDNAl6AeYEnnx
         R5k5egSSRz2Rp1SmONYZKKb60Fgsb6Uxc2UT+4kmMQt2NONJtsCWlVm5vyA7dUdPcn
         AmuOHpvIKyKwsaRuKwn2a5Qy0h6z1QAux9fA9EXqLPeR/92sxzX630JVX5isaGud7O
         +zlRvK8AtvL7HSXgm2dxTioiiehQEdicKB6i8HnYaeCZJv5gepsmF2uwggeAuYOBoI
         fDxWt34/xLJoQ==
Message-ID: <736ee958-2326-f025-2c45-77c3d3e55edf@collabora.com>
Date:   Fri, 18 Feb 2022 13:55:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 04/23] arm64: dts: mt8192: Add gce node
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-5-allen-kh.cheng@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220218091633.9368-5-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/02/22 10:16, Allen-KH Cheng ha scritto:
> Add gce node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
