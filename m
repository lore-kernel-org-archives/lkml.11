Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B81C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 11:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbiEXLQn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 07:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbiEXLQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:16:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763EA6B03A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:15:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s7p6Nxlz4yT6;
        Tue, 24 May 2022 21:15:50 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220505125123.2088143-1-mpe@ellerman.id.au>
References: <20220505125123.2088143-1-mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc: Add generic PAGE_SIZE config symbols
Message-Id: <165339055669.1718562.2595645003125748288.b4-ty@ellerman.id.au>
Date:   Tue, 24 May 2022 21:09:16 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2022 22:51:22 +1000, Michael Ellerman wrote:
> Other arches (sh, mips, hexagon) use standard names for PAGE_SIZE
> related config symbols.
> 
> Add matching symbols for powerpc, which are enabled by default but
> depend on our architecture specific PAGE_SIZE symbols.
> 
> This allows generic/driver code to express dependencies on the PAGE_SIZE
> without needing to refer to architecture specific config symbols.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc: Add generic PAGE_SIZE config symbols
      https://git.kernel.org/powerpc/c/d036dc79cccd748e2a101c80c31efada7be8bb7c
[2/2] arch/Kconfig: Drop references to powerpc PAGE_SIZE symbols
      https://git.kernel.org/powerpc/c/aa06530a535ffe8ba8b68054003b6fb262a8ec6f

cheers
