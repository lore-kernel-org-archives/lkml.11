Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E960BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jan 2022 19:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243293AbiAFTVU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jan 2022 14:21:20 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:39562 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243233AbiAFTVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 14:21:18 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:43200)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5YK2-00FHHU-Py; Thu, 06 Jan 2022 12:21:14 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:53282 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5YJy-00EYlo-V1; Thu, 06 Jan 2022 12:21:13 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Pintu Kumar <quic_pintu@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        "christian.brauner\@ubuntu.com" <christian.brauner@ubuntu.com>,
        "sfr\@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "legion\@kernel.org" <legion@kernel.org>,
        "sashal\@kernel.org" <sashal@kernel.org>,
        "chris.hyser\@oracle.com" <chris.hyser@oracle.com>,
        "ccross\@google.com" <ccross@google.com>,
        "pcc\@google.com" <pcc@google.com>,
        "dave\@stgolabs.net" <dave@stgolabs.net>,
        "caoxiaofeng\@yulong.com" <caoxiaofeng@yulong.com>,
        "david\@redhat.com" <david@redhat.com>
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
        <YdcUttZWaqYQpR1K@grain>
        <CAOuPNLifYFPU4Gt2+1sOSsYNNLQq7U2aGVaYknrhaMc-CVx8vg@mail.gmail.com>
        <14316cf852784a32b5214119a9d976cf@AcuMS.aculab.com>
        <CAOuPNLjh+OhnqqGWWj015eQmwGqp96iu2zycVq4sM+K7JjxumQ@mail.gmail.com>
Date:   Thu, 06 Jan 2022 13:20:05 -0600
In-Reply-To: <CAOuPNLjh+OhnqqGWWj015eQmwGqp96iu2zycVq4sM+K7JjxumQ@mail.gmail.com>
        (Pintu Agarwal's message of "Thu, 6 Jan 2022 23:29:02 +0530")
Message-ID: <87lezs4qoq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n5YJy-00EYlo-V1;;;mid=<87lezs4qoq.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/mqfe7CWdGqQOSOMJXSThU0zvAUZRJ1ig=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] sysinfo: include availram field in sysinfo struct
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pintu Agarwal <pintu.ping@gmail.com> writes:

> On Thu, 6 Jan 2022 at 23:12, David Laight <David.Laight@aculab.com> wrote:
>>
>> From: Pintu Agarwal
>> > Sent: 06 January 2022 16:50
>> >
>> > On Thu, 6 Jan 2022 at 21:41, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
>> > >
>> > > On Thu, Jan 06, 2022 at 09:04:10PM +0530, Pintu Kumar wrote:
>> > > > The sysinfo member does not have any "available ram" field and
>> > > > the bufferram field is not much helpful either, to get a rough
>> > > > estimate of available ram needed for allocation.
>> > > >
>> > > > One needs to parse MemAvailable field separately from /proc/meminfo
>> > > > to get this info instead of directly getting if from sysinfo itself.
>> > > >
>> > > > Thus, this patch introduce a new field as availram in sysinfo
>> > > > so that all the info total/free/available can be retrieved from
>> > > > one place itself.
>> > > >
>> > > > There are couple of places in kernel as well where this can be improved.
>> > > > For example:
>> > > > In fs/proc/meminfo.c:
>> > > > meminfo_proc_show:
>> > > >    si_meminfo(&i);
>> > > >    available = si_mem_available();
>> > > > Now with this change the second call be avoided.
>> > > > Thus, we can directly do:
>> > > > show_val_kb(m, "MemAvailable:   ", i.availram);
>> > > >
>> > > > Note, this also requires update in procfs for free and other commands.
>> > > > Like in free command as well we frist call sysinfo then again parse
>> > > > /proc/meminfo to get available field.
>> > > > This can be avoided too with higher kernel version.
>> > > >
>> > > > A sample output with single sysinfo call is shown below:
>> > > > Total RAM: 248376 kB
>> > > >  Free RAM: 231540 kB
>> > > > Avail RAM: 230448 kB
>> > > >
>> > > > Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
>> > > > Signed-off-by: Pintu Agarwal <pintu.ping@gmail.com>
>> > > > ---
>> > > >  include/uapi/linux/sysinfo.h | 1 +
>> > > >  kernel/sys.c                 | 4 ++++
>> > > >  mm/page_alloc.c              | 2 ++
>> > > >  3 files changed, 7 insertions(+)
>> > > >
>> > > > diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
>> > > > index 435d5c2..6e77e90 100644
>> > > > --- a/include/uapi/linux/sysinfo.h
>> > > > +++ b/include/uapi/linux/sysinfo.h
>> > > > @@ -12,6 +12,7 @@ struct sysinfo {
>> > > >       __kernel_ulong_t freeram;       /* Available memory size */
>> > > >       __kernel_ulong_t sharedram;     /* Amount of shared memory */
>> > > >       __kernel_ulong_t bufferram;     /* Memory used by buffers */
>> > > > +     __kernel_ulong_t availram;      /* Memory available for allocation */
>> > > >       __kernel_ulong_t totalswap;     /* Total swap space size */
>> > > >       __kernel_ulong_t freeswap;      /* swap space still available */
>> > > >       __u16 procs;                    /* Number of current processes */
>> > >
>> > > Hi! Sorry, but I don't understand -- the sysinfo structure seems to
>> > > be part of user API, no? Don't we break it up here?
>> >
>> > Yes, the corresponding user space header /usr/include/linux/sysinfo.h
>> > also needs to be updated.
>> > When we generate the kernel header it will be updated automatically.
>>
>> You can't add a field in the middle of a UAPI structure.
>> It breaks compatibility for old binaries.
>>
>> Depending on the interface definition you may be able to add one at the end.
>>
> oh okay thank you for your feedback. I will move to the end and check again.
> But my doubt is, whether I should move before this
> char _f[20-2*sizeof(__kernel_ulong_t)-sizeof(__u32)];
> or after this ?

Before the padding and you should reduce the size of the padding by the
size of your new field.

> Also, I could not understand what this is for ?
> Do we need to update this since sture is changed ?

In general padding like that is so new fields can be added.  The
comment about libc5 makes me a wonder a bit, but I expect libc5 just
added the padding in it's copy of the structure that it exported to
userspace many many years ago so that new fields could be added.

Eric

