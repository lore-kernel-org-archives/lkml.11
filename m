Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C0DC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 10:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiCLKb7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Mar 2022 05:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiCLKb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 05:31:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E0C23BF3D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 02:30:52 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KFzbb1NRlz4xcl;
        Sat, 12 Mar 2022 21:30:51 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <3ed660a585df2080ea8412ec20fbf652f5bf013a.1646413435.git.christophe.leroy@csgroup.eu>
References: <3ed660a585df2080ea8412ec20fbf652f5bf013a.1646413435.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/4] powerpc: Cleanup asm-prototypes.c
Message-Id: <164708098372.827774.13045777419131446755.b4-ty@ellerman.id.au>
Date:   Sat, 12 Mar 2022 21:29:43 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022 18:04:02 +0100, Christophe Leroy wrote:
> Last call to sys_swapcontext() from ASM was removed by
> commit fbcee2ebe8ed ("powerpc/32: Always save non volatile GPRs at
> syscall entry")
> 
> sys_debug_setcontext() prototype not needed anymore since
> commit f3675644e172 ("powerpc/syscalls: signal_{32, 64} - switch
> to SYSCALL_DEFINE")
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc: Cleanup asm-prototypes.c
      https://git.kernel.org/powerpc/c/e86debbbb5f89c2575110cfdce89d1820577aa94
[2/4] powerpc/smp: Declare current_set static
      https://git.kernel.org/powerpc/c/e15c703be48edc3b2f96b66d4f548dc88b44266c
[3/4] powerpc/kexec: Declare kexec_paca static
      https://git.kernel.org/powerpc/c/a4abd55a2490fd6407ddb6810e41f64ebd66d3af
[4/4] powerpc: Move C prototypes out of asm-prototypes.h
      https://git.kernel.org/powerpc/c/76222808fc253cb9ea66c3e0e8d1946933f25b70

cheers
