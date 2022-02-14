Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291A8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 05:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbiBNFdH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 00:33:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiBNFdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:33:06 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717014E3B8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:32:59 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id t36so16547137pfg.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kRVO1C5kgFh6U5/Qi9bu3x8D9iglpuTn4FrzICM2Jms=;
        b=AcD9UjBLeJQQ5427qvXMlgc+SdcT6TW5I6bMYezQG+yrRWTtgSMLtRxSJAM8yFfWg3
         OkKcyoO4M/JfnqtblFyRrjzmOA4/9YQxlBs9kZsv4WIIz5EuMVOQJ+/cvJOBmhpbI/+t
         vIRi0Xwz0yHkz11Weqx3ZIB7Tn3SviNI+DTqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kRVO1C5kgFh6U5/Qi9bu3x8D9iglpuTn4FrzICM2Jms=;
        b=w6hvopk5eiI3s/o5vBMUXcMuDDqIR1BjuOsdByPrL/gYkLfl/ChelB0imGDIk1e4/I
         tFFTkpTbTtzYwsiw1TNXxvF7ub9WzH9e7fKnrWYymoLlFunOgvW4zc/IcWdOsosMDrla
         o6THxpP0drJlQKeqCobvvIxKL29YXnuYsSfKpG35DazXeQlwkhpeP6Ag6+jR6Ji5iIgf
         E1Jp+IwWiuUByE4H/XIZGQcA9W8uJqq8i6/0WnqeD9JQM7DzWoQNzG55KmzCKi98gYYd
         96t2RpT4FDfWyVU6nu5QWoWVYqA6JVltiU142pZEqla2DK1Yyem71/m+UaJwp5WdfEjZ
         41PA==
X-Gm-Message-State: AOAM532Ac5Q9f4zica3dYbeOPKZK4ST0d9s6XK1ahaHR0KtwFveVU7sy
        Aq0YSYiXQaExA9UZLeRR/F1a6A==
X-Google-Smtp-Source: ABdhPJyjVD0g8rHCfB6VGMZveDdI/Hz7T1roHnawAIO8ns2+eQuRhiir7xIUYvrji6Na/Xe9WWIgTA==
X-Received: by 2002:a63:91c8:: with SMTP id l191mr1876435pge.354.1644816779019;
        Sun, 13 Feb 2022 21:32:59 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b736:df7d:23c5:206e])
        by smtp.gmail.com with ESMTPSA id y8sm971395pfa.132.2022.02.13.21.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 21:32:58 -0800 (PST)
Date:   Mon, 14 Feb 2022 14:32:54 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] printk: defer_console_output: use atomic update
Message-ID: <YgnphtfTRBenHgfp@google.com>
References: <20220203112915.1350753-1-john.ogness@linutronix.de>
 <YfzP50vDiJiaRVCr@google.com>
 <87bkzj3t77.fsf@jogness.linutronix.de>
 <YgUzm5POctivsjUg@alley>
 <87leyhd4wc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leyhd4wc.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/11 12:28), John Ogness wrote:
> Hi Petr,
> 
> On 2022-02-10, Petr Mladek <pmladek@suse.com> wrote:
> > The patch has been committed into printk/linux.git, branch for-5.18.
> 
> Sebastian also pointed out that the use of __this_cpu_xchg() is the same
> problem with the same variable for the same reason. We should fold that
> change into the patch as well. The patch will followup this message.

But that __this_cpu_xchg() (that this lol) can only be performed form the
IRQ context. Can you please elaborate what is the problem with it?
