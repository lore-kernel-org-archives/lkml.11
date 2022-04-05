Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8AAC433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 11:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbiDELGx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238835AbiDEIa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:30:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D96B4552C;
        Tue,  5 Apr 2022 01:22:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04B8D614D7;
        Tue,  5 Apr 2022 08:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F21CC385A1;
        Tue,  5 Apr 2022 08:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649146977;
        bh=lDJ14n+h0TDjSebOjNA/MtyyT1OVEDsvAT9/xrtn/jI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e+h2fivrvwmamAhGjlT5+3X2HiqMGN/HNuBYLsroYStn+JYTTA/QWUFW1yM/Ra7ya
         jI1fLcJ+wGzKgj5yhR9bVZHy/mocIgRIq9d48QoHcC7ztg+fmKXYkERWph2Xlo+XGg
         JHxc1GJ0ATBcpLHsyTr7h8gbBEJmiXC5srpKPO7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.17 0956/1126] KVM: x86: hyper-v: Drop redundant ex parameter from kvm_hv_send_ipi()
Date:   Tue,  5 Apr 2022 09:28:23 +0200
Message-Id: <20220405070435.564359777@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

commit 50e523dd79f6a856d793ce5711719abe27cffbf2 upstream.

'struct kvm_hv_hcall' has all the required information already,
there's no need to pass 'ex' additionally.

No functional change intended.

Cc: stable@vger.kernel.org # 5.14.x
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20220222154642.684285-2-vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/hyperv.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1875,7 +1875,7 @@ static void kvm_send_ipi_to_many(struct
 	}
 }
 
-static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool ex)
+static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 {
 	struct kvm *kvm = vcpu->kvm;
 	struct hv_send_ipi_ex send_ipi_ex;
@@ -1889,7 +1889,7 @@ static u64 kvm_hv_send_ipi(struct kvm_vc
 	u32 vector;
 	bool all_cpus;
 
-	if (!ex) {
+	if (hc->code == HVCALL_SEND_IPI) {
 		if (!hc->fast) {
 			if (unlikely(kvm_read_guest(kvm, hc->ingpa, &send_ipi,
 						    sizeof(send_ipi))))
@@ -2279,14 +2279,14 @@ int kvm_hv_hypercall(struct kvm_vcpu *vc
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
-		ret = kvm_hv_send_ipi(vcpu, &hc, false);
+		ret = kvm_hv_send_ipi(vcpu, &hc);
 		break;
 	case HVCALL_SEND_IPI_EX:
 		if (unlikely(hc.fast || hc.rep)) {
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
-		ret = kvm_hv_send_ipi(vcpu, &hc, true);
+		ret = kvm_hv_send_ipi(vcpu, &hc);
 		break;
 	case HVCALL_POST_DEBUG_DATA:
 	case HVCALL_RETRIEVE_DEBUG_DATA:


