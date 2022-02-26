Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E1AC433FE
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Feb 2022 00:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbiBZAQy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 19:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbiBZAQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 19:16:38 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A410214F86
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:16:05 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d17-20020a253611000000b006244e94b7b4so4990998yba.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=W0dsOEq/PIsQRXnhmEzN4z4vDCVezWtZyWCTAFD0mm4=;
        b=kkTCjC4tVIj7enFaFMKIYHTANMNAYxjkHrt4FVwFXDe4UpZ9MJGM/QS0YDczVjf7zS
         xyCmw6fI2EpbOhAcLNPaVAm6RBmzabO5vXpzITVrlUpoTf1wQw4PbIxstYS2SyGOBdd8
         ObaNGe64fwLi3o87QsWZ21hi0Zu0f1Knbx5jNrinn0D46zmVKOUU2/5VpUlnm2EybEEa
         fZ/TaCH4VDiAo0gmuhj9G1xesKLSJ2KCRPDK6t1kNJrbMcld3k6Y6hjYi12nyVC7Hbt6
         jMvWvSfnhrHp49CLfuCKLksw6MoPezPBJHQQQyC97WTVDmrWDX/xDhXIWsCx7+7fauCA
         Ebdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=W0dsOEq/PIsQRXnhmEzN4z4vDCVezWtZyWCTAFD0mm4=;
        b=T0BexUPmxmKAFIOjT5SW0tU/Oy+7uYeQ8z1At29t5rfa9B3RguLbgfzMuh5hjMk3J5
         1QyVgikWDpKg1YiTv2xvsQJXgwYsc3+35Pofu5IoqhkM6fsZ320i9BynmhZYEhMuEZGg
         OvzEpvg7JAFwN5NSfXeyiKwB+9QIdKReiHmHsBdiaaAcblntsGUKL6MTn9Wz8jKQRETW
         e4b0cKm1+FodULVz0fOWUjmF45dxgD1j5zFBcRKNZDQzvnZm9wCPWSVjFN3M3COMgDNy
         /oVIQ7qadwrjelVmpBmoee5Vjc5uBNtZZ3YiuO76lHSF+VQbwdcpVqkkV/LbO+xlgjNV
         XLeA==
X-Gm-Message-State: AOAM533ZcHPakFwI93/ZvbmNi5fxoc4yS23c6Xfdqz43NeW4vIizONh0
        EVoASu/ilCxW+rWNq/yzMnAV0kcBda8=
X-Google-Smtp-Source: ABdhPJwyWL5owexPrfMNeXvwM0V0pC6xHluXdGFWOU2XldPBciQnXTg/AL4B9+xNVnXtV72T/fRBvSj0OJg=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3a1:b0:2d6:9324:cb4f with SMTP id
 bh33-20020a05690c03a100b002d69324cb4fmr10270352ywb.399.1645834564647; Fri, 25
 Feb 2022 16:16:04 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 26 Feb 2022 00:15:20 +0000
In-Reply-To: <20220226001546.360188-1-seanjc@google.com>
Message-Id: <20220226001546.360188-3-seanjc@google.com>
Mime-Version: 1.0
References: <20220226001546.360188-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 02/28] KVM: x86/mmu: Check for present SPTE when clearing
 dirty bit in TDP MMU
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly check for present SPTEs when clearing dirty bits in the TDP
MMU.  This isn't strictly required for correctness, as setting the dirty
bit in a defunct SPTE will not change the SPTE from !PRESENT to PRESENT.
However, the guarded MMU_WARN_ON() in spte_ad_need_write_protect() would
complain if anyone actually turned on KVM's MMU debugging.

Fixes: a6a0b05da9f3 ("kvm: x86/mmu: Support dirty logging for the TDP MMU")
Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 25148e8b711d..9357780ec28f 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1446,6 +1446,9 @@ static bool clear_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 		if (tdp_mmu_iter_cond_resched(kvm, &iter, false, true))
 			continue;
 
+		if (!is_shadow_present_pte(iter.old_spte))
+			continue;
+
 		if (spte_ad_need_write_protect(iter.old_spte)) {
 			if (is_writable_pte(iter.old_spte))
 				new_spte = iter.old_spte & ~PT_WRITABLE_MASK;
-- 
2.35.1.574.g5d30c73bfb-goog

