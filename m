Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D23C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Feb 2022 14:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbiBBOr3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Feb 2022 09:47:29 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:39820 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239800AbiBBOrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:47:23 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:48348)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nFGun-007XXE-Vf; Wed, 02 Feb 2022 07:47:22 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:53402 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nFGum-00BUj3-V9; Wed, 02 Feb 2022 07:47:21 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Jann Horn <jannh@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <liam.howlett@oracle.com>
References: <20220131153740.2396974-1-willy@infradead.org>
        <871r0nriy4.fsf@email.froward.int.ebiederm.org>
        <YfgKw5z2uswzMVRQ@casper.infradead.org>
        <877dafq3bw.fsf@email.froward.int.ebiederm.org>
        <YfgPwPvopO1aqcVC@casper.infradead.org>
        <CAG48ez3MCs8d8hjBfRSQxwUTW3o64iaSwxF=UEVtk+SEme0chQ@mail.gmail.com>
        <87bkzroica.fsf_-_@email.froward.int.ebiederm.org>
        <87iltzn3nd.fsf_-_@email.froward.int.ebiederm.org>
        <CAG48ez3zfi1eHAgGPPEC=pB3oMUBif28Ns4qncUbxpCbMPYdgA@mail.gmail.com>
Date:   Wed, 02 Feb 2022 08:46:22 -0600
In-Reply-To: <CAG48ez3zfi1eHAgGPPEC=pB3oMUBif28Ns4qncUbxpCbMPYdgA@mail.gmail.com>
        (Jann Horn's message of "Tue, 1 Feb 2022 20:02:54 +0100")
Message-ID: <87wnidl41t.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nFGum-00BUj3-V9;;;mid=<87wnidl41t.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19+3fQZJhoRZ5kCJCpZEfNeAZFufd3xf8A=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 5/5] coredump: Use the vma snapshot in fill_files_note
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> writes:

> On Mon, Jan 31, 2022 at 7:47 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Matthew Wilcox reported that there is a missing mmap_lock in
>> file_files_note that could possibly lead to a user after free.
>>
>> Solve this by using the existing vma snapshot for consistency
>> and to avoid the need to take the mmap_lock anywhere in the
>> coredump code except for dump_vma_snapshot.
>>
>> Update the dump_vma_snapshot to capture vm_pgoff and vm_file
>> that are neeeded by fill_files_note.
>>
>> Add free_vma_snapshot to free the captured values of vm_file.
>>
>> Reported-by: Matthew Wilcox <willy@infradead.org>
>> Link: https://lkml.kernel.org/r/20220131153740.2396974-1-willy@infradead.org
>> Cc: stable@vger.kernel.org
>> Fixes: a07279c9a8cd ("binfmt_elf, binfmt_elf_fdpic: use a VMA list snapshot")
>> Fixes: 2aa362c49c31 ("coredump: extend core dump note section to contain file names of mapped files")
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> [...]
>> +static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm)
>>  {
>>         struct mm_struct *mm = current->mm;
>> -       struct vm_area_struct *vma;
>>         unsigned count, size, names_ofs, remaining, n;
>>         user_long_t *data;
>>         user_long_t *start_end_ofs;
>>         char *name_base, *name_curpos;
>> +       int i;
>>
>>         /* *Estimated* file count and total data size needed */
>>         count = mm->map_count;
>
> This function is still looking at mm->map_count in two spots, please
> change those spots to also look at cprm->vma_count. In particular the
> second one looks like it can cause memory corruption if the map_count
> changed since we created the snapshot.

Could catch I will fix that.  Correcting it not to use mm->map_count
looks like a fundamental part of the fix, and I missed it.  Oops!

> [...]
>> +static void free_vma_snapshot(struct coredump_params *cprm)
>> +{
>> +       if (cprm->vma_meta) {
>> +               int i;
>> +               for (i = 0; i < cprm->vma_count; i++) {
>> +                       struct file *file = cprm->vma_meta[i].file;
>> +                       if (file)
>> +                               fput(file);
>> +               }
>> +               kvfree(cprm->vma_meta);
>> +               cprm->vma_meta = NULL;
>
> (this NULL write is superfluous, but it also doesn't hurt)

Agreed.  It just makes the possible failure modes nicer.

Eric
