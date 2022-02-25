Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EC0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 17:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243918AbiBYRiT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 12:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243873AbiBYRiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:38:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF5D25C41;
        Fri, 25 Feb 2022 09:37:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B9F6B210E1;
        Fri, 25 Feb 2022 17:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645810656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GY0iFUW9uJV4Vgn8uP3pu0/kxNIDCy02Hy0asV7edUo=;
        b=TXIXb+dwDLgXu7FYESoUdvIw3WVo04Tn7lfRoljMYCviwhHmW1InDMG9ZQjzhXih8TqnNI
        ES+6S6tUSmYt1b2swWoy9lcUJ69gLBkQP4/kolRUjgAXtxWkGHRG+fNa8+fQejAvYGAu+U
        AhFlb6bQkB59K5/cvejRsALjZ6OA0UI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9594513C00;
        Fri, 25 Feb 2022 17:37:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eev8I+ATGWLCOwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 25 Feb 2022 17:37:36 +0000
Date:   Fri, 25 Feb 2022 18:37:35 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Tejun Heo <tj@kernel.org>,
        seanjc@google.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        dmatlack@google.com, jiangshanlai@gmail.com, kvm@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: Move VM's worker kthreads back to the original
 cgroups before exiting.
Message-ID: <20220225173734.GA26252@blackbody.suse.cz>
References: <20211222225350.1912249-1-vipinsh@google.com>
 <20220105180420.GC6464@blackbody.suse.cz>
 <CAHVum0e84nUcGtdPYQaJDQszKj-QVP5gM+nteBpSTaQ2sWYpmQ@mail.gmail.com>
 <Yeclbe3GNdCMLlHz@slm.duckdns.org>
 <7a0bc562-9f25-392d-5c05-9dbcd350d002@redhat.com>
 <YehY0z2vHYVZk52J@slm.duckdns.org>
 <20220120150502.GC27269@blackbody.suse.cz>
 <CAHVum0fOP-2XcUcG3PqW08DY7CmpDroG6Fcv9KoD1FqLmGpB8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVum0fOP-2XcUcG3PqW08DY7CmpDroG6Fcv9KoD1FqLmGpB8w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vipin.

On Wed, Feb 16, 2022 at 09:37:45AM -0800, Vipin Sharma <vipinsh@google.com> wrote:
> On Thu, Jan 20, 2022 at 7:05 AM Michal Koutný <mkoutny@suse.com> wrote:
> > Have I missed an obstacle?

Aha...

[
> I used few other combination where I put kernel_wait() call after
> put_task_struct(k) call.
> 
> Every time during the module exit, kernel was crashing like:

Thanks for trying this out.
]

> Do you have any suggestions what might be the right way to use this API?

...it has occured to me now -- the KVM kthread is not a child of the
wanna-wait user task. So the kernel_wait() silently errs with -ECHILD
and task_struct is released too early and that (probably) brings about
the crash.

I'm sorry for not realizing that initially.

(Generally, any kthread_create'd task would be affected by this. I guess
the KVM worker threads can't be forked from the kvm_create_vm() callers?
(It could prevent the double migration to and from caller's cgroup
though.))

Michal

