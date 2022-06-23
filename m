Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A4ECCA47F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 07:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiFWHc7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiFWHc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:32:57 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EA2C1B;
        Thu, 23 Jun 2022 00:32:54 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5057C447; Thu, 23 Jun 2022 09:32:52 +0200 (CEST)
Date:   Thu, 23 Jun 2022 09:32:46 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, yong.wu@mediatek.com,
        will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org, miles.chen@mediatek.com
Subject: Re: [PATCH v4 0/5] mtk_iommu: Specify phandles to infracfg and
 pericfg
Message-ID: <YrQXHmFXMVinjDw9@8bytes.org>
References: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
 <YrMc2EUBDIxnoWiB@8bytes.org>
 <4023cf19-601c-a2ba-85b0-450fb2df9401@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4023cf19-601c-a2ba-85b0-450fb2df9401@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Wed, Jun 22, 2022 at 04:12:47PM +0200, Matthias Brugger wrote:
> I wanted to check if you took also 3 and 4, as these should go through my
> tree. Unfortunately you haven't pushed your tree (yet). In case you took the
> whole series, can you please drop the dts patches. I'll apply them now on my
> v5.19-next/dts64 branch.

Yes, I applied the whole series, will drop patches 3 and 4 now.

Thanks,

	Joerg
