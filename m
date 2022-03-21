Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F890C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 15:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349776AbiCUPE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 11:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346270AbiCUPE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:04:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCE163AE;
        Mon, 21 Mar 2022 08:02:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4CCEE210E7;
        Mon, 21 Mar 2022 15:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647874977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OkgYg9DsjYEvDqx12odqmwwGLMGZxuZ1Rg8inY0wdNY=;
        b=EwdDAPf2rxnWpgRabYg6f9trBDXYGpHOBzPOIJnFPy6wfUY+KOeFRMUMTwUUo3whDNYSoz
        Zjow8ecoGAXjZTKP18FatBKJ7LATJ1TAU8kyoRtitEI2K557dqYIxTmEy4yNTdSTLI9Hv5
        sIeMUwrkazwmnJQ8m8wO8QT8CjYFGPU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5D02FA3B93;
        Mon, 21 Mar 2022 15:02:56 +0000 (UTC)
Date:   Mon, 21 Mar 2022 16:02:55 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, surenb@google.com,
        vbabka@suse.cz, rientjes@google.com, sfr@canb.auug.org.au,
        edgararriaga@google.com, nadav.amit@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "# 5 . 10+" <stable@vger.kernel.org>
Subject: Re: [PATCH V2,2/2] mm: madvise: skip unmapped vma holes passed to
 process_madvise
Message-ID: <YjiTn+7vw2rXA6K/@dhcp22.suse.cz>
References: <cover.1647008754.git.quic_charante@quicinc.com>
 <4f091776142f2ebf7b94018146de72318474e686.1647008754.git.quic_charante@quicinc.com>
 <YjEaFBWterxc3Nzf@google.com>
 <20220315164807.7a9cf1694ee2db8709a8597c@linux-foundation.org>
 <YjFAzuLKWw5eadtf@google.com>
 <5428f192-1537-fa03-8e9c-4a8322772546@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5428f192-1537-fa03-8e9c-4a8322772546@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-03-22 19:49:38, Charan Teja Kalla wrote:
[...]
> It can return EINTR when:
> -------------------------
> 1) PTRACE_MODE_READ is being checked in mm_access() where it is waiting
> on task->signal->exec_update_lock. EINTR returned from here guarantees
> that process_madvise() didn't event start processing.
> https://elixir.bootlin.com/linux/v5.16.14/source/mm/madvise.c#L1264 -->
> https://elixir.bootlin.com/linux/v5.16.14/source/kernel/fork.c#L1318
> 
> 2) The process_madvise() started processing VMA's but the required
> behavior on a VMA needs mmap_write_lock_killable(), from where EINTR is
> returned.

Please note this will happen if the task has been killed. The return
value doesn't really matter because the process won't run in userspace.

> The current behaviours supported by process_madvise(),
> MADV_COLD, PAGEOUT, WILLNEED, just need read lock here.
> https://elixir.bootlin.com/linux/v5.16.14/source/mm/madvise.c#L1164
>  **Thus I think no way for EINTR can be returned by process_madvise() in
> the middle of processing.** . No?

Maybe not with the current implementation but I can easily imagine that
there is a requirement to break out early when there is a signal pending
(e.g. to support terminating madvise on a large memory rage). You would
get EINTR then somehow need to communicate that to the userspace.

-- 
Michal Hocko
SUSE Labs
