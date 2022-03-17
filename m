Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3E8C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 15:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbiCQPJa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 11:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiCQPJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:09:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FBC11C7E2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:08:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D4D16191A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B73C340E9;
        Thu, 17 Mar 2022 15:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647529686;
        bh=VpVhfayEC+TH6g09gw9BzIHjHCB4WvV/mZKgOYWw+kQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DliC2F5naQZQpq6eBYkt/sMD9Ufo18N2xX6nqXHcpzKy3wfHS6BzpJgECkGRCw2Be
         +i+rGr4uCJEUr0chvy3yMLmo6k/CIZeT4492ckUe0veZ3HGUshZQeVQ6konkcdNnsB
         E2VOa3kLC8wfwUOC76nomXY3Wg1qDW27QggTWc+JTh5g51IxxbLzTw6hQuaU9+2hi0
         F5S34Wh2Nsj/H2GqxQBULBVxXmk3yLKOdvK6FncocLeVcweMisV4P/18UtZi2VcNoh
         vs/xeimX6wlGfwTx7XMT9Yt+LQi1p7vrQyZEGdzF49eZleMxh31BgmaaxRAZYopdxh
         a4n8UwOOPvryw==
Date:   Thu, 17 Mar 2022 16:08:04 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: Re: [patch v12 00/13] extensible prctl task isolation interface and
 vmstat sync
Message-ID: <20220317150804.GB459366@lothringen>
References: <20220315153132.717153751@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315153132.717153751@fedora.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 12:31:32PM -0300, Marcelo Tosatti wrote:
> The logic to disable vmstat worker thread, when entering
> nohz full, does not cover all scenarios. For example, it is possible
> for the following to happen:
> 
> 1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
> 2) app runs mlock, which increases counters for mlock'ed pages.
> 3) start -RT loop
> 
> Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
> the mlock, vmstat shepherd can restart vmstat worker thread on
> the CPU in question.
> 
> To fix this, add task isolation prctl interface to quiesce
> deferred actions when returning to userspace.
> 
> The patchset is based on ideas and code from the
> task isolation patchset from Alex Belits:
> https://lwn.net/Articles/816298/
> 
> Please refer to Documentation/userspace-api/task_isolation.rst
> (patch 1) for details. Its attached at the end of this message
> in .txt format as well.
> 
> Note: the prctl interface is independent of nohz_full=.
> 
> The userspace patches can be found at https://people.redhat.com/~mtosatti/task-isol-v6-userspace-patches/
> 
> - qemu-task-isolation.patch: activate task isolation from CPU execution loop
> - rt-tests-task-isolation.patch: add task isolation activation to cyclictest/oslat
> - util-linux-chisol.patch: add chisol tool to util-linux.

I still see a few details to sort out but overall the whole thing looks good:

  Acked-by: Frederic Weisbecker <fweisbec@gmail.com>

Perhaps it's time to apply this patchset on some branch and iterate from there.

Thomas, Peter, what do you think?

Thanks!
