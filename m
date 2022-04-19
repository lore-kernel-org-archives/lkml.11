Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9883C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 08:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350226AbiDSI64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 04:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbiDSI6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:58:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E6D25E86
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8dvuNerJhBtAD608zWEvYKc5B04dhUSqiF0nI8vUCOw=; b=IRcFobDVdPU400EV/i1DhEbjt+
        epJMuBI2p7/+Cf+NTW4VyVemAGtT1c4FIT6yg/Y4xlU2hyR/FN7hmWz1bPzCpfIg+fc8SSDf+thj/
        8kF/f+fCpjs34f1uescyhqg81u0mA3zDeWYtoYZb12m1rONWuZAt9uBU1aK1bGUtob8gCF6R7Mhr8
        LfR6NPiIUhyUNtWgZejHV2FtrbU3J59QX8LGs1tFEFeB0na7GYCW/Q1h9VGQPULMr1u++56QhHrZR
        lHWpHUVJduMffugxAlL0FtGOEz7MTyULtzSzkoJbWLvzS4KaGYUvbkcxfFfJ579q9bLmdDAZ5iDtR
        rTz6ugYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngjeX-002wHs-CP; Tue, 19 Apr 2022 08:56:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4958C98618A; Tue, 19 Apr 2022 10:56:03 +0200 (CEST)
Date:   Tue, 19 Apr 2022 10:56:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Add new Alderlake and Raptorlake CPU model
 numbers
Message-ID: <20220419085603.GO2731@worktop.programming.kicks-ass.net>
References: <20220310215652.32025-1-tony.luck@intel.com>
 <20220330134325.GM8939@worktop.programming.kicks-ass.net>
 <29d602962d6542bd90e877c104afcc7f@intel.com>
 <YlS7n7Xtso9BXZA2@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlS7n7Xtso9BXZA2@agluck-desk3.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 04:37:03PM -0700, Luck, Tony wrote:
> Intel is subdividing the mobile segment with additional models
> with the same codename. Using the Intel "N" and "P" suffices
> for these will be less confusing than trying to map to some
> different naming convention.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> 
> I think the earlier patch for Alderlake "N" got stuck in limbo
> trying to resolve whether we should add the "_N" suffix to our list
> of acceptable CPU model #define names. Now we have another one "_P".
> 
> Can we just take these, and move on?

Yeah, I suppose so.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Let's hope our marketing team will stick with these names for a little
while atleast :/
