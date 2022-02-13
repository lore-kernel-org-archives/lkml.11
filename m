Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB63C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Feb 2022 06:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbiBMG5I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Feb 2022 01:57:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbiBMG5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 01:57:07 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AA55DE58
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 22:57:02 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id DC82F2013FF;
        Sun, 13 Feb 2022 06:56:59 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 8CB19809A1; Sun, 13 Feb 2022 07:55:05 +0100 (CET)
Date:   Sun, 13 Feb 2022 07:55:05 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] random: re-group and re-document functions
Message-ID: <YgirSXcAxKyO9BhD@owl.dominikbrodowski.net>
References: <20220212122318.623435-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212122318.623435-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sat, Feb 12, 2022 at 01:23:08PM +0100 schrieb Jason A. Donenfeld:
> We previously had massive documentation comments and functions strewn
> all about. This attempts to restore sanity by dividing the code into a
> few sections:
> 
> - Initialization and readiness waiting.
> - Fast key erasure RNG.
> - Entropy accumulation and extraction.
> - Entropy collection.
> - Userspace read/write.
> - Sysctl.
> 
> The result of this ordering and this grouping is only 2 forward
> declarations, indicating that this is probably a sensible grouping.
> Also, some documentation that was just hopelessly out of date been
> removed. We'll later look into re-adding parts of this to the Linux man
> pages project.
> 
> No functional changes.

Hi Jason,

thanks for your massive patchset. While some of it was a bit tedious and
repetetive to review, feel free to add my

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

to patchs 1-3, 6 and 8-10. For patches 4, 5 and 7, I have some comments;
once addressed, feel free to add my reviewed-by tag to those as well.

Thanks,
	Dominik
