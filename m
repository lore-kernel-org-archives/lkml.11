Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FE5C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 06:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377378AbiEMG0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 02:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377308AbiEMG0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:26:25 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B8827CC0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:26:22 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id F07F2201406;
        Fri, 13 May 2022 06:26:05 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id D3E92809A3; Fri, 13 May 2022 08:23:40 +0200 (CEST)
Date:   Fri, 13 May 2022 08:23:40 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] random: avoid init'ing twice in credit race
Message-ID: <Yn35bNS6RlElAGYh@owl.dominikbrodowski.net>
References: <20220509121409.529788-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509121409.529788-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, May 09, 2022 at 02:14:08PM +0200 schrieb Jason A. Donenfeld:
> Since all changes of crng_init now go through credit_init_bits(), we can
> fix a long standing race in which two concurrent callers of
> credit_init_bits() have the new bit count >= some threshold, but are
> doing so with crng_init as a lower threshold, checked outside of a lock,
> resulting in crng_reseed() or similar being called twice.

Sidenote: crng_reseed() did manage quite fine if called twice in short
order.

> In order to fix this, we can use the original cmpxchg value of the bit
> count, and only change crng_init when the bit count transitions from
> below a threshold to meeting the threshold.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
