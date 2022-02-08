Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4350C4167D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 22:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387841AbiBHW26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387257AbiBHWRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 17:17:07 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF6CC0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 14:17:06 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHYnA-000TfY-U2; Tue, 08 Feb 2022 22:16:57 +0000
Date:   Tue, 8 Feb 2022 22:16:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Waiman Long <longman@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Gladkov <legion@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] copy_process(): Move fd_install() out of
 sighand->siglock critical section
Message-ID: <YgLr2GEXgz/TxdUA@zeniv-ca.linux.org.uk>
References: <20220208163912.1084752-1-longman@redhat.com>
 <YgKziblMKsmHkP4f@zeniv-ca.linux.org.uk>
 <bd83aca3-059f-92dd-e094-b27f51f9481a@redhat.com>
 <YgK/fdYWi0wWysci@zeniv-ca.linux.org.uk>
 <874k59f2ad.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874k59f2ad.fsf@email.froward.int.ebiederm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 03:59:06PM -0600, Eric W. Biederman wrote:

> The fd is being installed in the fdtable of the parent process,
> and the siglock and tasklist_lock are held to protect the child.
> 
> 
> Further fd_install is exposing the fd to userspace where it can be used
> by the process_madvise and the process_mrelease system calls, from
> anything that shares the fdtable of the parent thread.  Which means it
> needs to be guaranteed that kernel_clone will call wake_up_process
> before it is safe to call fd_install.

You mean "no calling fd_install() until after we are past the last possible
failure exit, by which point we know that wake_up_process() will eventually
be called", hopefully?  If so (as I assumed all along), anything downstream
of
        if (fatal_signal_pending(current)) {
		retval = -EINTR;
		goto bad_fork_cancel_cgroup;
	}

should be fine...
