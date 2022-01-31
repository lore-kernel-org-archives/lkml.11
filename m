Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616BDC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Jan 2022 18:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357525AbiAaSpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Jan 2022 13:45:40 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:58930 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357451AbiAaSpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:45:31 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:43508)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEbg7-00HX5m-Ap; Mon, 31 Jan 2022 11:45:27 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:56304 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEbg6-00ExG7-Ey; Mon, 31 Jan 2022 11:45:26 -0700
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
Date:   Mon, 31 Jan 2022 12:44:53 -0600
In-Reply-To: <CAG48ez3MCs8d8hjBfRSQxwUTW3o64iaSwxF=UEVtk+SEme0chQ@mail.gmail.com>
        (Jann Horn's message of "Mon, 31 Jan 2022 18:13:42 +0100")
Message-ID: <87bkzroica.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nEbg6-00ExG7-Ey;;;mid=<87bkzroica.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19oFCEDmwWeui1ca5Jl0D8bAX1MI6wleEw=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 0/5] Fix fill_files_note
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew Wilcox has reported that a missing mmap_lock in file_files_note,
which could cause trouble.

Refactor the code and clean it up so that the vma snapshot makes
it to fill_files_note, and then use the vma snapshot in fill_files_note.

Folks please review this as this looks correct to me but I haven't done
anything beyond compile testing this yet.

Eric W. Biederman (5):
      coredump: Move definition of struct coredump_params into coredump.h
      coredump: Snapshot the vmas in do_coredump
      coredump: Remove the WARN_ON in dump_vma_snapshot
      coredump/elf: Pass coredump_params into fill_note_info
      coredump: Use the vma snapshot in fill_files_note

 fs/binfmt_elf.c          | 61 ++++++++++++++++++++++--------------------------
 fs/binfmt_elf_fdpic.c    | 18 +++++---------
 fs/coredump.c            | 55 +++++++++++++++++++++++++++++--------------
 include/linux/binfmts.h  | 13 +----------
 include/linux/coredump.h | 20 ++++++++++++----
 5 files changed, 88 insertions(+), 79 deletions(-)


Eric
