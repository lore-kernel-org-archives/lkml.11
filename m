Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3B4C43334
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jun 2022 00:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbiFZA27 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jun 2022 20:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbiFZA24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 20:28:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28AF13F0B;
        Sat, 25 Jun 2022 17:28:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LVsD22mHNz4xZB;
        Sun, 26 Jun 2022 10:28:50 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        stable <stable@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20220621140849.127227-1-Jason@zx2c4.com>
References: <20220620124531.78075-1-Jason@zx2c4.com> <20220621140849.127227-1-Jason@zx2c4.com>
Subject: Re: [PATCH v5] powerpc/powernv: wire up rng during setup_arch
Message-Id: <165620330450.1934578.17474382204617879607.b4-ty@ellerman.id.au>
Date:   Sun, 26 Jun 2022 10:28:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 16:08:49 +0200, Jason A. Donenfeld wrote:
> The platform's RNG must be available before random_init() in order to be
> useful for initial seeding, which in turn means that it needs to be
> called from setup_arch(), rather than from an init call. Fortunately,
> each platform already has a setup_arch function pointer, which means we
> can wire it up that way. Complicating things, however, is that POWER8
> systems need some per-cpu state and kmalloc, which isn't available at
> this stage. So we split things up into an early phase and a later
> opportunistic phase. This commit also removes some noisy log messages
> that don't add much.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/powernv: wire up rng during setup_arch
      https://git.kernel.org/powerpc/c/f3eac426657d985b97c92fa5f7ae1d43f04721f3

cheers
