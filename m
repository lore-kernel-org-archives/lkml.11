Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540C1C433FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 15:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345466AbiDGQAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 12:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345318AbiDGP7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:59:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26B96D5557
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649347054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8SPoAicWERrx3mqG+g3WmO5taECtYPYr+UXD+7FONE=;
        b=eukSSAya3BSRmYxKIjiOF6KH/V4VSYUfgD1zn8xpQmWtcz5R6GvW7sFLSwl7WwkGQ870bA
        822GGAdRb8SiYEs5cx31u/cETx1Y9q+ss+kK4+vHWivC+U3EOCGczi9NBsxzP5+bVYEovx
        FEVaqkNx/u4353Sf7xa0OFyyIFYN1a4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-ahDIiYXJPTKQPpwBPSLkvw-1; Thu, 07 Apr 2022 11:57:31 -0400
X-MC-Unique: ahDIiYXJPTKQPpwBPSLkvw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A333811E90;
        Thu,  7 Apr 2022 15:57:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE8D454AC84;
        Thu,  7 Apr 2022 15:57:28 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/31] KVM: x86: Expose Hyper-V Direct TLB flush feature
Date:   Thu,  7 Apr 2022 17:56:33 +0200
Message-Id: <20220407155645.940890-20-vkuznets@redhat.com>
In-Reply-To: <20220407155645.940890-1-vkuznets@redhat.com>
References: <20220407155645.940890-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With both nSVM and nVMX implementations in place, KVM can export
Hyper-V Direct TLB flush feature to userspace.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index f08cf295d750..7758ed3dc811 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2801,6 +2801,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 
 		case HYPERV_CPUID_NESTED_FEATURES:
 			ent->eax = evmcs_ver;
+			ent->eax |= HV_X64_NESTED_DIRECT_FLUSH;
 			ent->eax |= HV_X64_NESTED_MSR_BITMAP;
 
 			break;
-- 
2.35.1

