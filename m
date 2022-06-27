Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167D0C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 13:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbiF0NCZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 09:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbiF0NCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:02:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF2D120A3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:01:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9CBADCE19A6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C9CC341CB;
        Mon, 27 Jun 2022 13:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656334857;
        bh=hreBI8EgJFm06gBn+LIBkI3qYVbQdetQMsfgmAVbTvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DcLGnfytx0Fz1gXcLEfUbJS+NsSbmkvSiV1vBZtYodFFjKyugRqV2zK+H4kqnS89j
         BAL2s1TclOqFwuX8Px9TvtfArm0FafMiUzgAyc0AIT3i6bRmMksDxe16zsuO0RC240
         WYPaeyxdLrRUP42ajEz/ScYCgeJvmTN/iFQ2SO472YIJDdufJJxVNBRktBDnpdex3G
         i1aN7CAmV3aBD/5tZcQZr5VOZqd+oSaZ3VGGRRM+Wi5PKO9amyVquoHEyWMXSootJP
         Osyo3L8mRBgWhnLf8s/3nneh89YiOViJU+5oYn2ggQwBK5i/ylBYhgZSFPGGSBVdJk
         Az+KS58lj+lQw==
From:   Will Deacon <will@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        hch@infradead.org, arnd@arndb.de, linux-mm@kvack.org,
        anshuman.khandual@arm.com
Subject: Re: [PATCH v5 0/6] arm64: Cleanup ioremap() and support ioremap_prot()
Date:   Mon, 27 Jun 2022 14:00:44 +0100
Message-Id: <165632887130.3614125.5739508840825390970.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220607125027.44946-1-wangkefeng.wang@huawei.com>
References: <20220607125027.44946-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 20:50:21 +0800, Kefeng Wang wrote:
> 1. Enhance generic ioremap to make it more useful.
> 2. Let's arm64 use GENERIC_IOREMAP to cleanup code.
> 3. Support HAVE_IOREMAP_PROT on arm64, which enable generic_access_phys(),
>    it is useful when debug(eg, gdb) via access_process_vm device memory
>    infrastructure.
> 
> v5:
> - break long lines(> 80 cols), per Christoph Hellwig
> - move is_vmalloc_addr() check from arm64 into generic ioremap, per
>   Christoph Hellwig
> - make arm64's ioremap_cache as an inline function, per Christoph
> - keep changes simple, make ioremap/iounmap_allowed return bool, per
>   Baoquan He
> - simplify use 'void *' instead of 'void __iomem *' in iounmap, then
>   drop __force annotation
> 
> [...]

Applied to arm64 (for-next/ioremap), thanks!

[1/6] ARM: mm: kill unused runtime hook arch_iounmap()
      https://git.kernel.org/arm64/c/d803336abdbc
[2/6] mm: ioremap: Use more sensibly name in ioremap_prot()
      https://git.kernel.org/arm64/c/abc5992b9dd0
[3/6] mm: ioremap: Setup phys_addr of struct vm_struct
      https://git.kernel.org/arm64/c/a14fff1c0379
[4/6] mm: ioremap: Add ioremap/iounmap_allowed()
      https://git.kernel.org/arm64/c/18e780b4e6ab
[5/6] arm64: mm: Convert to GENERIC_IOREMAP
      https://git.kernel.org/arm64/c/f23eab0bfaef
[6/6] arm64: Add HAVE_IOREMAP_PROT support
      https://git.kernel.org/arm64/c/893dea9ccd08

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
