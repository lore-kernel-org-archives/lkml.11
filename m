Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C906C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 May 2022 06:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiE2GOc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 May 2022 02:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiE2GO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 02:14:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E42D66AEA
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 23:14:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q92-20020a17090a17e500b001e0817e77f6so10573237pja.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 23:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xpJ6yYBlil0glg1sQLV8TUgNykHZU/Ss0pRhBIZ9kAc=;
        b=ed4F6VrmT3ftKTADZTLo3NiPx5zKaGR64m7NlD6TC+bq3ejP6PTAiIUhsYWvDUr/Zr
         Cneiyj69QWL3EC9WkddAqlvDlCYhuJ2OVypgccsOSQHvLG6lrJXBs73nk8J6t1u3HTiQ
         +pic2xEr0zlbj5o9fOfsHblhfsmOQUKLPb4l0vgkzcvwPzM3MInjZqVP0DcPzVzHXGOb
         gEPw9A00Lp5/EHOj8Qjxd43KMuhR5CvbjE8ViW8v6yYeQFslYbdqFiZAQ6mT7BnHw2Oh
         ElJkmCRt9cpyt82gsGShMOn2C09XJFUCZImF+deJQplW+ilsb4eK1rSMo1s4c4BG4s1s
         VTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xpJ6yYBlil0glg1sQLV8TUgNykHZU/Ss0pRhBIZ9kAc=;
        b=m4dDv/ePwP2aXTdoc39AKLOFyu4ug+vLLYsmramWAEcx7T5XOo+rrAG0yPu36EfFWM
         Dax214Pp83RFkgSubAHBPue416AygBrhOSVsV7nFYcF90P5JX23NI6L5fTFPS0Lk4CqA
         C4T+NFMicaEldWF6mJeluIl1ktqGG8JJqTzolWnSgBq/WS5kuPmY9ZGkIzhmKTFiBlue
         RzJ7JXLzHDsLun8ot6Uhuw6IcEWlKstEK6GrzT+RMqrIMhY0w6sWx32xbAfstGBN+wEF
         0CCOjiiDThtBHVglOOLdH2TXm0zTqGZf704DkF1QUc6sCyQqPQ5SKK+iJbo9yAR/j5VF
         S5NQ==
X-Gm-Message-State: AOAM531iz+UWUwss7LnnPDXM9ayxUABmYBoq6VBcvHWpg0UZ0ifCmmFF
        0gg+f5gHA/Mdt5bihOgPnM6QYTNkF5A=
X-Google-Smtp-Source: ABdhPJwPd3dq0FDizzmM1CUUIWRIev0xbY3Znz67c9f1WsRygIpDNqMYKCsMXV3b0AZIYZlnkabfuA==
X-Received: by 2002:a17:90b:4a49:b0:1df:d294:a13 with SMTP id lb9-20020a17090b4a4900b001dfd2940a13mr16719089pjb.6.1653804865700;
        Sat, 28 May 2022 23:14:25 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7804c000000b00512d13016d0sm6282576pfm.159.2022.05.28.23.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 23:14:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 28 May 2022 20:14:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Geraldo Nascimento <geraldogabriel@gmail.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: missing NOT while checking if Workqueue is
 offline
Message-ID: <YpMPPyIZVlBwUrNe@slm.duckdns.org>
References: <YpKA5Bdk1Cm6KgKU@geday>
 <YpLLnx8/xpZIPMbi@geday>
 <YpL2rHUXd0vf8IML@geday>
 <YpMDmZZ7IpEhjywp@slm.duckdns.org>
 <YpMKY88/2tTK319E@geday>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpMKY88/2tTK319E@geday>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 02:53:39AM -0300, Geraldo Nascimento wrote:
> On Sat, May 28, 2022 at 07:24:41PM -1000, Tejun Heo wrote:
> > On Sun, May 29, 2022 at 01:29:32AM -0300, Geraldo Nascimento wrote:
> > > I would like very much to hear the opinion of the maintainers!
> > 
> > I have a hard time understanding what you're trying to do. Can you please
> > slow down and start from describing the problem itself?
> 
> Hi Tejun,
> 
> Sorry for the hurry.
> 
> The problem is best described in https://gitlab.freedesktop.org/drm/amd/-/issues/1898
> 
> From my understanding from the context of __cancel_work_timer() we should not
> ever call __flush_work() but I may be wrong. In the present case as

Yeah, you're wrong.

> described in AMD's GitLab __cancel_work_timer() is being called by
> cancel_delayed_work_sync() inside kfd_process_notifier_release()
> from drivers/gpu/drm/amd/amdkfd/kfd_process.c:1157 (Linux 5.18).

Have you confirmed that that actually is the warning which is triggering? I
don't see how that condition would trigger that late during the boot and the
warning line being reported doesn't match v5.16 source code, so I'm not sure
but skimming the instructon sequence, that's the second UD2 sequence, so I'm
gonna guess that's the second WARN_ON - the !work->func one and someone else
on the gitlab bug report seems to agree too.

It's usually a lot more helpful if the bug report is complete - include the
full warning message with some context at least, make sure that the kernel
you're using is an upstream one or something close enough. If not, point to
the source tree. Also, try to clearly distinguish what you know and what you
suspect. Both can help but mixing them up together tends to cause confusion
for everyone involved.

It just looks like the code is trying to cancel a work item which hasn't
been initialized and what it prolly needs is an ifdef around that cancel
call depending on the config option.

Thanks.

-- 
tejun
