Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB56C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 17:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbiGSRrV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 13:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbiGSRrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A22134E622
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658252838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2wNGFm0yfVwaROjLRxviFlh6IlnnzEMvVLBYTqt6gIY=;
        b=S/glE3iq/BCjtkFUCOIqqIsGs7r6TAMGthRcT/8tK7qHnfFjQpQxk4Zo2wr4VPW6QtSzuM
        EbB95Fia+jKyXxIOiiqdXFGJ9srTROcmfq0pS8M452VgW2TcFZeQpbdm0X4M7qHtDOVq+s
        GPfKtXDON7+d81XVmyD9DAhKUCwHeCk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-W8Oxq7_0OmebqPZGq0GB0Q-1; Tue, 19 Jul 2022 13:47:15 -0400
X-MC-Unique: W8Oxq7_0OmebqPZGq0GB0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3B573C11E6D;
        Tue, 19 Jul 2022 17:47:14 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55D882166B26;
        Tue, 19 Jul 2022 17:47:14 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Subject: [PATCH] x86, cpu: use MSR_IA32_MISC_ENABLE constants
Date:   Tue, 19 Jul 2022 13:47:14 -0400
Message-Id: <20220719174714.2410374-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of the magic numbers 1<<11 and 1<<12 use the constants
from msr-index.h.  This makes it obvious where those bits
of MSR_IA32_MISC_ENABLE are consumed (and in fact that Linux
consumes them at all) to simple minds that grep for
MSR_IA32_MISC_ENABLE_.*_UNAVAIL.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kernel/cpu/intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fd5dead8371c..663f6e6dd288 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -682,9 +682,9 @@ static void init_intel(struct cpuinfo_x86 *c)
 		unsigned int l1, l2;
 
 		rdmsr(MSR_IA32_MISC_ENABLE, l1, l2);
-		if (!(l1 & (1<<11)))
+		if (!(l1 & MSR_IA32_MISC_ENABLE_BTS_UNAVAIL))
 			set_cpu_cap(c, X86_FEATURE_BTS);
-		if (!(l1 & (1<<12)))
+		if (!(l1 & MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL))
 			set_cpu_cap(c, X86_FEATURE_PEBS);
 	}
 
-- 
2.31.1

