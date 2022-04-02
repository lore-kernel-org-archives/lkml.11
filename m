Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7718CC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Apr 2022 14:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356157AbiDBOTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Apr 2022 10:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238049AbiDBOTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:19:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327C1118F4D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 07:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=GT/FPU5g+6bO4Ehb7E4ZatOhh/YHkRin8QKLpEyrl14=;
        t=1648909049; x=1650118649; b=kviuQj8/08hSSKJvY2zouI00TdVlSyWepJYvw5NR2uFHjBX
        y3p/iDXPWP/ofQ5e7gFwgBaTxNaK4AKSn3lnguPdxj6VkXUH8Nv378a/M29F9lB/gOvRPkEvl74dw
        1hDmHqEdnzibIPZ2DwMYtgmJscGXKrN0jiJCVLKTUnt5n6/wjfa2OexYqeiOTOYsrz4Sk6if2/4PM
        nkPOeksl5FlerbxJnhQpyxN9RCwNxLbS3rEQrn8RMeui3r6dor26sHe7bpWVNUuZzwQAVZlt/+XrS
        nzQfhSEUOMmwnbfVJ7ziC8lzIrc806Qd2owLTsCo3QUakparlERj7I+ZFbZ4gO/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1naeZC-003saD-8o;
        Sat, 02 Apr 2022 16:17:26 +0200
Message-ID: <3c9a5194fb2bdf7377552c6fa6c3cd3505c4496c.camel@sipsolutions.net>
Subject: Re: UML time-travel warning from __run_timers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Date:   Sat, 02 Apr 2022 16:17:25 +0200
In-Reply-To: <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
References: <20220330110156.GA9250@axis.com>
         <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-04-02 at 16:09 +0200, Johannes Berg wrote:
> 
> (I put a WARN_ON into get_timer_cpu_base() and get_timer_this_cpu_base()
> in the if, and it never triggered; I guess my config has something that
> creates a deferrable timer, so it didn't trigger, but I didn't check
> that now.)
> 

OK, so FWIW, I checked that now, and I have e.g. CONFIG_WQ_WATCHDOG
enabled, which makes a deferrable timer:

static void wq_watchdog_init(void)
{
        timer_setup(&wq_watchdog_timer, wq_watchdog_timer_fn, TIMER_DEFERRABLE);


but I think a bunch of other (networking) things too that end up using a
TIMER_DEFERRABLE timer, via workqueues.

But maybe this would also happen if it was used just a single time,
since the timer would run & go away, leaving base->next_expiry never to
change again? But the WQ watchdog and also neigh_managed_work() are
periodic.

johannes
