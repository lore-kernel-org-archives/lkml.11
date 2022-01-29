Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A85C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jan 2022 15:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244629AbiA2PJ2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jan 2022 10:09:28 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:37190 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiA2PJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 10:09:26 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 39BAF201416;
        Sat, 29 Jan 2022 15:09:25 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 549A28075E; Sat, 29 Jan 2022 16:08:46 +0100 (CET)
Date:   Sat, 29 Jan 2022 16:08:46 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] random: wake up /dev/random writers after zap
Message-ID: <YfVYfsDCVnKSfDSc@owl.dominikbrodowski.net>
References: <20220128224906.104235-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128224906.104235-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, Jan 28, 2022 at 11:49:06PM +0100 schrieb Jason A. Donenfeld:
> When account() is called, and the amount of entropy dips below
> random_write_wakeup_bits, we wake up the random writers, so that they
> can write some more in. However, the RNDZAPENTCNT/RNDCLEARPOOL ioctl
> sets the entropy count to zero -- a potential reduction just like
> account() -- but does not unblock writers. This commit adds the missing
> logic to that ioctl to unblock waiting writers.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
