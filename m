Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584F4C4332F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 02:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849985AbiDFCqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 22:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579545AbiDEXbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 19:31:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972EAAC07B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:51:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08DC861794
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 21:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F82CC385A1;
        Tue,  5 Apr 2022 21:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649195491;
        bh=Xdb2gc8lX6WVpHMpGO9xuQWQGg8b2EHbtj6SnejtXCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GywQs+e4p7ljt1mxBGCGV77x9axJZHk4TE3T8Ft+ifVPJTfzv1fdbeMQHZIHl2Mvx
         JF3uudeWj7KIZSzt6libmxCf0NP/N7Ms9JOTjB5eOslVGc0oWoTeO2i+xHTfR9antN
         e/NofzsBxfzobR8gdY8cJz8GFqufOtwRbQIegXVKJthsbBrfJMUkEx6/nDcmHkqFBI
         nchm15Vy5zG85+xh3GbhY7ZfQ4LZ82+NzSHiJ7qvS49bMMBci0rvKK9mXc2g10v6xq
         V/Z83h+IWtty4sCLMqpLY7m+Fhtrrm3Ae3cJu+DjNMXXNReEi27VHpcxVV809M03ks
         BTOs86cnlBtRw==
Date:   Tue, 5 Apr 2022 23:51:28 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] timers: Initialize base::next_expiry_recalc during
 prepare cpu
Message-ID: <20220405215128.GA1359823@lothringen>
References: <20220405191732.7438-1-anna-maria@linutronix.de>
 <20220405191732.7438-2-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405191732.7438-2-anna-maria@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 09:17:31PM +0200, Anna-Maria Behnsen wrote:
> When base::next_expiry_recalc is not initialized to false during cpu
> bringup in HOTPLUG_CPU and is accidently true and no timer is queued in the
> meantime, the loop through the wheel to find __next_timer_interrupt() might
> be done for nothing.
> 
> Therefore initialize base::next_expiry_recalc to false in
> timers_prepare_cpu().
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
