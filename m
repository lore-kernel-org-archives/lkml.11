Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F43C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 12:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbiBRM4G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 07:56:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiBRMz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:55:59 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113752B4629;
        Fri, 18 Feb 2022 04:55:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1883E1F469B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188930;
        bh=Qe1GV5ntwY224GpH3mDeY8hjTlrLQF+I8Rv72GgKwbo=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=MNy2YI6n3JxkNurvi4QeqdE2LKT3dAuu2ykGswNiVWheZJ7gMaEZSdBgTchM4Gd1x
         suU71IPup/ANknva4rh/HsXevDQWZjnSXLiiOVql7cL+isT7q0WGzx8D1xZt3Ozc0f
         DO/0jHXXMQauhq0nYlsklak6dsIn5ope30BItvUvd2WOrBtitu3EB29fTEGjFW0WUt
         KWCNCaKHY0XD2biZrBj3oweGRPs7U1oRQ6Sd27HjL7d1gnOesQNg28ZUhf8aCSTFrr
         FIQPpoNmgREb1qMn/iSqv9cMNSAq6xdOp+txcR+8qxr8E5CcHz5qK/roATl1IsSHCk
         RpMVO1OQ6YQXg==
Message-ID: <6d9716bc-e78b-22bd-fb76-9d82c360e046@collabora.com>
Date:   Fri, 18 Feb 2022 13:55:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 01/23] arm64: dts: mt8192: Add power domains controller
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
 <20220218091633.9368-2-allen-kh.cheng@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220218091633.9368-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/02/22 10:16, Allen-KH Cheng ha scritto:
> Add power domains controller node for SoC mt8192.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

