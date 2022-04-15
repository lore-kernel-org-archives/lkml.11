Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09E4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 12:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353086AbiDOMMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 08:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345844AbiDOMMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:12:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F891C900
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4UNZXw0YRBDtJuui5acngb5/M1k3ilJrtADkI3z2KBo=; b=b4Hh9ezDUNLNSXdYofeUXtDMeP
        tmIzHXsT979jBzkg9Hy4/Rm/sHjr5cQlvCkrChAWyfRTZBAmoqJigHQ8AU16I/sRy0fIE6f0ViMeF
        RZbkJWDD0PXyeApXk4eOW/tFNv5bBO2eeIGDwSTKULPZpE4Gab5tv99zvjsEl0viXsBqRQH/X6uFu
        y3tFUgqxDUQZQIKCh0ltsifSr1YbwUPYqjgB4E6xMoodEH/nUexdq89dOZ/tFg7VmQV7cixRiGLz3
        DshjXMKaH6GrmPmNqn9dXOtMz+GOKG06Wbi91rk7MYSumhuDPmCkOzqV5Vv6XPOLTUyFLtOYAbqy5
        Gq/bLl7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfKla-00G6Nm-MR; Fri, 15 Apr 2022 12:09:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 58F753001AD;
        Fri, 15 Apr 2022 14:09:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B42030A47E02; Fri, 15 Apr 2022 14:09:34 +0200 (CEST)
Date:   Fri, 15 Apr 2022 14:09:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [patch 3/3] timekeeping: Consolidate fast timekeeper
Message-ID: <YllgforzF5I0emwv@hirez.programming.kicks-ass.net>
References: <20220415091223.187169221@linutronix.de>
 <20220415091921.072296632@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415091921.072296632@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 11:19:38AM +0200, Thomas Gleixner wrote:
> Provide a inline function which replaces the copy & pasta.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
