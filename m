Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26051C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 22:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245700AbiCGWFV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 17:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242938AbiCGWFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:05:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F23F43493
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 14:04:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3D2660E71
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 22:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BB8C340EF;
        Mon,  7 Mar 2022 22:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646690656;
        bh=rrhY4HAmaRJFvQoiqIdXtLlfW7AJiDKMLotu2Ifg18s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=inlpSzhzAWyLMaSoW7Mywia7NOTctO2+k7B5o1MN3RvwB/x7DEF+k9gaP6KvCYHgq
         vjGhyy2PRYlJI4n9d9157kReibTU075+LyFefnhgz7OgJoPg9lTPJU8pORA2bT5ok2
         WRr6TO9nDhCpEXXL9cDd7kr11CAqV/t81sSXscdJGpvDy2KOCqR3x7hEkP9tDAzmeA
         LH1g1MuMCMMBZYDtQsTXVNmzpMi/06RT/p2FCcDO2rBKXB8uJboor7g6payJMBe918
         WCDOKlmgi5zyaRT0JHD8oHIfk0o8dkmWfeU+VyhImZ6G9ez+WfsVGfiLE3Yh16lAHZ
         wBk4YrFHpXPrQ==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-arm-kernel@lists.infradead.org,
        Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: Re: [PATCH v3] arm64: Do not defer reserve_crashkernel() for platforms with no DMA memory zones
Date:   Mon,  7 Mar 2022 22:03:37 +0000
Message-Id: <164668976328.3277938.14864732241675916199.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1646242689-20744-1-git-send-email-vijayb@linux.microsoft.com>
References: <1646242689-20744-1-git-send-email-vijayb@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 09:38:09 -0800, Vijay Balakrishna wrote:
> The following patches resulted in deferring crash kernel reservation to
> mem_init(), mainly aimed at platforms with DMA memory zones (no IOMMU),
> in particular Raspberry Pi 4.
> 
> commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
> commit 8424ecdde7df ("arm64: mm: Set ZONE_DMA size based on devicetree's dma-ranges")
> commit 0a30c53573b0 ("arm64: mm: Move reserve_crashkernel() into mem_init()")
> commit 2687275a5843 ("arm64: Force NO_BLOCK_MAPPINGS if crashkernel reservation is required")
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Do not defer reserve_crashkernel() for platforms with no DMA memory zones
      https://git.kernel.org/arm64/c/90527221b7ad

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
