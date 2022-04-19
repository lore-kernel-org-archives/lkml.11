Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB76DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 20:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244111AbiDSULz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 16:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357134AbiDSUL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:11:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B1B3BFA5;
        Tue, 19 Apr 2022 13:08:42 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:08:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650398920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Ct27rlk9vRQy/2CJxZFmvJDBBEkkwk8EXsnivkaF7U=;
        b=ZyWH4oaFsqZT/08ouWGKkMVAvlAX7Tbt6ri3YB4MYm3uSvXqc8Odp0XCBOTTftQY3wLUm5
        Qc27uYT5JXsNwPMI9re35lP1dj9cH6iP7BPAaNeyOs9rZ7o2mYRci8ZPxsBf8S2JvKLcs+
        uMCd/J68v3zkAuvtXSRgG7YNrEh6V1UfuG9jtyezZ/SKz5eRhvYvDcUyjkxNgYMuSrmsC7
        v2vTk5eL+6p6VZoBBPopKrlsKu4s4k/gxTyVBjJ13sxKa7wTkjXCAA80kyCHBKzHTKz74v
        TpDEzLJljkpcz+5ApZGdZol7UcHkeS2y5f6BlbK4zE7SBGhDJca+6IKoqUKqrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650398920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Ct27rlk9vRQy/2CJxZFmvJDBBEkkwk8EXsnivkaF7U=;
        b=A9hOkBsJ7PNFQapQdcsKiesNOwheJEr0fC4on/ojVbybv0aooUBslWhM6TnMTzH5MpjKWc
        BShYT+ME+LDffsDw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/static_call: Add ANNOTATE_NOENDBR to static
 call trampoline
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1b5b54aad7d81241dabe5e0c9b40dea64b540b00.1650300597.git.jpoimboe@redhat.com>
References: <1b5b54aad7d81241dabe5e0c9b40dea64b540b00.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165039891962.4207.8534671021109525259.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     613871cd665ab26290c5ff531dd06c3789d31319
Gitweb:        https://git.kernel.org/tip/613871cd665ab26290c5ff531dd06c3789d31319
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:22 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:58:48 +02:00

x86/static_call: Add ANNOTATE_NOENDBR to static call trampoline

The static call trampoline is never indirect-branched to, but is
referenced by the static call key.  Add ANNOTATE_NOENDBR.

Fixes: ed53a0d97192 ("x86/alternative: Use .ibt_endbr_seal to seal indirect calls")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1b5b54aad7d81241dabe5e0c9b40dea64b540b00.1650300597.git.jpoimboe@redhat.com
---
 arch/x86/include/asm/static_call.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index 2455d72..2d8dacd 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -26,6 +26,7 @@
 	    ".align 4						\n"	\
 	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
 	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
+	    ANNOTATE_NOENDBR						\
 	    insns "						\n"	\
 	    ".byte 0x53, 0x43, 0x54				\n"	\
 	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
