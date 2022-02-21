Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFDBC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 19:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbiBUTUN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:20:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiBUTUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:20:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624855F88
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:19:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 225DEB816F9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7244C340E9;
        Mon, 21 Feb 2022 19:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645471184;
        bh=9tJK5LZCupjG/Yyc10FX6OzpxLiT+nQS7JI839pHS6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bOrKwZvjTYmjfxUcwwDiNpk1lVI+bAU8oWd+wf+KUrz5Qcz/uZEebQ9OLB06uHSQe
         GTX/PiTcFrxtHhscM/u8RH+uJ80y/MvXGo99aLCCysa9PtWgzKIAuYvcmbSLDhPkAp
         bkxiFmTtThaQ3VU40Gc1kSzCFucRpTzOK+TK6Cds75FEMeA3nCNcIs5OpAZI1V438a
         l5020BNt/XnNaQKEnt8Y7jEpMzBBctJA1WwqhhWsDgj2hTlXIScp4osrcp716a99fM
         3ga1OsdcCcc8g+bUCxHc3DDFDpWJlJHgHDGH8vvAXuKkLKbapt6ol7GLIjf4g3rV1U
         zBmK0iys0p0gw==
Date:   Mon, 21 Feb 2022 11:19:43 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v3] random: introduce drain_entropy() helper to declutter
 crng_reseed()
Message-ID: <YhPlz9wIOgMuVl/Z@sol.localdomain>
References: <CAHmME9oSyKFc4fTPgBiKb+Urjf2qR5x2ydhgU6XnOcfty7qoFw@mail.gmail.com>
 <20220221144945.2277232-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221144945.2277232-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 03:49:45PM +0100, Jason A. Donenfeld wrote:
> In preparation for separating responsibilities, break out the entropy
> count management part of crng_reseed() into its own function.
> 
> No functional changes.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> v3 adjusts the drain_entropy() comment to note that we're only setting
> the entropy count to zero, per Eric's request.
> 
>  drivers/char/random.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
