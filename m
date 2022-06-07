Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B971ACCA499
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 00:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389339AbiFHAfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574455AbiFGXZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:25:45 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EBD22DFB5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:36:22 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id h190-20020a636cc7000000b003fd5d5452cfso4768609pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Y68XIZUJ1GQ/ObMpbiUUdrzn6qb8lkahi8a44hfFrNA=;
        b=jQ95zgp7qVJDyz/rhBbnbzbFaPXyqDEzj8zrULA0JTAxn1ujGCUU4KkH2I2nb7lyN1
         BgyIKJWUQMaXAbdAtXG12SiP3C1YPVlMBEjCPZZjMLxyqrLf05ilwaPOGFqn5UDHWtN2
         VOGq4vG+livVzLe0sI1eqlvSg/ho1RMSvot8fBuX/peS59R2BwmmovC4CMmGmAkvKeOq
         Nif/YKDQfkwW8ztwDY1E4vNh2+DeObMVSnh3J+n3VpTrqqW/kbUe9OUBIEd2YYAnQRLx
         GVlH6v0JEVKur9tlG4S+AuaTKJXe5K+9BUqQkLjD1C28qEfDCivr45t0uzgm5G2Hw+Sj
         ZS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Y68XIZUJ1GQ/ObMpbiUUdrzn6qb8lkahi8a44hfFrNA=;
        b=FKbnGDRa3l6RBAo9tEmHke0y7+GT/corjKjbNIm8rZL8zrzs4L8KDvmBU71CxX36l3
         qtC5ScakjagbySdxHt0K4Wg9r2N4cx1CZ83pfp782O+NRdeoIQFiY2imARZPepvfcEjJ
         hSDnTX2i12tgHor8IlfenSBED7brClok0SaiywMcp6+bfZZcg9NAH8vz78x32DyrE5Kq
         gMAPQao8upozjo6VKlgCgKWyJbM9uBMEEStlzRO/pc5f2Axg+J5E3TXZlGj+bih0q7zi
         cSNUCSP0aMvgUC0pKfJyU38Lt+TvhuPvDEmr7MyWiu6NQ3b96LMM9Wv8YbO5nmgMJVAY
         enqw==
X-Gm-Message-State: AOAM531OTpFjTtjC9qlvij7yBkkB5kfkqu1x80Rys+rmIuAp4/9SpO4V
        qHKwnOo9vhuYelbr7/vo6vGyrcKgJgU=
X-Google-Smtp-Source: ABdhPJxB3VYaQ3PQ1Ta72PzTm03vXyJkriBqEkaiWnpRhP0oEWKbD0KEj038iaragoTuunxOvzLdz2r/Ra8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c981:b0:1e6:75f0:d4ea with SMTP id
 w1-20020a17090ac98100b001e675f0d4eamr35605587pjt.37.1654637781774; Tue, 07
 Jun 2022 14:36:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Jun 2022 21:35:51 +0000
In-Reply-To: <20220607213604.3346000-1-seanjc@google.com>
Message-Id: <20220607213604.3346000-3-seanjc@google.com>
Mime-Version: 1.0
References: <20220607213604.3346000-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v5 02/15] KVM: nVMX: Account for KVM reserved CR4 bits in
 consistency checks
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Li <ercli@ucdavis.edu>,
        David Matlack <dmatlack@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that the guest (L2) and host (L1) CR4 values that would be loaded
by nested VM-Enter and VM-Exit respectively are valid with respect to
KVM's (L0 host) allowed CR4 bits.  Failure to check KVM reserved bits
would allow L1 to load an illegal CR4 (or trigger hardware VM-Fail or
failed VM-Entry) by massaging guest CPUID to allow features that are not
supported by KVM.  Amusingly, KVM itself is an accomplice in its doom, as
KVM adjusts L1's MSR_IA32_VMX_CR4_FIXED1 to allow L1 to enable bits for
L2 based on L1's CPUID model.

Note, although nested_{guest,host}_cr4_valid() are _currently_ used if
and only if the vCPU is post-VMXON (nested.vmxon == true), that may not
be true in the future, e.g. emulating VMXON has a bug where it doesn't
check the allowed/required CR0/CR4 bits.

Cc: stable@vger.kernel.org
Fixes: 3899152ccbf4 ("KVM: nVMX: fix checks on CR{0,4} during virtual VMX operation")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index c92cea0b8ccc..129ae4e01f7c 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -281,7 +281,8 @@ static inline bool nested_cr4_valid(struct kvm_vcpu *vcpu, unsigned long val)
 	u64 fixed0 = to_vmx(vcpu)->nested.msrs.cr4_fixed0;
 	u64 fixed1 = to_vmx(vcpu)->nested.msrs.cr4_fixed1;
 
-	return fixed_bits_valid(val, fixed0, fixed1);
+	return fixed_bits_valid(val, fixed0, fixed1) &&
+	       __kvm_is_valid_cr4(vcpu, val);
 }
 
 /* No difference in the restrictions on guest and host CR4 in VMX operation. */
-- 
2.36.1.255.ge46751e96f-goog

