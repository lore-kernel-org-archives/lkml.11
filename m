Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A7AC4332F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 08:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbiEII1H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 04:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbiEIISF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:18:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A473158FA7;
        Mon,  9 May 2022 01:14:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CA6D11F43962
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652083700;
        bh=Ci9YeTkiERXxEyN0uHAckbygOm03b3gSoys0gEWkatg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lu6CSgcBkNxkj+rtHKpudaiQFms5D8/IHGzvYxKIceXMeY9ow6WkzNphJXQzVG8/H
         YpIvmIWMc0Lsv+jRPUAQOYH4/qX9Eo6ZW7mfibHFgBQCAg/aVZbqKTbi+m+80VsR3f
         XBSAXXqjI4YIqEl/A3S+eYyOUYdhakyTDvlVx7lapZCuHTGJsrELSEWusIG5LdpcFN
         GQdwqMj8BN+Bg1hRfYiKmi5j1t7bzVn1VJ5T7sNzNmIBoRpCfKkinbu7PGFOwhcF7C
         KxlpzMGUkALypqUucXwngY+oyZwauCCXuYIKIcuA88LxNVU/rN+bnFWnheTFif05o2
         vLPbXmcGVgGEQ==
Message-ID: <40d49a43-9e90-7af0-5af3-5a61a384e442@collabora.com>
Date:   Mon, 9 May 2022 10:08:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 2/2] phy: mediatek: Add PCIe PHY driver
Content-Language: en-US
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Wei-Shun Chang <weishunc@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rex-bc.chen@mediatek.com, randy.wu@mediatek.com,
        jieyy.yang@mediatek.com, chuanjia.liu@mediatek.com,
        qizhong.cheng@mediatek.com, jian.yang@mediatek.com
References: <20220507060621.32252-1-jianjun.wang@mediatek.com>
 <20220507060621.32252-3-jianjun.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220507060621.32252-3-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/05/22 08:06, Jianjun Wang ha scritto:
> Add PCIe GEN3 PHY driver support on MediaTek chipsets.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

