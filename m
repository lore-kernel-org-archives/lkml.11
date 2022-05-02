Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDB4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 11:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiEBLQ3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 07:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiEBLQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:16:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857755FFA
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 04:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9HmtpnMy2TgReU4YIb75qrQVXcE+pFVlRmoqNCAWKJk=; b=Pp9iFkHJznwCUWPc1IoxBkJ0sQ
        YgXkBDD+AlFX/WN9vrgRWofwabPVgdWtUBzvNmNcOxqiKhQZFTLciuX3THbHKmPn9/yeymD0uDlTK
        7MQorIHjc834/sj0eMV53L2Nu/OGu+kSaA157AwrSTLwmx06G7SemRB+rpvH2ChuLK3XOGAUU3jMp
        1In2sjbETeG4QzYR3/a9A4yAQwtSKi4bOMRnzksuZT4UM55bp644zo2ru8oX3UiE/PV38aAATFvl2
        tTh7WsGrtdeXgvwaStpe2yFBxltF/OjTXeH2xNcYk+65iwq8mxNUMIeSUttiCN/oneQp211jZkras
        q2TWjGmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlTyn-00ARA8-Ln; Mon, 02 May 2022 11:12:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A9423004B5;
        Mon,  2 May 2022 13:12:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E014420288D08; Mon,  2 May 2022 13:12:34 +0200 (CEST)
Message-ID: <20220502111216.290518605@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 02 May 2022 13:07:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        elver@google.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH 2/3] x86/cpu: Elide KCSAN for cpu_has() and friends
References: <20220502110741.951055904@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: enter_from_user_mode+0x24: call to __kcsan_check_access() leaves .noinstr.text section
vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x28: call to __kcsan_check_access() leaves .noinstr.text section
vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x24: call to __kcsan_check_access() leaves .noinstr.text section
vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x24: call to __kcsan_check_access() leaves .noinstr.text section

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/cpufeature.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -51,7 +51,7 @@ extern const char * const x86_power_flag
 extern const char * const x86_bug_flags[NBUGINTS*32];
 
 #define test_cpu_cap(c, bit)						\
-	 test_bit(bit, (unsigned long *)((c)->x86_capability))
+	 arch_test_bit(bit, (unsigned long *)((c)->x86_capability))
 
 /*
  * There are 32 bits/features in each mask word.  The high bits


