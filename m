Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B77DECAAD5
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 13:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiHaNPq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 09:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiHaNPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:15:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58E36B8CA
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:15:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHl6D4rznz4xGG;
        Wed, 31 Aug 2022 23:15:32 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <a821e8397dd56b8177ecc04966d3b3a7c4bda6d4.1660919016.git.christophe.leroy@csgroup.eu>
References: <a821e8397dd56b8177ecc04966d3b3a7c4bda6d4.1660919016.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Remove stale declarations in mmu_decl.h
Message-Id: <166195163497.45984.6671089422607210922.b4-ty@ellerman.id.au>
Date:   Wed, 31 Aug 2022 23:13:54 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 16:23:43 +0200, Christophe Leroy wrote:
> rtas_size and rtas_data are not used anymore since at least
> commit 7c8c6b9776fb ("powerpc: Merge lmb.c and make MM initialization
> use it.")
> 
> Remove them.
> 
> Since commit 4b74a35fc7e9 ("powerpc/32s: Make Hash var static")
> the forward declaration of struct hash_pte is unneeded.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Remove stale declarations in mmu_decl.h
      https://git.kernel.org/powerpc/c/e38cd72c17fa7d7710088365251feb6c52b501c8

cheers
