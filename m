Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C50C433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Feb 2022 15:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345536AbiBBPlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Feb 2022 10:41:52 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:44812 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbiBBPlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:41:51 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:40424)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nFHlW-00EXfX-2o; Wed, 02 Feb 2022 08:41:50 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:55992 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nFHlT-00BxRp-Mu; Wed, 02 Feb 2022 08:41:49 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Jann Horn <jannh@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220131153740.2396974-1-willy@infradead.org>
        <871r0nriy4.fsf@email.froward.int.ebiederm.org>
        <YfgKw5z2uswzMVRQ@casper.infradead.org>
        <877dafq3bw.fsf@email.froward.int.ebiederm.org>
        <YfgPwPvopO1aqcVC@casper.infradead.org>
        <CAG48ez3MCs8d8hjBfRSQxwUTW3o64iaSwxF=UEVtk+SEme0chQ@mail.gmail.com>
        <87bkzroica.fsf_-_@email.froward.int.ebiederm.org>
        <87zgnbn3pd.fsf_-_@email.froward.int.ebiederm.org>
        <CAG48ez0uV87=myLX1X1KjQ_8q_Sgg1QZBG6vpdkGLWj==EAUBw@mail.gmail.com>
Date:   Wed, 02 Feb 2022 09:41:40 -0600
In-Reply-To: <CAG48ez0uV87=myLX1X1KjQ_8q_Sgg1QZBG6vpdkGLWj==EAUBw@mail.gmail.com>
        (Jann Horn's message of "Tue, 1 Feb 2022 19:32:58 +0100")
Message-ID: <87tudhjmx7.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nFHlT-00BxRp-Mu;;;mid=<87tudhjmx7.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19hxM+4jOLsisAUfqQ7uFK0r+nGxRFEAbA=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 2/5] coredump: Snapshot the vmas in do_coredump
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> writes:

> On Mon, Jan 31, 2022 at 7:46 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Move the call of dump_vma_snapshot and kvfree(vma_meta) out of the
>> individual coredump routines into do_coredump itself.  This makes
>> the code less error prone and easier to maintain.
>>
>> Make the vma snapshot available to the coredump routines
>> in struct coredump_params.  This makes it easier to
>> change and update what is captures in the vma snapshot
>> and will be needed for fixing fill_file_notes.
>>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Reviewed-by: Jann Horn <jannh@google.com>
>
>>         for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
>>                         vma = next_vma(vma, gate_vma), i++) {
>> -               struct core_vma_metadata *m = (*vma_meta) + i;
>> +               struct core_vma_metadata *m = cprm->vma_meta + i;
>>
>>                 m->start = vma->vm_start;
>>                 m->end = vma->vm_end;
>>                 m->flags = vma->vm_flags;
>>                 m->dump_size = vma_dump_size(vma, cprm->mm_flags);
>>
>> -               vma_data_size += m->dump_size;
>> +               cprm->vma_data_size += m->dump_size;
>
> FYI, this part is probably going to cause a merge conflict with the
> fix https://www.ozlabs.org/~akpm/mmotm/broken-out/coredump-also-dump-first-pages-of-non-executable-elf-libraries.patch
> in akpm's tree. I don't know what the right way to handle that is,
> just thought I'd point it out.

There are not any conflicts in principle we could just let resolution
handle it.  Unfortunately both are candidates for backporting.

Either we replace your fix with a simple deletion of the executable
check, or I need to base mine on yours.

Since I need to repost mine anyway I will look at the latter.

Eric


