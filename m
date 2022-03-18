Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19CDC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 10:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiCRKtP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 06:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbiCRKsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:48:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDF22C578B;
        Fri, 18 Mar 2022 03:46:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 857121F390;
        Fri, 18 Mar 2022 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647600410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yiXOPvkp8VR9vIy/4EGvKMzLNQNlSpkWfG8vLlPrxcI=;
        b=NqHEpkmZiI4BlagA2vqZUR2q+FhmA3x5WzQBWJMWALNPtjW2CdLtVldVyXNy++5CFJqA0f
        1k8qzeGEu/jWrTixXBfKSsarPAvl8kX3dOnyMBi5ePyXFzspmN1xuhfQ3gKq7S7unqYsC2
        6jTUzkkCvUDE6NpbL4zeBvwnGxcyvcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647600410;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yiXOPvkp8VR9vIy/4EGvKMzLNQNlSpkWfG8vLlPrxcI=;
        b=SoMUvQXsytd/+YPxpqes/k46jUQIH/ujkxBjScmGBBefcSe8Z9rNiTj1b2WSgb4QhQgyOr
        eg67SgX9gI8hgrBg==
Received: from vasant-suse.suse.de (unknown [10.163.24.178])
        by relay2.suse.de (Postfix) with ESMTP id 46AB0A3B81;
        Fri, 18 Mar 2022 10:46:50 +0000 (UTC)
From:   Vasant Karasulli <vkarasulli@suse.de>
To:     linux-kernel@vger.kernel.org, jroedel@suse.de, kvm@vger.kernel.org
Cc:     bp@alien8.de, x86@kernel.org, thomas.lendacky@amd.com,
        varad.gautam@suse.com, Vasant Karasulli <vkarasulli@suse.de>
Subject: [PATCH v6 4/4] x86/tests: Add tests for AMD SEV-ES #VC handling
Date:   Fri, 18 Mar 2022 11:46:46 +0100
Message-Id: <20220318104646.8313-5-vkarasulli@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220318104646.8313-1-vkarasulli@suse.de>
References: <20220318104646.8313-1-vkarasulli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Add KUnit based tests to validate Linux's VC handling for
 IO instructions.
 These tests:
   1. install a kretprobe on the #VC handler (sev_es_ghcb_hv_call, to
      access GHCB before/after the resulting VMGEXIT).
   2. trigger an NAE by issuing an IO instruction.
   3. check that the kretprobe was hit with the right
      exit_code available in GHCB.

Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/tests/sev-test-vc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/tests/sev-test-vc.c b/arch/x86/tests/sev-test-vc.c
index b27b9f114a12..d0e742e2bf9f 100644
--- a/arch/x86/tests/sev-test-vc.c
+++ b/arch/x86/tests/sev-test-vc.c
@@ -8,7 +8,9 @@
 #include <asm/cpufeature.h>
 #include <asm/sev-common.h>
 #include <asm/debugreg.h>
+#include <asm/io.h>
 #include <asm/svm.h>
+#include <asm/apicdef.h>
 #include <kunit/test.h>
 #include <linux/kprobes.h>

@@ -111,11 +113,36 @@ static void sev_es_nae_dr7_rw(struct kunit *test)
 		   native_set_debugreg(7, native_get_debugreg(7)));
 }

+static void sev_es_nae_ioio(struct kunit *test)
+{
+	unsigned long port = 0x80;
+	char val = 0;
+
+	check_op(test, SVM_EXIT_IOIO, val = inb(port));
+	check_op(test, SVM_EXIT_IOIO, outb(val, port));
+	check_op(test, SVM_EXIT_IOIO, insb(port, &val, sizeof(val)));
+	check_op(test, SVM_EXIT_IOIO, outsb(port, &val, sizeof(val)));
+}
+
+static void sev_es_nae_mmio(struct kunit *test)
+{
+	unsigned long lapic_ver_pa = APIC_DEFAULT_PHYS_BASE + APIC_LVR;
+	unsigned long __iomem *lapic = ioremap(lapic_ver_pa, 0x4);
+	unsigned long lapic_version = 0;
+
+	check_op(test, SVM_VMGEXIT_MMIO_READ, lapic_version = *lapic);
+	check_op(test, SVM_VMGEXIT_MMIO_WRITE, *lapic = lapic_version);
+
+	iounmap(lapic);
+}
+
 static struct kunit_case sev_es_vc_testcases[] = {
 	KUNIT_CASE(sev_es_nae_cpuid),
 	KUNIT_CASE(sev_es_nae_wbinvd),
 	KUNIT_CASE(sev_es_nae_msr),
 	KUNIT_CASE(sev_es_nae_dr7_rw),
+	KUNIT_CASE(sev_es_nae_ioio),
+	KUNIT_CASE(sev_es_nae_mmio),
 	{}
 };

--
2.32.0

