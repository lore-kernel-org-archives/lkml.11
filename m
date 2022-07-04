Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7439EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Jul 2022 11:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiGDLsZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Jul 2022 07:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiGDLrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:47:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2CE1181B;
        Mon,  4 Jul 2022 04:47:50 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D60B4660198A;
        Mon,  4 Jul 2022 12:47:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656935269;
        bh=wLFTtd7NM2OiqRe3Wpx0kZo23G8XtTUE22e3isGy1cc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=akB1lSbnLVOLpjoz/BhcoNtVQjHxTEtX/W0EZ+Tjyi/LjvXczQQlQK/1y5RV4suCq
         ShgaoIB92g1Ha69cx8aajDIyXSWIDAZI/ooFWX4V3KtYfco4gjcwvqxwnVhV5SdJ3M
         YtsO64LoEF957q8pS/74l5DY22c/uzwoDPrWZZ+Ff69mqWavN3ZNe0ngXohvH5sBfE
         zfXjpEwCWW0mkBvWoaIT5pCCvey/NdwDpLw3gI6AKEbnqAdSgRwOmfPvD/Jc6vsKe1
         H6VLyCcbVAlAP6IXoe/IVz+Dud00BQFLpwsXDX2FI1QhVRpfZlwSOFvXyGT/ZnI4E3
         KIezSVM0prezg==
Message-ID: <1ceb790e-5b99-30a2-0d42-8b94c31d3eb6@collabora.com>
Date:   Mon, 4 Jul 2022 13:47:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 5/6] arm64: dts: mt8192: Add dsi node
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20220701090547.21429-1-allen-kh.cheng@mediatek.com>
 <20220701090547.21429-6-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220701090547.21429-6-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/07/22 11:05, Allen-KH Cheng ha scritto:
> Add dsi node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

