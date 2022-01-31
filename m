Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2787BC433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Jan 2022 18:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358036AbiAaSr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Jan 2022 13:47:58 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:53356 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357870AbiAaSrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:47:21 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:50520)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEbhx-006cNW-6f; Mon, 31 Jan 2022 11:47:21 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:56388 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEbhw-00Exkv-4G; Mon, 31 Jan 2022 11:47:20 -0700
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
Date:   Mon, 31 Jan 2022 12:47:13 -0600
In-Reply-To: <87bkzroica.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Mon, 31 Jan 2022 12:44:53 -0600")
Message-ID: <87o83rn3ny.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nEbhw-00Exkv-4G;;;mid=<87o83rn3ny.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19S/e7oyEfO8SwfZT/2oAjoeauEQ0xvO5A=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 4/5] coredump/elf: Pass coredump_params into fill_note_info
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Instead of individually passing cprm->siginfo and cprm->regs
into fill_note_info pass all of struct coredump_params.

This is preparation to allow fill_files_note to use the existing
vma snapshot.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/binfmt_elf.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 4822b04154e1..272032b1f9a2 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1800,7 +1800,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 
 static int fill_note_info(struct elfhdr *elf, int phdrs,
 			  struct elf_note_info *info,
-			  const kernel_siginfo_t *siginfo, struct pt_regs *regs)
+			  struct coredump_params *cprm)
 {
 	struct task_struct *dump_task = current;
 	const struct user_regset_view *view = task_user_regset_view(dump_task);
@@ -1872,7 +1872,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	 * Now fill in each thread's information.
 	 */
 	for (t = info->thread; t != NULL; t = t->next)
-		if (!fill_thread_core_info(t, view, siginfo->si_signo, &info->size))
+		if (!fill_thread_core_info(t, view, cprm->siginfo->si_signo, &info->size))
 			return 0;
 
 	/*
@@ -1881,7 +1881,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	fill_psinfo(psinfo, dump_task->group_leader, dump_task->mm);
 	info->size += notesize(&info->psinfo);
 
-	fill_siginfo_note(&info->signote, &info->csigdata, siginfo);
+	fill_siginfo_note(&info->signote, &info->csigdata, cprm->siginfo);
 	info->size += notesize(&info->signote);
 
 	fill_auxv_note(&info->auxv, current->mm);
@@ -2029,7 +2029,7 @@ static int elf_note_info_init(struct elf_note_info *info)
 
 static int fill_note_info(struct elfhdr *elf, int phdrs,
 			  struct elf_note_info *info,
-			  const kernel_siginfo_t *siginfo, struct pt_regs *regs)
+			  struct coredump_params *cprm)
 {
 	struct core_thread *ct;
 	struct elf_thread_status *ets;
@@ -2050,13 +2050,13 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	list_for_each_entry(ets, &info->thread_list, list) {
 		int sz;
 
-		sz = elf_dump_thread_status(siginfo->si_signo, ets);
+		sz = elf_dump_thread_status(cprm->siginfo->si_signo, ets);
 		info->thread_status_size += sz;
 	}
 	/* now collect the dump for the current */
 	memset(info->prstatus, 0, sizeof(*info->prstatus));
-	fill_prstatus(&info->prstatus->common, current, siginfo->si_signo);
-	elf_core_copy_regs(&info->prstatus->pr_reg, regs);
+	fill_prstatus(&info->prstatus->common, current, cprm->siginfo->si_signo);
+	elf_core_copy_regs(&info->prstatus->pr_reg, cprm->regs);
 
 	/* Set up header */
 	fill_elf_header(elf, phdrs, ELF_ARCH, ELF_CORE_EFLAGS);
@@ -2072,7 +2072,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	fill_note(info->notes + 1, "CORE", NT_PRPSINFO,
 		  sizeof(*info->psinfo), info->psinfo);
 
-	fill_siginfo_note(info->notes + 2, &info->csigdata, siginfo);
+	fill_siginfo_note(info->notes + 2, &info->csigdata, cprm->siginfo);
 	fill_auxv_note(info->notes + 3, current->mm);
 	info->numnote = 4;
 
@@ -2082,8 +2082,8 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	}
 
 	/* Try to dump the FPU. */
-	info->prstatus->pr_fpvalid = elf_core_copy_task_fpregs(current, regs,
-							       info->fpu);
+	info->prstatus->pr_fpvalid =
+		elf_core_copy_task_fpregs(current, cprm->regs, info->fpu);
 	if (info->prstatus->pr_fpvalid)
 		fill_note(info->notes + info->numnote++,
 			  "CORE", NT_PRFPREG, sizeof(*info->fpu), info->fpu);
@@ -2196,7 +2196,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 	 * Collect all the non-memory information about the process for the
 	 * notes.  This also sets up the file header.
 	 */
-	if (!fill_note_info(&elf, e_phnum, &info, cprm->siginfo, cprm->regs))
+	if (!fill_note_info(&elf, e_phnum, &info, cprm))
 		goto end_coredump;
 
 	has_dumped = 1;
-- 
2.29.2

