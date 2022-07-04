Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F58C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Jul 2022 11:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbiGDLhQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Jul 2022 07:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiGDLgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:36:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E1C11A3B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:36:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lc3fW11ppz4xtw;
        Mon,  4 Jul 2022 21:36:19 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, Laurent Dufour <ldufour@linux.ibm.com>
Cc:     aneesh.kumar@linux.ibm.com, Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220523164353.26441-1-ldufour@linux.ibm.com>
References: <20220523164353.26441-1-ldufour@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/64s: Don't read H_BLOCK_REMOVE characteristics in radix mode
Message-Id: <165693443133.9954.10851917320089851428.b4-ty@ellerman.id.au>
Date:   Mon, 04 Jul 2022 21:33:51 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 18:43:53 +0200, Laurent Dufour wrote:
> There is no need to read the H_BLOCK_REMOVE characteristics when running in
> Radix mode because this hcall is never called.
> 
> Furthermore since the commit 387e220a2e5e ("powerpc/64s: Move hash MMU
> support code under CONFIG_PPC_64S_HASH_MMU") define
> pseries_lpar_read_hblkrm_characteristics as un empty function if
> CONFIG_PPC_64S_HASH_MMU is not set, the #ifdef block can be removed.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/64s: Don't read H_BLOCK_REMOVE characteristics in radix mode
      https://git.kernel.org/powerpc/c/61bdbca855024997fd8c82dc190f458aa81beca8

cheers
