Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC5FC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 23:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiF2XMP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiF2XMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 19:12:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461FE13F5A;
        Wed, 29 Jun 2022 16:12:12 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ACD93660191F;
        Thu, 30 Jun 2022 00:12:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656544331;
        bh=HS3Kt0329f/B+ZtFOq/ujXFFz4n2v0LxjbObOAIfMA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DbyxYuRJTfKNb7dA/9wo+mdwmC3FHECEFj0TyXA7cMqF6Q3/4hk3IR93Nyra5SScy
         nlhQvDpxPhaIjBEa99hRyFKqAjlAdh0AawO5QR4uzndOPwMTjyalTbGzUvQBgK61ld
         rSzd09GEOXh5DGTkuIM7oU67lH2B21vaapR4yy+FDxReBo5Z3n8vNzTWRzrUBosF2I
         AI8M76DOBP/8UCGFFfxzRhwePa1//N0tDwZcPbB3moX0d4xP2vlqQHJiBXF0c+uCp+
         ZSCSVGuU6H6KESYKaAz9mN5hCwKFZJ5dpEJnY/2DIXudx+fCNO/NBbCUpR6PtC0URe
         1qjaj2u2ywnyQ==
Date:   Wed, 29 Jun 2022 19:12:05 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH 1/5] arm64: dts: mt8192: Add pwm node
Message-ID: <20220629231205.kgzvzqjyrh3xzgib@notapiano>
References: <20220629121358.19458-1-allen-kh.cheng@mediatek.com>
 <20220629121358.19458-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629121358.19458-2-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 08:13:54PM +0800, Allen-KH Cheng wrote:
> Add pwm node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
