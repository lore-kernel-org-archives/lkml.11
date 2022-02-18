Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A09C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 17:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiBRRRH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 12:17:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238234AbiBRRPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:19 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE814C790
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=xMeXZuqj3J/rnGb9Mi+ZUNOT0qDeb7uET8sUXZTdCeA=; b=Io6odpyloycouoXMm4D2YagDOh
        Bt/rdIK0O4AjJQGcj2ofnRJAuArkY+thyUciflmtqQR/3oFYZQBx7YULmneoIy7WFpg2cjIpzk/ZC
        Bik2OYN7T/eCr7UpG4V8EfjLF2j1J+qKuHuyKC12xMC7oUcgh4EjWU2ZYVluvaRMqEDAI2ZZSaB9M
        9c4l6FsoMvgk90k3K5vg5utIyWwwlyQiljSk/cLFcvsxJkAMwptcbJ/q5vCi6iRxIscooaFQ4oQFa
        yaSbK5zf5UbSOy0t+dqSdPMB0p8ZnkGjR9URKgeyUpzESwuSdZMSouLDmRobSQ36xo+zj/kKJChyA
        eMV9A1fg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6qA-00AsBa-GW; Fri, 18 Feb 2022 17:14:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C9354301218;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4805920A29562; Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Message-ID: <20220218171409.520731494@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: [PATCH 16/29] x86/bugs: Disable Retpoline when IBT
References: <20220218164902.008644515@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Retpoline and IBT are mutually exclusive. IBT relies on indirect
branches (JMP/CALL *%reg) while retpoline avoids them by design.

Demote to LFENCE on IBT enabled hardware.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/cpu/bugs.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -937,6 +937,11 @@ static void __init spectre_v2_select_mit
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 	retpoline_amd:
 		if (!boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
+			if (IS_ENABLED(CONFIG_X86_IBT) &&
+			    boot_cpu_has(X86_FEATURE_IBT)) {
+				pr_err("Spectre mitigation: LFENCE not serializing, generic retpoline not available due to IBT, switching to none\n");
+				return;
+			}
 			pr_err("Spectre mitigation: LFENCE not serializing, switching to generic retpoline\n");
 			goto retpoline_generic;
 		}
@@ -945,6 +950,26 @@ static void __init spectre_v2_select_mit
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
 	} else {
 	retpoline_generic:
+		/*
+		 *  Full retpoline is incompatible with IBT, demote to LFENCE.
+		 */
+		if (IS_ENABLED(CONFIG_X86_IBT) &&
+		    boot_cpu_has(X86_FEATURE_IBT)) {
+			switch (cmd) {
+			case SPECTRE_V2_CMD_FORCE:
+			case SPECTRE_V2_CMD_AUTO:
+			case SPECTRE_V2_CMD_RETPOLINE:
+				/* silent for auto select */
+				break;
+
+			default:
+				/* warn when 'demoting' an explicit selection */
+				pr_warn("Spectre mitigation: Switching to LFENCE due to IBT\n");
+				break;
+			}
+
+			goto retpoline_amd;
+		}
 		mode = SPECTRE_V2_RETPOLINE_GENERIC;
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
 	}


