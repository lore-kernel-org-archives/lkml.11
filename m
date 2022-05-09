Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D868BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 06:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiEIGUg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 02:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbiEIGLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:11:03 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813AB13C099
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:07:09 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 3EE71201342;
        Mon,  9 May 2022 06:07:07 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id D6B4F80822; Mon,  9 May 2022 08:06:03 +0200 (CEST)
Date:   Mon, 9 May 2022 08:06:03 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] random: use symbolic constants for crng_init states
Message-ID: <YnivSwI+IczXnJ4q@owl.dominikbrodowski.net>
References: <Ynf8qMmN+AAofKMy@zx2c4.com>
 <20220508173610.151998-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508173610.151998-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, May 08, 2022 at 07:36:10PM +0200 schrieb Jason A. Donenfeld:
> crng_init represents a state machine, with three states, and various
> rules for transitions. For the longest time, we've been managing these
> with "0", "1", and "2", and expecting people to figure it out. To make
> the code more obvious, replace these with proper enum values
> representing the transition, and then redocument what each of these
> states mean.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
