Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439B4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 16:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244940AbiBJQ5L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:57:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244450AbiBJQ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:57:05 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDC7EE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:57:06 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 81A69201352;
        Thu, 10 Feb 2022 16:57:03 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id D0ED48065E; Thu, 10 Feb 2022 17:55:53 +0100 (CET)
Date:   Thu, 10 Feb 2022 17:55:53 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 2/2] random: deobfuscate irq u32/u64 contributions
Message-ID: <YgVDmcG78PVoP4U3@owl.dominikbrodowski.net>
References: <20220210160925.156697-1-Jason@zx2c4.com>
 <20220210160925.156697-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210160925.156697-3-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, Feb 10, 2022 at 05:09:25PM +0100 schrieb Jason A. Donenfeld:
> In the irq handler, we fill out 16 bytes differently on 32-bit and
> 64-bit platforms. Whether or not you like that, it is a matter of fact.
> But it might not be a fact you well realized until now, because the code
> that loaded the irq info into 4 32-bit words was quite confusing.
> Instead, this commit makes everything explicit by having separate
> (compile-time) branches for 32-bit and 64-bit machines. In the process,
> it exposed a shortcoming in in mix_interrupt_randomness() which we

"in in" -> "in"

> rectify.

Maybe explain the shortcoming in one sentence? I think I spotted it, but...

Thanks,
	Dominik
