Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0A7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Jan 2022 18:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357874AbiAaSrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Jan 2022 13:47:55 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:53236 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358068AbiAaSqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:46:52 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:38948)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEbhU-006cKj-23; Mon, 31 Jan 2022 11:46:52 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:56364 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEbhT-007mIG-3b; Mon, 31 Jan 2022 11:46:51 -0700
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
Date:   Mon, 31 Jan 2022 12:46:44 -0600
In-Reply-To: <87bkzroica.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Mon, 31 Jan 2022 12:44:53 -0600")
Message-ID: <87tudjn3or.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nEbhT-007mIG-3b;;;mid=<87tudjn3or.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Gp1VOxnkdMqHZyyVp48JozL/woxXtcWE=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 3/5] coredump: Remove the WARN_ON in dump_vma_snapshot
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The condition is impossible and to the best of my knowledge has never
triggered.

We are in deep trouble if that conditions happens and we walk past
the end of our allocated array.

So delete the WARN_ON and the code that makes it look like the kernel
can handle the case of walking past the end of it's vma_meta array.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index def2a0c9cb14..c5e7d63525c6 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1127,10 +1127,5 @@ static bool dump_vma_snapshot(struct coredump_params *cprm)
 
 	mmap_write_unlock(mm);
 
-	if (WARN_ON(i != cprm->vma_count)) {
-		kvfree(cprm->vma_meta);
-		return false;
-	}
-
 	return true;
 }
-- 
2.29.2

