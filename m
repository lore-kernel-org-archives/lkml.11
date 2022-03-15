Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09574C4167B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 10:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347719AbiCOKsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 06:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347432AbiCOKqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:46:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032A7517C3;
        Tue, 15 Mar 2022 03:44:17 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:44:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yawVxFAHvFcZDiFMXQf1jYbE4t+YnrFXLgb/ZZrIDeM=;
        b=fepdr7ymDjV33KqkTiVbdQHauuHFn6vdVLrH52SwEk2a9BlPozJC9NHHBoPbwlTybDYcbG
        bA/r6rs7SVbeGXzWcf7rwSe7+eNwktqHjoFY4axPfSusMazejR/GGdY9s3HSbVVp6xv42+
        XvWhbpxCth1whpLGNTAo3DKhKh46nimgRGuMZ4EpIyXFnf7spICU2gvpMYw5G8xqpPx00y
        Ae6lMUynDhNpL5CxnFj2sxNAsxyLZA4IMIdpBv70kaImnDq9gjHpCIvXvZzm+qhPcgRsJL
        jD/MRz+eIJxFTiivp/pBbIg+Oi3PSZ6jh3fDQHpUpJ8hU4EFtp92kVUM2szw1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yawVxFAHvFcZDiFMXQf1jYbE4t+YnrFXLgb/ZZrIDeM=;
        b=L+LCSiEPQv+z9RGrQNyTIj3WrUYEyFvNld1ePqqF4hSv9Vc2V+IrUwUe6y0dIdpbB48qdO
        03QuMM4BHGfciQDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Default ignore INT3 for unreachable
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154317.343312938@infradead.org>
References: <20220308154317.343312938@infradead.org>
MIME-Version: 1.0
Message-ID: <164734105559.16921.14088040852622934512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     1ffbe4e935f9b7308615c75be990aec07464d1e7
Gitweb:        https://git.kernel.org/tip/1ffbe4e935f9b7308615c75be990aec07464d1e7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:14 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:32 +01:00

objtool: Default ignore INT3 for unreachable

Ignore all INT3 instructions for unreachable code warnings, similar to NOP.
This allows using INT3 for various paddings instead of NOPs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154317.343312938@infradead.org
---
 tools/objtool/check.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7c33ec6..311bfc6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3115,9 +3115,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		switch (insn->type) {
 
 		case INSN_RETURN:
-			if (next_insn && next_insn->type == INSN_TRAP) {
-				next_insn->ignore = true;
-			} else if (sls && !insn->retpoline_safe) {
+			if (sls && !insn->retpoline_safe &&
+			    next_insn && next_insn->type != INSN_TRAP) {
 				WARN_FUNC("missing int3 after ret",
 					  insn->sec, insn->offset);
 			}
@@ -3164,9 +3163,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_JUMP_DYNAMIC:
-			if (next_insn && next_insn->type == INSN_TRAP) {
-				next_insn->ignore = true;
-			} else if (sls && !insn->retpoline_safe) {
+			if (sls && !insn->retpoline_safe &&
+			    next_insn && next_insn->type != INSN_TRAP) {
 				WARN_FUNC("missing int3 after indirect jump",
 					  insn->sec, insn->offset);
 			}
@@ -3337,7 +3335,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	int i;
 	struct instruction *prev_insn;
 
-	if (insn->ignore || insn->type == INSN_NOP)
+	if (insn->ignore || insn->type == INSN_NOP || insn->type == INSN_TRAP)
 		return true;
 
 	/*
