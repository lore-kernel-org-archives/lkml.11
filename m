Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA73DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Feb 2022 15:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345449AbiBBPT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Feb 2022 10:19:56 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:41742 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiBBPTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:19:54 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:60426)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nFHQH-007mjU-5V; Wed, 02 Feb 2022 08:19:53 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:54972 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nFHQF-004Ovl-OG; Wed, 02 Feb 2022 08:19:52 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Bill Messmer <wmessmer@microsoft.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>, stable@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20220126025739.2014888-1-jannh@google.com>
Date:   Wed, 02 Feb 2022 09:19:45 -0600
In-Reply-To: <20220126025739.2014888-1-jannh@google.com> (Jann Horn's message
        of "Wed, 26 Jan 2022 03:57:39 +0100")
Message-ID: <87czk5l2i6.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nFHQF-004Ovl-OG;;;mid=<87czk5l2i6.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19nRtuaon4QkvFcsJ9kI9dJDIYxKnHkUs4=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] coredump: Also dump first pages of non-executable ELF
 libraries
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> writes:

> When I rewrote the VMA dumping logic for coredumps, I changed it to
> recognize ELF library mappings based on the file being executable instead
> of the mapping having an ELF header. But turns out, distros ship many ELF
> libraries as non-executable, so the heuristic goes wrong...
>
> Restore the old behavior where FILTER(ELF_HEADERS) dumps the first page of
> any offset-0 readable mapping that starts with the ELF magic.
>
> This fix is technically layer-breaking a bit, because it checks for
> something ELF-specific in fs/coredump.c; but since we probably want to
> share this between standard ELF and FDPIC ELF anyway, I guess it's fine?
> And this also keeps the change small for backporting.

In light of the conflict with my other changes, and in light of the pain
of calling get_user.

Is there any reason why the doesn't unconditionally dump all headers?
Something like the diff below?

I looked in the history and the code was filtering for ELF headers
there already.  I am just thinking this feels like a good idea
regardless of the file format to help verify the file on-disk
is the file we think was mapped.

Eric

diff --git a/fs/coredump.c b/fs/coredump.c
index 6a97a8ea7295..ef3b03e4cf59 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1047,8 +1047,7 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
         * dump the first page to aid in determining what was mapped here.
         */
        if (FILTER(ELF_HEADERS) &&
-           vma->vm_pgoff == 0 && (vma->vm_flags & VM_READ) &&
-           (READ_ONCE(file_inode(vma->vm_file)->i_mode) & 0111) != 0)
+           vma->vm_pgoff == 0 && (vma->vm_flags & VM_READ))
                return PAGE_SIZE;
 
 #undef FILTER


