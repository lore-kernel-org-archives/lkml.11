Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA27C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Feb 2022 06:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiBMG5Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Feb 2022 01:57:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiBMG5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 01:57:10 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863035DE66
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 22:57:05 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 228AD20140A;
        Sun, 13 Feb 2022 06:57:00 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id EE82F808C5; Sun, 13 Feb 2022 07:54:45 +0100 (CET)
Date:   Sun, 13 Feb 2022 07:54:45 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 07/10] random: group entropy collection functions
Message-ID: <YgirNWqk6d4y/Z0k@owl.dominikbrodowski.net>
References: <20220212122318.623435-1-Jason@zx2c4.com>
 <20220212122318.623435-8-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212122318.623435-8-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> + * add_device_randomness() adds data to the input pool that
> + * is likely to differ between two devices (or possibly even per boot).
> + * This would be things like MAC addresses or serial numbers, or the
> + * read-out of the RTC. This does *not* credit any actual entropy to
> + * the pool, but it initializes the pool to different values for devices
> + * that might otherwise be identical and have very little entropy
> + * available to them (particularly common in the embedded world).
> + *
> + * add_input_randomness() uses the input layer interrupt timing, as well
> + * as the event type information from the hardware.
> + *
> + * add_disk_randomness() uses what amounts to the seek time of block
> + * layer request events, on a per-disk_devt basis, as input to the
> + * entropy pool. Note that high-speed solid state drives with very low
> + * seek times do not make for good sources of entropy, as their seek
> + * times are usually fairly consistent.
> + *
> + * The above three routines try to estimate how many bits of entropy

	*two* (add_device_randomness() does not credit any entropy).

Thanks,
	Dominik
