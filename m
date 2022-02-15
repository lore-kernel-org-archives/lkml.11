Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24ACC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 05:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbiBOF7J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 00:59:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiBOF7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:59:06 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79E39D0DE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:58:56 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i6so31247087pfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Q9Q8wpVEmyDJTwG35xbPApYsaefMX7TSk4LROnBtZ0=;
        b=aws37nD2Dk2ULtLGNS9rNa2+m/pYyrgMXtYqpueLLyXrmDPEZYlKv1pGWnOYHMrQht
         YvDp1LUB0PQrkpAnKrrI82ld+QRLd84mZon6SEN6MumTbDYaS4md0+DplufBng0KhYTi
         VvMl+QsSKiKCSmB0Rhh1hYJ89KLBiwyXLNe8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Q9Q8wpVEmyDJTwG35xbPApYsaefMX7TSk4LROnBtZ0=;
        b=BjX9kxFss+XZHBq/z6dN21tD4CyQv6rPEqYLvVMrYnPQ9xHCPhqWv7jUdY3aiNDt5K
         L6ALUOBA92k4noUKZDnsYqxRKshX8Y0/My0MTGoQdvucwFkgbAnYR1rMHViwDwIUulB1
         34NPNiDsPrgG1PJDAxCpvEEIMpqInom6aug4DMCjHfnh7JxxRKF9xgQNyM7YVf0sSJhr
         hwMaMNS5ZUkXfNYOHf1NBQFARx0kcBdBNbcuBsIFxK2TbEWjniIdTiMmg0g1aZp8VduT
         ya1oDD9BqnYuZb2JJCQdapQxzOuI7z2YfSZ57onP5yKtG8XcrRkbo6xctC35pM0Dn9s1
         6R8A==
X-Gm-Message-State: AOAM530fHe1wd5h1GOQX5izxk2xAhDARchCNm6yIlSVZIPly24ZTGlRV
        n3J1yemkoS+Axz0A2WDvl18Ecw==
X-Google-Smtp-Source: ABdhPJwTXEUW+RTt9y0tDVFVpyyAQz7ktwLfepY//5N9uDwFb2sEB26D0s/IIel/c3/mojVxVZV9ow==
X-Received: by 2002:a63:88c1:: with SMTP id l184mr563579pgd.322.1644904736412;
        Mon, 14 Feb 2022 21:58:56 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:c926:4ee:add9:bf67])
        by smtp.gmail.com with ESMTPSA id c8sm40020072pfv.57.2022.02.14.21.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 21:58:55 -0800 (PST)
Date:   Tue, 15 Feb 2022 14:58:51 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 05/13] printk: call boot_delay_msec() in
 printk_delay()
Message-ID: <YgtBGx8FD/AA23Qk@google.com>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207194323.273637-6-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/07 20:49), John Ogness wrote:
> boot_delay_msec() is always called immediately before printk_delay()
> so just call it from within printk_delay().
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

> -static inline void printk_delay(void)
> +static inline void printk_delay(int level)
>  {
> +	boot_delay_msec(level);
> +
>  	if (unlikely(printk_delay_msec)) {
>  		int m = printk_delay_msec;
>  
> @@ -2224,8 +2226,7 @@ asmlinkage int vprintk_emit(int facility, int level,
>  		in_sched = true;
>  	}
>  
> -	boot_delay_msec(level);
> -	printk_delay();
> +	printk_delay(level);

As a side note, I wonder why do boot_delay_msec() and printk_delay()
touch only NMI watchdog. Shouldn't they also touch softlockup, WQ,
RCU, etc. watchdogs?
