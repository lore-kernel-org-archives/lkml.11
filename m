Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07FDC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 15 May 2022 10:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbiEOKSa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 May 2022 06:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiEOKS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 06:18:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECCD175BC
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 03:18:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF9D7B80BE9
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 10:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1648AC385B8;
        Sun, 15 May 2022 10:18:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OV02Vra2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652609900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q/BkFmFZ1XoCw3vsJkmslzb+cMHbb9FFT6c5rZJWuH4=;
        b=OV02Vra2A8y5JYZOfWwQJaaJ1e460Rr0qjvRqaJ86NY/IMtYuSkwsTVQZDKwpSrIYSPfPj
        EtOg2i9AjJjEqfqwAA+8OQv1Z+NvYvtD0qERn5iSTnDvEBxd2aCD+3LKpc1DAIDJ0fC3B1
        Uk24/Du0J/O6/kGFYBOsFPhyp5Hu2X0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7d4a126c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 15 May 2022 10:18:20 +0000 (UTC)
Date:   Sun, 15 May 2022 12:18:18 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] random: handle latent entropy and command line from
 random_init()
Message-ID: <YoDTavkNV6ufHN9s@zx2c4.com>
References: <20220512124839.20755-1-Jason@zx2c4.com>
 <YoBMk1lKmF3B5kZC@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoBMk1lKmF3B5kZC@sol.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Sat, May 14, 2022 at 05:42:59PM -0700, Eric Biggers wrote:
> On Thu, May 12, 2022 at 02:48:39PM +0200, Jason A. Donenfeld wrote:
> > 
> > While we're at it, rename the awkwardly titled "rand_initialize()" to
> > the more standard "random_init()" nomenclature.
> 
> One nit: there's still a mention of "rand_initialize()" in
> arch/openrisc/kernel/head.S.

Thanks, will fix that too.

Jason
