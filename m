Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60166C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 19:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiCATBF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiCATBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:01:03 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B17110D1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:00:21 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 221J0EI2007282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Mar 2022 14:00:15 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6C61015C0038; Tue,  1 Mar 2022 14:00:14 -0500 (EST)
Date:   Tue, 1 Mar 2022 14:00:14 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] random: do not export add_vmfork_randomness() unless
 needed
Message-ID: <Yh5tPt2LoLp442zi@mit.edu>
References: <20220301142528.243059-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301142528.243059-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 03:25:28PM +0100, Jason A. Donenfeld wrote:
> Since add_vmfork_randomness() is only called from vmgenid.o, we can
> guard it in CONFIG_VMGENID, similarly to how we do with
> add_disk_randomness() and CONFIG_BLOCK. If we ever have multiple things
> calling into add_vmfork_randomness(), we can add another shared Kconfig
> symbol for that, but for now, this is good enough. Even though
> add_vmfork_randomess() is a pretty small function, removing it means
> that there are only calls to crng_reseed(false) and none to
> crng_reseed(true), which means the compiler can constant propagate it
> and simply crng_reseed().

How about only exporting add_vmfork_randomness if VMGENID is compiled
as a module?  If it's built-in to the kernel, no need to export the
symbol.

					- Ted
