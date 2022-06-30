Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE01C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 14:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbiF3OCI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiF3N7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:59:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F88960538;
        Thu, 30 Jun 2022 06:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96185B82AEE;
        Thu, 30 Jun 2022 13:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024B5C34115;
        Thu, 30 Jun 2022 13:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656597144;
        bh=go2lGiJZxAsITFkOSCBapOO6AC5ZFnehK7/GBdedBLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oS2bX3IRiOUnIsLntVfymZ2Ciq+CAaOX/YdXepHr5Yz5vQjSw4Fa26JAqyi8EXAsc
         57nhZ8g62OEc3un+irocuXXxIt61k42QziWQTRzBdn9S8w/ZEai/p64Er2jZw50+Hl
         qqPRxOqMdlptvcIEATM3yTfV0yo28NSvaLm486ac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 42/49] powerpc/pseries: wire up rng during setup_arch()
Date:   Thu, 30 Jun 2022 15:46:55 +0200
Message-Id: <20220630133235.116020431@linuxfoundation.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220630133233.910803744@linuxfoundation.org>
References: <20220630133233.910803744@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit e561e472a3d441753bd012333b057f48fef1045b upstream.

The platform's RNG must be available before random_init() in order to be
useful for initial seeding, which in turn means that it needs to be
called from setup_arch(), rather than from an init call. Fortunately,
each platform already has a setup_arch function pointer, which means
it's easy to wire this up. This commit also removes some noisy log
messages that don't add much.

Fixes: a489043f4626 ("powerpc/pseries: Implement arch_get_random_long() based on H_RANDOM")
Cc: stable@vger.kernel.org # v3.13+
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20220611151015.548325-4-Jason@zx2c4.com
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/pseries.h |    2 ++
 arch/powerpc/platforms/pseries/rng.c     |   11 +++--------
 arch/powerpc/platforms/pseries/setup.c   |    1 +
 3 files changed, 6 insertions(+), 8 deletions(-)

--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -110,4 +110,6 @@ int dlpar_workqueue_init(void);
 
 void pseries_setup_rfi_flush(void);
 
+void pseries_rng_init(void);
+
 #endif /* _PSERIES_PSERIES_H */
--- a/arch/powerpc/platforms/pseries/rng.c
+++ b/arch/powerpc/platforms/pseries/rng.c
@@ -14,6 +14,7 @@
 #include <asm/archrandom.h>
 #include <asm/machdep.h>
 #include <asm/plpar_wrappers.h>
+#include "pseries.h"
 
 
 static int pseries_get_random_long(unsigned long *v)
@@ -28,19 +29,13 @@ static int pseries_get_random_long(unsig
 	return 0;
 }
 
-static __init int rng_init(void)
+void __init pseries_rng_init(void)
 {
 	struct device_node *dn;
 
 	dn = of_find_compatible_node(NULL, NULL, "ibm,random");
 	if (!dn)
-		return -ENODEV;
-
-	pr_info("Registering arch random hook.\n");
-
+		return;
 	ppc_md.get_random_seed = pseries_get_random_long;
-
 	of_node_put(dn);
-	return 0;
 }
-machine_subsys_initcall(pseries, rng_init);
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -792,6 +792,7 @@ static void __init pSeries_setup_arch(vo
 	}
 
 	ppc_md.pcibios_root_bridge_prepare = pseries_root_bridge_prepare;
+	pseries_rng_init();
 }
 
 static void pseries_panic(char *str)


