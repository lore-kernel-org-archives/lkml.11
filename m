Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9A2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 03:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344257AbiBPDWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 22:22:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344277AbiBPDWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:22:16 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161728BE2A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:22:05 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 10so984186plj.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fE8a10xMdwGdzvwjLoG2TKIaG5fGfs9mzuGu6dSTu1Y=;
        b=ZKFJ7Y7KESGaNsWS3D8To6mVXdDj21wMQKSYVW736e0loBtJn6RA4cnwfdsRz+/vfT
         8egMmNbgjFuv6V7xTK1tXiTgm39997hM2JpK5bhIN2OGrDoCGKM7hOcOeK0PPmjkD51b
         qJS/c7LvJNfJBfBiwKNx2zI/NTkhGQIgkmO4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fE8a10xMdwGdzvwjLoG2TKIaG5fGfs9mzuGu6dSTu1Y=;
        b=m9MxO1TfHC1KzbEgXYKH9GhnLXhaRcfdhQtWzUZ97mqS9ToO37u1FRvgL2d3ivd16o
         eRN+19BIWJXtPfT0DggmrYjuqj55USS1ifNjhaGJ2aBR1LIlO4m17Vi6vvHWOOls83q/
         VAw1nsfuSda870dCy+CKCYVgjpWW0VV1TEf02Y9jhZuSYaUN99X62t7tQ1zTNi9+P3fZ
         F8ml8dezxX3niuTGksvShhuY6B/phkxLzA+/ydnB0YEighm0ioB4qDV9nOzRXlOUg/7t
         nKpnJLvM2StACbGRpRvoQHpd62RixzGaLB7jbjFNnrI5L8RjFONXh5hYbf6ixvXhYDwk
         ombQ==
X-Gm-Message-State: AOAM5303Nhid0fxiIq2kWBqoMhgAx1PnGWxX4bNI6716ihLCIN3W9ew/
        IpYvfRK9mwoJYVl6pNhVmpGnRw==
X-Google-Smtp-Source: ABdhPJxGfSXhOhQBOBQe76HLSWiT5FKxjYTwQ/q7Hl0o+9KpEU1iz+ghZ/lbpkLpDhMgmRfLfSuY4g==
X-Received: by 2002:a17:902:f787:b0:14f:43ba:55fc with SMTP id q7-20020a170902f78700b0014f43ba55fcmr927145pln.3.1644981724585;
        Tue, 15 Feb 2022 19:22:04 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:c926:4ee:add9:bf67])
        by smtp.gmail.com with ESMTPSA id j10sm42162535pfu.93.2022.02.15.19.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 19:22:03 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:21:59 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 05/13] printk: call boot_delay_msec() in
 printk_delay()
Message-ID: <Ygxt13r9MWa4vnwG@google.com>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-6-john.ogness@linutronix.de>
 <YgtBGx8FD/AA23Qk@google.com>
 <Ygu/1/Y+vTNhulUX@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygu/1/Y+vTNhulUX@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/15 15:59), Petr Mladek wrote:
> > > -static inline void printk_delay(void)
> > > +static inline void printk_delay(int level)
> > >  {
> > > +	boot_delay_msec(level);
> > > +
> > >  	if (unlikely(printk_delay_msec)) {
> > >  		int m = printk_delay_msec;
> > >  
> > > @@ -2224,8 +2226,7 @@ asmlinkage int vprintk_emit(int facility, int level,
> > >  		in_sched = true;
> > >  	}
> > >  
> > > -	boot_delay_msec(level);
> > > -	printk_delay();
> > > +	printk_delay(level);
> > 
> > As a side note, I wonder why do boot_delay_msec() and printk_delay()
> > touch only NMI watchdog. Shouldn't they also touch softlockup, WQ,
> > RCU, etc. watchdogs?
> 
> It seems that touch_nmi_watchdog() actually calls touch_softlockup_watchdog()
> that calls wq_watchdog_touch().

Oh, you are right, good point.

Well, we still have RCU stall detector which can trigger (in theory).
