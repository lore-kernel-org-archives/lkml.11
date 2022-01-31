Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A50C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Jan 2022 17:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381040AbiAaRjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Jan 2022 12:39:01 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:34846 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350348AbiAaRi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:38:59 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:39938)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEadm-006TnZ-D3; Mon, 31 Jan 2022 10:38:58 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:53122 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEadk-00Ek8G-Sm; Mon, 31 Jan 2022 10:38:57 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
References: <20220131153740.2396974-1-willy@infradead.org>
        <871r0nriy4.fsf@email.froward.int.ebiederm.org>
        <YfgKw5z2uswzMVRQ@casper.infradead.org>
        <877dafq3bw.fsf@email.froward.int.ebiederm.org>
        <YfgPwPvopO1aqcVC@casper.infradead.org>
Date:   Mon, 31 Jan 2022 11:38:49 -0600
In-Reply-To: <YfgPwPvopO1aqcVC@casper.infradead.org> (Matthew Wilcox's message
        of "Mon, 31 Jan 2022 16:35:12 +0000")
Message-ID: <87pmo7olee.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nEadk-00Ek8G-Sm;;;mid=<87pmo7olee.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX195xKksb9tu1SBZnByujzw772B/SHtjq3k=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] binfmt_elf: Take the mmap lock when walking the VMA list
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Jan 31, 2022 at 10:26:11AM -0600, Eric W. Biederman wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> 
>> > On Mon, Jan 31, 2022 at 10:03:31AM -0600, Eric W. Biederman wrote:
>> >> "Matthew Wilcox (Oracle)" <willy@infradead.org> writes:
>> >> 
>> >> > I'm not sure if the VMA list can change under us, but dump_vma_snapshot()
>> >> > is very careful to take the mmap_lock in write mode.  We only need to
>> >> > take it in read mode here as we do not care if the size of the stack
>> >> > VMA changes underneath us.
>> >> >
>> >> > If it can be changed underneath us, this is a potential use-after-free
>> >> > for a multithreaded process which is dumping core.
>> >> 
>> >> The problem is not multi-threaded process so much as processes that
>> >> share their mm.
>> >
>> > I don't understand the difference.  I appreciate that another process can
>> > get read access to an mm through, eg, /proc, but how can another process
>> > (that isn't a thread of this process) modify the VMAs?
>> 
>> There are a couple of ways.
>> 
>> A classic way is a multi-threads process can call vfork, and the
>> mm_struct is shared with the child until exec is called.
>
> While true, I thought the semantics of vfork() were that the parent
> was suspended.  Given that, it can't core dump until the child execs
> ... right?

The thread that called vfork is suspended.  The other threads can
continue to execute.

>> A process can do this more deliberately by forking a child using
>> clone(CLONE_VM) and not including CLONE_THREAD.   Supporting this case
>> is a hold over from before CLONE_THREAD was supported in the kernel and
>> such processes were used to simulate threads.
>
> That is a multithreaded process then!  Maybe not in the strict POSIX
> compliance sense, but the intent is to be a multithreaded process.
> ie multiple threads of execution, sharing an address space.

Sometimes.  From a coredump perspective it is just another process
that happens to share the mm.  Like the vfork process.

For a while the coredump code was trying to kill and possibly dump all
of these ``threads'' that shared a vm.  The practical problem was that
a failing exec after vfork could trigger a coredump that would kill
it's parent process.

So when I look at these from a coredump or signal perspective I just
treat them as weird processes that happen to share an mm_struct.

>> It also happens that there are subsystems in the kernel that do things
>> like kthread_use_mm that can also be modifying the mm during a coredump.
>
> Yikes.  That's terrifying.  It's really legitimate for a kthread to
> attach to a process and start tearing down VMAs?

I don't know how much VMA manipulation makes sense but it is legitimate
to attach to an mm and do those things as Jann pointed out.

> Thanks.  Now that I've disclosed it's a UAF, I hope you're able to
> get to it soon.  Otherwise we should put this band-aid in for now
> and you can address it properly in the fullness of time.

Working on it now.

Eric

