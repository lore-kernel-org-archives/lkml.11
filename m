Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE94CCA47F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 18:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiGLSr0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 14:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbiGLSq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:46:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE512DD214;
        Tue, 12 Jul 2022 11:43:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57CDAB81BBC;
        Tue, 12 Jul 2022 18:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A721EC3411C;
        Tue, 12 Jul 2022 18:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657651376;
        bh=Z9v+W6Ypo/TtsuKDyVQ7GeOlltbq63xMAp1hYKg1CZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RTGtjR59M0s9jmnQgeoTQUBW0ZwGrTqGh05u9XvhDl9gmWBJM5eVG5X9xAEK0csNS
         vWeluzxw0VqW+Lo0pR56Je+d9zqS85hH4TlH+oTyKu2CEl8YfpaLRescxhlKZ8d8KA
         o45BfGdr8KTfY+HOgglZcml8jaoIkLWegB3p8OZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 5.10 058/130] x86/alternative: Add debug prints to apply_retpolines()
Date:   Tue, 12 Jul 2022 20:38:24 +0200
Message-Id: <20220712183249.131952817@linuxfoundation.org>
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

commit d4b5a5c993009ffeb5febe3b701da3faab6adb96 upstream.

Make sure we can see the text changes when booting with
'debug-alternative'.

Example output:

 [ ] SMP alternatives: retpoline at: __traceiter_initcall_level+0x1f/0x30 (ffffffff8100066f) len: 5 to: __x86_indirect_thunk_rax+0x0/0x20
 [ ] SMP alternatives: ffffffff82603e58: [2:5) optimized NOPs: ff d0 0f 1f 00
 [ ] SMP alternatives: ffffffff8100066f: orig: e8 cc 30 00 01
 [ ] SMP alternatives: ffffffff8100066f: repl: ff d0 0f 1f 00

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/r/20211026120310.422273830@infradead.org
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/alternative.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -647,9 +647,15 @@ void __init_or_module noinline apply_ret
 			continue;
 		}
 
+		DPRINTK("retpoline at: %pS (%px) len: %d to: %pS",
+			addr, addr, insn.length,
+			addr + insn.length + insn.immediate.value);
+
 		len = patch_retpoline(addr, &insn, bytes);
 		if (len == insn.length) {
 			optimize_nops(bytes, len);
+			DUMP_BYTES(((u8*)addr),  len, "%px: orig: ", addr);
+			DUMP_BYTES(((u8*)bytes), len, "%px: repl: ", addr);
 			text_poke_early(addr, bytes, len);
 		}
 	}


