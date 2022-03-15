Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14FDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 14:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349308AbiCOOgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 10:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349301AbiCOOgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:36:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9F127FED;
        Tue, 15 Mar 2022 07:35:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 27D741F442FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647354909;
        bh=E3ukLq6ZcAq9PS5OHfpqQ3LKEZJgSt680BJtcTlPhLA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O0TXtYSNxmt49cje7dGkaRV2m1l1WYGmbNUHT0zKQRF3UhQG+nD6lcet0hCN9M9NZ
         vPohtzBFiZ8cI/Ckflne5OLzy+t2ubD6v9HK6G1drGktLpAXt5JynjG5swTOdFjQic
         3V58KwmtAby4FMO/CNSfowXsrlix+vbEjPfIpkWWy3IHoPgtClruJKW8sAtu7aKs4T
         AD8YqW4eGiaraRbuPkBt/VyD8xXAy7A0heQ4pOlieDPIGVsWiG8vaiaR6PRAJ7aqNL
         WUvlj3r9tj4+KbZTDBNCCV8r24Nkp4I1jtvi0iHfX4U5C9KHUA5WdGrTeu58dlO2mM
         BnRgyLW29keBA==
Message-ID: <988150c9-ae32-bf86-195e-6b629bd4e469@collabora.com>
Date:   Tue, 15 Mar 2022 15:35:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 13/21] arm64: dts: mt8192: Add mipi_tx node
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
 <20220304130809.12924-14-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220304130809.12924-14-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/03/22 14:08, Allen-KH Cheng ha scritto:
> Add mipi_tx node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

