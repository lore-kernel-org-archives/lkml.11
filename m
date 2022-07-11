Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE8BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 20:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiGKUAs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 16:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKUAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:00:47 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718A83C8F6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:00:46 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:39680)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oAzaH-006i2M-8Q; Mon, 11 Jul 2022 14:00:45 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:39664 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oAzaG-00Bnoh-D9; Mon, 11 Jul 2022 14:00:44 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>
Date:   Mon, 11 Jul 2022 15:00:36 -0500
Message-ID: <87ilo3ctcr.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oAzaG-00Bnoh-D9;;;mid=<87ilo3ctcr.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/oE0bTBNrqEvz5+U4UaTWaRUKCuRr2JNE=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [GIT PULL] ptrace: fix clearing of JOBCTL_TRACED in
 ptrace_unfreeze_traced()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the ptrace_unfreeze_fix-for-v5.19 tag from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ptrace_unfreeze_fix-for-v5.19
  HEAD: 3418357a32db6c8ce5e4417964bac1edcc3f281a ptrace: fix clearing of JOBCTL_TRACED in ptrace_unfreeze_traced()

This change fixes a small but very problematic typo.

Sven Schnelle (1):
      ptrace: fix clearing of JOBCTL_TRACED in ptrace_unfreeze_traced()

 kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
