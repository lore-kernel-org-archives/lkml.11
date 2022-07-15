Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701DBC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 08:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiGOIb1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 04:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiGOIbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:31:25 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD4B80517
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:31:24 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 204041F88; Fri, 15 Jul 2022 10:31:22 +0200 (CEST)
Date:   Fri, 15 Jul 2022 10:31:21 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] iommu/exynos: Add basic support for SysMMU v7
Message-ID: <YtEl2YivyW4iLO//@8bytes.org>
References: <20220714165550.8884-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714165550.8884-1-semen.protsenko@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 07:55:44PM +0300, Sam Protsenko wrote:
> Sam Protsenko (6):
>   iommu/exynos: Reuse SysMMU constants for page size and order
>   iommu/exynos: Handle failed IOMMU device registration properly
>   iommu/exynos: Set correct dma mask for SysMMU v5+
>   iommu/exynos: Abstract non-common registers on different variants
>   iommu/exynos: Add SysMMU v7 register set
>   iommu/exynos: Enable default VM instance on SysMMU v7

Applied, thanks.
