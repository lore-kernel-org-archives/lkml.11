Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FECC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 12:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbiBRM44 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 07:56:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbiBRM4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:56:43 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8632B73F7;
        Fri, 18 Feb 2022 04:56:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D26C11F4241F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188967;
        bh=3cKLFODejquWIHPYAw3eHu3koF0olH3bhXMFQxUCMeQ=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=YdaWjvljX5wM0iuL780yoYpWHTPyevhyjVgBu76atMBDyWcbWJVZTtPzY8yDDlkDZ
         8EcEtPwi7F5UdHZAlX1azsI4QR4etvV5Kanoj6hCs2jN0ExRhFZoxJFbgoAE2hp8pK
         MQpmHExBri4qZpL9DNV2ylRafTjwkCeeWd3IUkTobMFrJv3la+aYNLQ0LNJu2dowOV
         1FsVmOIGiJJNI8RVba7QBLbFW0zBYF82hi5MZ9o/6ZWG3SjbZJCEh8EGI9r+tZQ37Y
         lEJ+h5HMQOedCvwasrPbewyHE2aqsOavBOJ7jHrjmCWMGEcIV4f0l3NaRr8pdUwvj5
         iE9pID0eBecAg==
Message-ID: <8b87bbc1-d6b2-a98f-ee02-a7ac57c5607e@collabora.com>
Date:   Fri, 18 Feb 2022 13:56:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 16/23] arm64: dts: mt8192: Add H264 venc device node
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
 <20220218091633.9368-17-allen-kh.cheng@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220218091633.9368-17-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/02/22 10:16, Allen-KH Cheng ha scritto:
> Adds H264 venc node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

