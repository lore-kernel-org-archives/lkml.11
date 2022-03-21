Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127F2C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 12:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346267AbiCUMGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 08:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347151AbiCUMFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:05:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD2354FB9;
        Mon, 21 Mar 2022 05:04:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6E3B21F43132
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647864262;
        bh=xzzF947HKeOJPunjfbRNF+C7W9FjijE2ZgcP9tgWNIc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nTZKRERVnPRoZx4UnIXCoj8N0Vl2wLYvhl6t7Ni0av/blmzWqCwFJvD91ih0XIlKX
         0YX51qIonRqfwAK98gVdn3JdRgqKC5WWp14xqbgjfLHR0O2q0yDDY9HqCFlai23buu
         aSHMIavGZqVuQ/G1zuvl5I4Uwpyp4NRgPmHgUQFlNMfPMWeG9eqPjPgGQ5+5Xvuc8d
         ZcgBVs/6jF/owIJgF3F3xBX4YBGA+iB4ZJu2DTZSZA4rZJjG8VTqw7uW9CnuCxYhFB
         fXi+x3DnyIRe7LTDHOyy6RmnUgYou+W2vgmOTythwVC5S7l5mboCUt8z2xB2zp0/T4
         fcwr3+qqGdF9A==
Message-ID: <43f6046e-4c26-e78b-5917-d1dd40e82c57@collabora.com>
Date:   Mon, 21 Mar 2022 13:04:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 16/22] arm64: dts: mt8192: Add vcodec lat and core
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
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-17-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220318144534.17996-17-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/03/22 15:45, Allen-KH Cheng ha scritto:
> Add vcodec lat and core nodes for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 61 ++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
