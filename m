Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF75C4167B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 15:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382762AbiBGPay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 10:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354705AbiBGP3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:29:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC9EC0401C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:29:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DA07614A8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5479C340F2;
        Mon,  7 Feb 2022 15:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644247786;
        bh=dMUyMU0LHN0r8PSbqN8lbB9OEvUmTIGKuewXXeRUhoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dh32CDGo444hv7mPC3cu9ZAwCvu/rWBHD3KcxtU57xIaLFdHOXQc0hhau/pDU0idz
         +LV28k1SKGdqB87lM7K9VjkwPVFrNIWe5NFf0YDPuNBu5e+fdggeEof3JP0Nw6Iye6
         07CpraT3XF1Zaibtg3cWIjB9kHuxQQtIoHBZuDDgjuXqQeGKeNSrL1VyFjxN+tzvKs
         7wBL+WbtrgplpeZBoFHqMvCe2qSSatnySrzoh9gHVlyoNHnqrR0ivU+L6S1O4PgKx/
         x/tpC6lAQ55OKVk7X1LpxxffE0LJjc3FPxyclOurKvsRDrfHfp+4PSFsSrgMONnd8F
         tpxFGDWSTQAOg==
Date:   Mon, 7 Feb 2022 16:29:43 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: Re: [patch v11 07/13] task isolation: sync vmstats conditional on
 changes
Message-ID: <20220207152943.GB526112@lothringen>
References: <20220204173537.429902988@fedora.localdomain>
 <20220204173554.763888172@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204173554.763888172@fedora.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 02:35:44PM -0300, Marcelo Tosatti wrote:
> Rather than syncing VM-stats on every return to userspace
> (or VM-entry), keep track of changes through a per-CPU bool.
> 
> This improves performance when enabling task isolated
> for vcpu VMs.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
> v11:
> - Add TIF_TASK_ISOL bit to thread info flags and use it
>   to decide whether to perform task isolation work on
>   return to userspace     
> 
>  include/linux/vmstat.h |   13 ++++++++++++-
>  mm/vmstat.c            |   29 ++++++++++++++++++++++++++++-
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/include/linux/vmstat.h
> ===================================================================
> --- linux-2.6.orig/include/linux/vmstat.h
> +++ linux-2.6/include/linux/vmstat.h
> @@ -22,7 +22,18 @@ int sysctl_vm_numa_stat_handler(struct c
>  #endif
>  
>  #if defined(CONFIG_SMP) && defined(CONFIG_TASK_ISOLATION)
> -void sync_vmstat(void);
> +DECLARE_PER_CPU_ALIGNED(bool, vmstat_dirty);
> +
> +extern struct static_key vmstat_sync_enabled;
> +
> +void __sync_vmstat(void);
> +static inline void sync_vmstat(void)
> +{
> +	if (static_key_false(&vmstat_sync_enabled))
> +		__sync_vmstat();
> +}
> +
> +void init_sync_vmstat(void);
>  #else
>  static inline void sync_vmstat(void)
>  {
> Index: linux-2.6/mm/vmstat.c
> ===================================================================
> --- linux-2.6.orig/mm/vmstat.c
> +++ linux-2.6/mm/vmstat.c
> @@ -334,6 +334,31 @@ void set_pgdat_percpu_threshold(pg_data_
>  	}
>  }
>  
> +#ifdef CONFIG_TASK_ISOLATION
> +struct static_key vmstat_sync_enabled;
> +DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
> +
> +static inline void mark_vmstat_dirty(void)
> +{
> +	if (!static_key_false(&vmstat_sync_enabled))
> +		return;
> +
> +	raw_cpu_write(vmstat_dirty, true);
> +	set_thread_flag(TIF_TASK_ISOL);

This will force the return-to-user slow path on all CPUs,
whether the current task is isolated or not, right?

Also if we context switch to an isolated TASK B with a dirty vmstat,
we miss the TIF_TASK_ISOL.
