Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF7CC19F2B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jul 2022 07:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbiG2HSx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jul 2022 03:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbiG2HSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:18:50 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AEA5A3EF;
        Fri, 29 Jul 2022 00:18:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0C787CE2686;
        Fri, 29 Jul 2022 07:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51A2C433C1;
        Fri, 29 Jul 2022 07:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659079124;
        bh=QQZCBDkWE41LYYccsVLmpba4/GdB3x9VzH1J6ETItTQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s3cFpaJinyDBzCiTRLZZzo4mzOSSoA6Gkdlgwx2b7LLo9ad1SDFIMHviys9HNU19L
         P/IMcPpoTsFCjpWoxlWjKcnTCl0uSFWW+N0d0fdgynMZAE1b6JXauRYSWcFVA3K6L2
         qIXsD7i4YhzWA/XPJbu60xKVMjksJFGCpsJynaPrP3Q8CuZYFsAFhrG92fZaoPMHi1
         vhWCG/wHguQ8KeL13M8gfSGSAiearlO5lkrcELhwLP4OndwRI5M7DIK+HHNzYyi7rO
         t2k9vjPKfAAw77RKgVJ5tEU9dVsDUxDGATR0PyeBKBJ814JsdM7aqWkOVoRLQNwGaT
         gikL2T6HgmjQw==
Date:   Fri, 29 Jul 2022 00:18:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Li zeming <zeming@nfschina.com>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/net/act: Remove temporary state variables
Message-ID: <20220729001842.5bc9f0b2@kernel.org>
In-Reply-To: <YuOFd2oqA1Cbl+at@nanopsycho>
References: <20220727094146.5990-1-zeming@nfschina.com>
        <20220728201556.230b9efd@kernel.org>
        <YuN+i2WtzfA0wDQb@nanopsycho>
        <20220728235121.43bedc43@kernel.org>
        <YuOFd2oqA1Cbl+at@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2022 09:00:07 +0200 Jiri Pirko wrote:
> >> What backports do you have in mind exactly?  
> >
> >Code backports. I don't understand the question.  
> 
> Code backports of what where?
> Are you talking about:
> 1) mainline kernels
> 2) distrubutions kernels? Or even worse, in-house kernels of companies?
> 
> If 2), I believe it is not relevant for the upstream discussion, at all.

Fixes and stable. Frankly it's just a generic justification 
to discourage people from sending subjective code cleanups.
I'd never argue for the benefit of (2) :)

There's been a string of patches cleaning up return values
of functions in the last few days. If people have a lot of
time on their hands they should go do something useful, like
converting netdev features to a bitmap. Hell, go fix W=1 warnings, 
even easier.

The time spent reviewing those "cleanups" adds up, and I suspect
there's hundreds of places they can be applied. Hence my question
about automation... 
