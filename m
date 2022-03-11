Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC9AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 10:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347725AbiCKKL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 05:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbiCKKLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:11:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489FAE0AFD;
        Fri, 11 Mar 2022 02:10:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E52EEB82A50;
        Fri, 11 Mar 2022 10:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5049C340E9;
        Fri, 11 Mar 2022 10:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646993449;
        bh=UNlxB0sw9S9WZBqxDtAPWSv0x1gln2Vs3cHIWadssgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDYZc04wj/c0Kax1fEmtDjejaj4I+twYkDHtY+5SYh4DXl60FjL2y09lEpRh7L4ul
         UPwy0cmTS2K+U7jXuOcFL6qCPiaZsncs2aaBLZ5opOZ78DhEFyt9Bv2mISuRixvmhN
         YecnqCRTkmkj8QXtv0bbT3HCGsV5Axxo/pbwSxeuFuxD2SfwMeR2b/xUDHA0hpzTlk
         ov4ICGfaNaOJ+LFtIk45dLot6GPB5n8W5g/MUm5ZMLBK+HoEz/f0yidG0LcSyzlr8C
         sbp7+WMpBt+vWWz7A4ObowUr7eS1HQJmHb/S+zIAXN4Om/9VIBuHIcTaJfzU5e5gF0
         7P5v9UkOur6cA==
Date:   Fri, 11 Mar 2022 15:40:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        long.cheng@mediatek.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] dt-bindings: dma: Convert mtk-uart-apdma to DT schema
Message-ID: <YisgJYOUfCVVhP9p@matsya>
References: <20220217095242.13761-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217095242.13761-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-02-22, 10:52, AngeloGioacchino Del Regno wrote:
> Convert the MediaTek UART APDMA Controller binding to DT schema.

Applied, thanks

-- 
~Vinod
