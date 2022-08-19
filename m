Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE83C32772
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 10:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347931AbiHSKPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348314AbiHSKPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA573DAEE9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 03:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660904114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nE4XTLwKh6UtnjIJTfInkmm2bOQDhEPxLqhuAOXkzX8=;
        b=B3MO/6ZcJrPckONzRX+TgK2ynTZCTvq+dAQBrNZERBD6u3RBqIaizjLmitB/aCAvf8P81b
        7uCe9KXJfAZL35hZaxzZq0wjRQ0aDACVNSYHH36/GcdKVd1YYE7kzS1k4AOBWCAfqwHITf
        2lf2Iss7s8ypADb081CYi8EqgW57Omc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-yZQ2FZNnOQedMbMo9ugYoQ-1; Fri, 19 Aug 2022 06:15:12 -0400
X-MC-Unique: yZQ2FZNnOQedMbMo9ugYoQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7280885A588;
        Fri, 19 Aug 2022 10:15:12 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B385C15BC3;
        Fri, 19 Aug 2022 10:15:12 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH] KVM: MIPS: remove unnecessary definition of KVM_PRIVATE_MEM_SLOTS
Date:   Fri, 19 Aug 2022 06:15:12 -0400
Message-Id: <20220819101512.2346335-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM_PRIVATE_MEM_SLOTS defaults to zero, so it is not necessary to
define it in MIPS's asm/kvm_host.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/mips/include/asm/kvm_host.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 717716cc51c5..5cedb28e8a40 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -84,8 +84,6 @@
 
 
 #define KVM_MAX_VCPUS		16
-/* memory slots that does not exposed to userspace */
-#define KVM_PRIVATE_MEM_SLOTS	0
 
 #define KVM_HALT_POLL_NS_DEFAULT 500000
 
-- 
2.31.1

