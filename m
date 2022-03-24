Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A965EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 13:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350579AbiCXNsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 09:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350565AbiCXNsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:48:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A528A332
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:47:10 -0700 (PDT)
Message-ID: <20220324134623.408932232@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648129628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=k7ZwKCPvoxI5xqioe9wDMoAwUBZDO2Yad89sOWDbHAQ=;
        b=h38pHEDTkRb7pTSbSvahMDQW2Hpc2pG2Q27FZF6AExDGIjfH7Dt+17wvVHrNpCf20fK9sN
        dsMIQ5o3IPSzDR7k4s7wJcwc8Z4dkxAj6ivJCutMKJzl4zCmisG21mk0GB0kb0iT35VA0Q
        Dp3GMo+ZplFg0AEuyDns2JQ4CegwQDF7qE7IpuzJI3abYiU0RtGGb2spLfXRItuynz/YA+
        zIRFBXbzfzVz7J4WuLb0q4WHivDspydqoXuSWYDEl6lnCIYAv4J4iYN8zCGF8qn7rSCG0X
        v0KO9vY2ouWqvu6nrVy6ZkLJ8IKyzeYIyC8D9OZTpEbYqoBIbJiC90t3NhOvyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648129628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=k7ZwKCPvoxI5xqioe9wDMoAwUBZDO2Yad89sOWDbHAQ=;
        b=g8OeO4Li57ezADORSDUAqGr9xaiPxB/7rIm12yvP/JK1c+Rk7rk7H122jiB75avmp3IQz5
        Wjc7qXHWsbp06AAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Chang S. Bae" <chang.seok.bae@intel.com>,
        Paolo Bonzini <bonzini@gnu.org>
Subject: [patch 1/7] x86/fpu: Remove redundant XCOMP_BV initialization
References: <20220324134548.432837672@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 24 Mar 2022 14:47:08 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fpu_copy_uabi_to_guest_fpstate() initializes the XCOMP_BV field in the
XSAVE header. That's a leftover from the old KVM FPU buffer handling code.

Since d69c1382e1b7 ("x86/kvm: Convert FPU handling to a single swap
buffer") KVM uses the FPU core allocation code, which initializes the
XCOMP_BV field already.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <bonzini@gnu.org>
---
 arch/x86/kernel/fpu/core.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -415,9 +415,6 @@ int fpu_copy_uabi_to_guest_fpstate(struc
 		xpkru = get_xsave_addr(&kstate->regs.xsave, XFEATURE_PKRU);
 		*vpkru = xpkru->pkru;
 	}
-
-	/* Ensure that XCOMP_BV is set up for XSAVES */
-	xstate_init_xcomp_bv(&kstate->regs.xsave, kstate->xfeatures);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fpu_copy_uabi_to_guest_fpstate);

