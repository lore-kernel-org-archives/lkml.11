Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B80CCA480
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 10:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbiGNKUh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 06:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbiGNKUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:20:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E308F220D8;
        Thu, 14 Jul 2022 03:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YHBw+8zu7L1VeDczXhcKHNgOnr1WlOoBMX7AKcQhb00=; b=e7iLjzMf5LM2UBIP2uhkmb7omT
        nCbyv32m4dHzfUYGxH/XFkSGTM4EpurodQDw3VC2nJctQ1d6dc1PYKupyF8AfZDIchVKDoJ6XnIsT
        r9BYsGIMmrtDeRuyNqTMtzJFaBIbpJSiwfoG0kCgoian//PebA62/eIEfXXYCPkr1O9mEtdLY/+A0
        oWmFOkXcjgKg7V2kC9ZWA41y2srvSp/b/NWU90cZcFOGqcakW80w3l6bK42Ja7u/Et+DpWSIToXbl
        6E5HyAkrhlqnvQkJ7+u9XGm6faaBThHpbdrtTGpmZIXrEonXq1hNHMG5z7FRejuKmrFPL8CG5ve1E
        gs8TX+1w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBvxE-003oZv-Ma; Thu, 14 Jul 2022 10:20:20 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBB1E980135; Thu, 14 Jul 2022 12:20:19 +0200 (CEST)
Date:   Thu, 14 Jul 2022 12:20:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>, x86@kernel.org
Subject: [PATCH] um: Add missing apply_returns()
Message-ID: <Ys/t45l/garIrD0u@worktop.programming.kicks-ass.net>
References: <20220713223328.07016b70@canb.auug.org.au>
 <7b6077ec-4603-c177-b321-0eeaeefaec70@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b6077ec-4603-c177-b321-0eeaeefaec70@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 01:40:48PM -0700, Randy Dunlap wrote:
> 
> 
> On 7/13/22 05:33, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20220712:
> > 
> 
> UML for x86_64 defconfig:
> 
> /usr/lib64/gcc/x86_64-suse-linux/12/../../../../x86_64-suse-linux/bin/ld: arch/x86/um/../kernel/module.o: in function `module_finalize':
> module.c:(.text+0x416): undefined reference to `apply_returns'
> 
> arch/x86/kernel/alternative.o is not being built for UML.
> 

---
Subject: um: Add missing apply_returns()

Implement apply_returns() stub for UM, just like all the other patching
routines.

Fixes: 15e67227c49a ("x86: Undo return-thunk damage")
Reported-by: Randy Dunlap <rdunlap@infradead.org)
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/um/kernel/um_arch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 0760e24f2eba..9838967d0b2f 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -432,6 +432,10 @@ void apply_retpolines(s32 *start, s32 *end)
 {
 }
 
+void apply_returns(s32 *start, s32 *end)
+{
+}
+
 void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
 {
 }
