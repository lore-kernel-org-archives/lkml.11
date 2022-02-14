Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D45BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 08:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242611AbiBNIq1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 03:46:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242587AbiBNIqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:46:06 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927BD60A88
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8z7TIo9QpDnq9oRak8ydehEQVIwRZt56PmmHyDJv4Q0=; b=Etj5CWYvMeISloVay/qRvTBmiZ
        eVdXR0WtDLU8avoWBHTMNsC2mdVq1yej3sdAa/M8i8MJi3XColtlTHXPXfrtIvjLQXPmLaWYchzlI
        3Hvj0p9NUeeSt2EX28avq/Y1Rsmrso5Ph12xiLJOA/ncaAbY91+edBnfrUalGyfZJEJx3fg5p21v7
        acgo57i8ovE4tCqvTHUL1DE6nF/A8NUflCcectBMtTYW9s582PGOUV2ho/SD8AW+BAuXIE4YnBdr5
        qPrFbl+UYY3sriVGX0weMB3ufPW/h93jq0+FwoUJJAzDlt+Hlp/0wtfV3KLbAuzzPGbJNCmrfuaD3
        qqrMMxbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJWz7-009s0Y-Vd; Mon, 14 Feb 2022 08:45:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B0670300459;
        Mon, 14 Feb 2022 09:45:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63F292028FBEF; Mon, 14 Feb 2022 09:45:22 +0100 (CET)
Date:   Mon, 14 Feb 2022 09:45:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@suse.de>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        zhangqiao22@huawei.com, tj@kernel.org, dietmar.eggemann@arm.com
Subject: Re: [GIT PULL] sched/urgent for 5.17-rc4
Message-ID: <YgoWoh6pIzlsQx6d@hirez.programming.kicks-ass.net>
References: <Ygj7feK+vdtPw6zj@zn.tnic>
 <CAHk-=wiHUWHHcPLCvyXQKf2wbL3L1SOQSGVuCdf-py6QZGnuqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiHUWHHcPLCvyXQKf2wbL3L1SOQSGVuCdf-py6QZGnuqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 10:02:22AM -0800, Linus Torvalds wrote:
> On Sun, Feb 13, 2022 at 4:37 AM Borislav Petkov <bp@suse.de> wrote:
> >
> > Tadeusz Struk (1):
> >       sched/fair: Fix fault in reweight_entity
> 
> I've pulled this, but this really smells bad to me.
> 
> If set_load_weight() can see a process that hasn't even had the
> runqueue pointer set yet, then what keeps *others* from the same
> thing?

Urgh, I think you're right, the moment we enter the pidhash and become
visible we should be complete. That means the previous commit
(4ef0c5c6b5ba) is buggered... Let me try and make sense of all that
cgroup stuff again :-(
