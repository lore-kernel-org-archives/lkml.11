Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC12BECAAD2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 16:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiH2QHf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 12:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiH2QHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:07:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE628307A;
        Mon, 29 Aug 2022 09:07:31 -0700 (PDT)
Received: from notapiano (unknown [70.107.189.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DFD136601E65;
        Mon, 29 Aug 2022 17:07:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661789250;
        bh=HKidM7v19MiruZdK7/phGu4UFG+Bzp83idEhdT1R2Dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OT2U9NQDjXeDnOkz1Z39vD5Nf+z4Z9jS1wx8h5+pT7NtcZvECNuxYrfd/voAgOgBZ
         8I1z90Am4d6er5TdD6+T7ESofbmiBZJM9kUYeYtBr5bbzN6EwxPgg3kBoQhr3JAgRr
         RC43KWcYUHdjpEmiCOSSrYsn+pUHNe0QRkNnAdv2Y93GiJ5Y7MJB5IjSyDzuZbNtUy
         j52gPs7oLwmcnp2j6hWe1q0hbJRii70NAu9LINpDQGNFe5yncFdCLpaSoklawrApTO
         Id2BObeIQHLkDYDkjaxmdbdzL1gIrcxWPb6/4ET2rGez3H5FuJZVqMgXQBb0z+/oyY
         9oEnIWheuaJhQ==
Date:   Mon, 29 Aug 2022 12:07:24 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>, hsinyi@chromium.org
Subject: Re: [PATCH v15] arm64: dts: Add MediaTek MT8186 dts and evaluation
 board and Makefile
Message-ID: <20220829160724.xfbqxv7fs6ilr74u@notapiano>
References: <20220825170448.17024-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220825170448.17024-1-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 01:04:48AM +0800, Allen-KH Cheng wrote:
> MT8186 is a SoC based on 64bit ARMv8 architecture. It contains 6 CA55
> and 2 CA76 cores. MT8186 share many HW IP with MT65xx series.
> 
> We add basic chip support for MediaTek MT8186 on evaluation board.
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
