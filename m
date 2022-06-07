Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EE7CCA48B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 02:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392572AbiFHB6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835740AbiFGX4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E36240BB;
        Tue,  7 Jun 2022 16:19:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F12C961745;
        Tue,  7 Jun 2022 23:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3604C3411C;
        Tue,  7 Jun 2022 23:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654643941;
        bh=ZzzuMYRQflijaLaBGfODgyjv11U3286DsATKWuFwpis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4tzwZKLfTJhFiZ6E6ehWQruktJF1G9RCR7xH9LzpMzFvIflKnHRv+NGoljYjEf/D
         2GGR4p4XBrnLRyyQepbNS4pBZofypkhAC9PD4prF/CDDJOQb8Z/NvXRbHS7UUWCMHx
         zcPrPNwfbvhDBQBpQhOUX2589ylWzHF3SBoE7srbHRiDoYZfHOh6KCGTrjWRwgRk1v
         N58ZBwHrloJZYgCtaqQhb/rgiNH3flwfgsF1UJqXa3YWaKK5YH4JJNIneY5Phqupkc
         saueSepJdmC3+kbeduzEfiDVE9LAAeBf3osntAYbeMgarOoV4bL5w2CkuysSb6UM7Z
         FgnilzIcr5W0Q==
Date:   Tue, 7 Jun 2022 16:18:58 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+2c93b863a7698df84bad@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Subject: Re: [syzbot] WARNING: locking bug in truncate_inode_pages_final
Message-ID: <Yp/c4p4MSUyoFenY@sol.localdomain>
References: <0000000000000cf8be05e0d65e09@google.com>
 <20220607160020.c088f4d29929310f2a3c1c32@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607160020.c088f4d29929310f2a3c1c32@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 04:00:20PM -0700, Andrew Morton wrote:
> Lots of cc's added.
> 
> On Tue, 07 Jun 2022 00:16:29 -0700 syzbot <syzbot+2c93b863a7698df84bad@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> 
> Thanks.
> 
> > syzbot found the following issue on:
> 
> Oh dear.
> 
> > HEAD commit:    d1dc87763f40 assoc_array: Fix BUG_ON during garbage collect
> 
> I think this bisection is wrong.

It's not a bisection; if it was, the report would say so.  It's just the commit
that identifies the kernel version on which the problem was seen.

- Eric
