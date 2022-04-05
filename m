Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C8EC4707E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 20:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387485AbiDEUFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 16:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353716AbiDEKJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:09:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90661C3369;
        Tue,  5 Apr 2022 02:55:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9C1F5CE1BE5;
        Tue,  5 Apr 2022 09:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E9BC385A2;
        Tue,  5 Apr 2022 09:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649152534;
        bh=KYthF1V1rwYdHB0aarjtYpgHgzauarKh6ljbQ558ZEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=le3YHudLKa4yle7OJ9FNKCpPycxURVv+dhlc8e1dqVQop7XWYC5EsGf0RUcnP7idX
         gPqJ+v1t09iVJUT/c08lSfZioG8Imq/tTk2Ub7N1maOtWPRvF95L/smV/fqwlzXw9Y
         X6FhOC2Zu2OubLSWZ7LTxHWx/yNMw4hu0Tyz5Hjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.15 811/913] KVM: x86: Avoid theoretical NULL pointer dereference in kvm_irq_delivery_to_apic_fast()
Date:   Tue,  5 Apr 2022 09:31:13 +0200
Message-Id: <20220405070404.141808412@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070339.801210740@linuxfoundation.org>
References: <20220405070339.801210740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

commit 00b5f37189d24ac3ed46cb7f11742094778c46ce upstream.

When kvm_irq_delivery_to_apic_fast() is called with APIC_DEST_SELF
shorthand, 'src' must not be NULL. Crash the VM with KVM_BUG_ON()
instead of crashing the host.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20220325132140.25650-3-vkuznets@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/lapic.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -987,6 +987,10 @@ bool kvm_irq_delivery_to_apic_fast(struc
 	*r = -1;
 
 	if (irq->shorthand == APIC_DEST_SELF) {
+		if (KVM_BUG_ON(!src, kvm)) {
+			*r = 0;
+			return true;
+		}
 		*r = kvm_apic_set_irq(src->vcpu, irq, dest_map);
 		return true;
 	}


