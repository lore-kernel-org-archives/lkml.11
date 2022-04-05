Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E88CC43219
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 13:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390812AbiDENnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 09:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345932AbiDEJXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:23:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F85A774B;
        Tue,  5 Apr 2022 02:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F59961654;
        Tue,  5 Apr 2022 09:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0577C385A2;
        Tue,  5 Apr 2022 09:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649149954;
        bh=cznyEpNzsTlaaxDVh7pqUaJlIdL/rp+lo6bpM9NMiN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SeWwAxSbXQZqqJUl/W2nfjohwoCi/rLH8jEkYBoBpsbSQgSylfFoWPldUOHD4Ve6q
         uzZ/sFh2UVLt5Yn7G+gsYpxPUZDKhzJX1h2Cc4Utby5RGCnoFiZ7LTCGx1RWu+4B5B
         rCnJAC/De1UrqvuNjWgC5rKlSleTAlgKrHAfvDx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.16 0901/1017] KVM: x86: Check lapic_in_kernel() before attempting to set a SynIC irq
Date:   Tue,  5 Apr 2022 09:30:14 +0200
Message-Id: <20220405070420.971150721@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

commit 7ec37d1cbe17d8189d9562178d8b29167fe1c31a upstream.

When KVM_CAP_HYPERV_SYNIC{,2} is activated, KVM already checks for
irqchip_in_kernel() so normally SynIC irqs should never be set. It is,
however,  possible for a misbehaving VMM to write to SYNIC/STIMER MSRs
causing erroneous behavior.

The immediate issue being fixed is that kvm_irq_delivery_to_apic()
(kvm_irq_delivery_to_apic_fast()) crashes when called with
'irq.shorthand = APIC_DEST_SELF' and 'src == NULL'.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20220325132140.25650-2-vkuznets@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/hyperv.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -446,6 +446,9 @@ static int synic_set_irq(struct kvm_vcpu
 	struct kvm_lapic_irq irq;
 	int ret, vector;
 
+	if (KVM_BUG_ON(!lapic_in_kernel(vcpu), vcpu->kvm))
+		return -EINVAL;
+
 	if (sint >= ARRAY_SIZE(synic->sint))
 		return -EINVAL;
 


