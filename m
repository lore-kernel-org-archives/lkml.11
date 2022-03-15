Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087E4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 23:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbiCOXte (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 19:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352638AbiCOXt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 19:49:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373A421807;
        Tue, 15 Mar 2022 16:48:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8EFF6CE1D92;
        Tue, 15 Mar 2022 23:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA62C340F3;
        Tue, 15 Mar 2022 23:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1647388088;
        bh=lFbXIDa4QnBNJa5XI+6aSCuy5aLkXoZmkzSUjIS9Nus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nyfrMxNivbfRHfA/kgKORjOUDtNO0xiJdHK0Zph9F8/JEoL/jy+f1ikCofXmx6Ehf
         ZaG3CsR7684FTWNeIUJoRVTiz0it3ilSem5lDIkIYt5AkzCH2aaGRLkr7B+PbUWICp
         skiCnZTtAWjy0s3a6cMbZfgY7S3RC5np5wZ4DQgo=
Date:   Tue, 15 Mar 2022 16:48:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Charan Teja Kalla <quic_charante@quicinc.com>, surenb@google.com,
        vbabka@suse.cz, rientjes@google.com, sfr@canb.auug.org.au,
        edgararriaga@google.com, nadav.amit@gmail.com, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "# 5 . 10+" <stable@vger.kernel.org>
Subject: Re: [PATCH V2,2/2] mm: madvise: skip unmapped vma holes passed to
 process_madvise
Message-Id: <20220315164807.7a9cf1694ee2db8709a8597c@linux-foundation.org>
In-Reply-To: <YjEaFBWterxc3Nzf@google.com>
References: <cover.1647008754.git.quic_charante@quicinc.com>
        <4f091776142f2ebf7b94018146de72318474e686.1647008754.git.quic_charante@quicinc.com>
        <YjEaFBWterxc3Nzf@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 15:58:28 -0700 Minchan Kim <minchan@kernel.org> wrote:

> On Fri, Mar 11, 2022 at 08:59:06PM +0530, Charan Teja Kalla wrote:
> > The process_madvise() system call is expected to skip holes in vma
> > passed through 'struct iovec' vector list. But do_madvise, which
> > process_madvise() calls for each vma, returns ENOMEM in case of unmapped
> > holes, despite the VMA is processed.
> > Thus process_madvise() should treat ENOMEM as expected and consider the
> > VMA passed to as processed and continue processing other vma's in the
> > vector list. Returning -ENOMEM to user, despite the VMA is processed,
> > will be unable to figure out where to start the next madvise.
> > Fixes: ecb8ac8b1f14("mm/madvise: introduce process_madvise() syscall: an external memory hinting API")
> > Cc: <stable@vger.kernel.org> # 5.10+
> 
> Hmm, not sure whether it's stable material since it changes semantic of
> API. It would be better to change the semantic from 5.19 with man page
> update to specify the change.

It's a very desirable change and it makes the code match the manpage
and it's cc:stable.  I think we should just absorb any transitory
damage which this causes people.  I doubt if there will be much - if
anyone was affected by this they would have already told us that it's
broken?


