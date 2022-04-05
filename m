Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C66C43217
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 01:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbiDFBnJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 21:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357431AbiDEK0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:26:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5476249;
        Tue,  5 Apr 2022 03:10:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C0F9617A4;
        Tue,  5 Apr 2022 10:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FA8C385A0;
        Tue,  5 Apr 2022 10:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649153408;
        bh=7PbildU4fVy2AP3yvxFY7nRP8gtRqmn3F61F8jyqIRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYHqIhEXeNkeVNt1gNha4JRnQqVZgYuM+Un4cc72NqGkcEN6zQe40nYRKiwWxfP7O
         JlZhibqeS+p2J6GWtl8Hy00aTjyWPV63Kaqq8xTgzkpHs9pskG4VVEYP0gpL675eeW
         nTHX7ETLXJX69u5OyUlbcEKO75CtqNAT/2nMwG2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 213/599] ARM: ftrace: ensure that ADR takes the Thumb bit into account
Date:   Tue,  5 Apr 2022 09:28:27 +0200
Message-Id: <20220405070305.181038401@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit dd88b03ff0c84f4bcbe1419b93a4bed429fed3be ]

Using ADR to take the address of 'ftrace_stub' via a local label
produces an address that has the Thumb bit cleared, which means the
subsequent comparison is guaranteed to fail. Instead, use the badr
macro, which forces the Thumb bit to be set.

Fixes: a3ba87a61499 ("ARM: 6316/1: ftrace: add Thumb-2 support")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/entry-ftrace.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
index a74289ebc803..f4886fb6e9ba 100644
--- a/arch/arm/kernel/entry-ftrace.S
+++ b/arch/arm/kernel/entry-ftrace.S
@@ -40,7 +40,7 @@
 	mcount_enter
 	ldr	r0, =ftrace_trace_function
 	ldr	r2, [r0]
-	adr	r0, .Lftrace_stub
+	badr	r0, .Lftrace_stub
 	cmp	r0, r2
 	bne	1f
 
-- 
2.34.1



