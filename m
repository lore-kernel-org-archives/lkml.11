Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66121C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Mar 2022 07:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiCFHxf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Mar 2022 02:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiCFHxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 02:53:31 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E935C2672
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 23:52:38 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KBDMk5zv9z4xZq;
        Sun,  6 Mar 2022 18:52:34 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     mopsfelder@gmail.com, Paul Mackerras <paulus@samba.org>,
        "Erhard F ." <erhard_f@mailbox.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Nick Child <nick.child@ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <20220301204743.45133-1-muriloo@linux.ibm.com>
References: <20220301204743.45133-1-muriloo@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/64s: Fix build failure when CONFIG_PPC_64S_HASH_MMU is not set
Message-Id: <164655313998.2845689.17526112679322960530.b4-ty@ellerman.id.au>
Date:   Sun, 06 Mar 2022 18:52:19 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022 17:47:43 -0300, Murilo Opsfelder Araujo wrote:
> The following build failure occurs when CONFIG_PPC_64S_HASH_MMU is not
> set:
> 
>     arch/powerpc/kernel/setup_64.c: In function ‘setup_per_cpu_areas’:
>     arch/powerpc/kernel/setup_64.c:811:21: error: ‘mmu_linear_psize’ undeclared (first use in this function); did you mean ‘mmu_virtual_psize’?
>       811 |                 if (mmu_linear_psize == MMU_PAGE_4K)
>           |                     ^~~~~~~~~~~~~~~~
>           |                     mmu_virtual_psize
>     arch/powerpc/kernel/setup_64.c:811:21: note: each undeclared identifier is reported only once for each function it appears in
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/64s: Fix build failure when CONFIG_PPC_64S_HASH_MMU is not set
      https://git.kernel.org/powerpc/c/58dbe9b373df2828d873b1c0e5afc77485b2f376

cheers
