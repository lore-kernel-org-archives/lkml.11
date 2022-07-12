Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665CBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 18:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbiGLSwp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 14:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbiGLSwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:52:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58A6DA0DF;
        Tue, 12 Jul 2022 11:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21DB0B81BAC;
        Tue, 12 Jul 2022 18:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8B6C3411C;
        Tue, 12 Jul 2022 18:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657651485;
        bh=I1nVtJhBaBbQvFmmxP+Ixri0tvBlRaN4Uz+xRtIocyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KB/IPB6LZkL8DOFAsf+fuHx2nU4nM74brFbpvM3IWCtkcDdnzZZV0sEsrigdkFyLR
         r9SIjKOTs4TBUmU9Z8FgSG6VByuAQgqkMww/nk4qYhbVHV3pYN3+g4alvKn+9VayFT
         y0Wq4LIkP5LdbcaqEK1vUm4dyH92Oy1tg+eTiRqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 5.10 091/130] x86/vsyscall_emu/64: Dont use RET in vsyscall emulation
Date:   Tue, 12 Jul 2022 20:38:57 +0200
Message-Id: <20220712183250.656782090@linuxfoundation.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220712183246.394947160@linuxfoundation.org>
References: <20220712183246.394947160@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit 15583e514eb16744b80be85dea0774ece153177d upstream.

This is userspace code and doesn't play by the normal kernel rules.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/entry/vsyscall/vsyscall_emu_64.S |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/x86/entry/vsyscall/vsyscall_emu_64.S
+++ b/arch/x86/entry/vsyscall/vsyscall_emu_64.S
@@ -19,17 +19,20 @@ __vsyscall_page:
 
 	mov $__NR_gettimeofday, %rax
 	syscall
-	RET
+	ret
+	int3
 
 	.balign 1024, 0xcc
 	mov $__NR_time, %rax
 	syscall
-	RET
+	ret
+	int3
 
 	.balign 1024, 0xcc
 	mov $__NR_getcpu, %rax
 	syscall
-	RET
+	ret
+	int3
 
 	.balign 4096, 0xcc
 


