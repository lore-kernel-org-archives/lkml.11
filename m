Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092EEC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Apr 2022 09:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiD1JwS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Apr 2022 05:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348560AbiD1Jjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:39:55 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E07972B8;
        Thu, 28 Apr 2022 02:36:41 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 37BE72FB; Thu, 28 Apr 2022 11:36:40 +0200 (CEST)
Date:   Thu, 28 Apr 2022 11:36:39 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: iommu: Drop client node in examples
Message-ID: <YmpgJwhAeDxugaYk@8bytes.org>
References: <20220422192104.2591462-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422192104.2591462-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 02:21:03PM -0500, Rob Herring wrote:
> There's no need to show consumer side in provider examples. The ones
> used here are undocumented or undocumented in schemas which results in
> warnings.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks Rob.
