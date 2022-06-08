Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA27C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 22:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiFHWWx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jun 2022 18:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbiFHWWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:22:49 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EE338BF0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 15:22:47 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b135so19510657pfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 15:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hV9CZl1vmV5FpGJFtmBowLl6tofEOt5xbuFmkjxS6PY=;
        b=FQfOQ8x9oTcvOtuHi0eHy18Ww0jN7ukkvtMoS8l0B+Yy4cvyfJRSjgrceDmgNhbUnL
         xfL1f4UhxFB4yKfNjn05Zx6bshWnbZF3e+9xyxOQUvelyb4AND6bj8truWw3SOgyPj/r
         fW5R4+Kepw+gpmmv6lsXhXNpGTAk7d0mNSRfAI1KRpRrgjLg0uEKWBg6Dhg4KesEz7jL
         Va+AVwp/dEPNZKlg3lL93UNuXG3qtHbb9lLTe+5p1zpEwRJYMS4jjqRNg6z7CZUJrjNh
         rT3iCj7GI8U/IGdvGg5PqSWsorNak97BqLhYIxroUvz9EgmVTcSIPQI92vrEpGsowNnD
         gtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hV9CZl1vmV5FpGJFtmBowLl6tofEOt5xbuFmkjxS6PY=;
        b=ap++2fGowmsJ4aS0g1RXGY5+fiSQgq/rdKq6BBQgZCJWA5YqE0EjS+hd2Tl974AzmC
         8V25ByBx6l9JbricO5X5qnJPt9EkyV0KE+x4X005cZtTFbgtbGaA381w67jomLZ5Ut00
         MQcJch6ZrxKFeQAZD5ablwEDZ6cOBq3WUtNKkXSkWzzon468pNaAltiX3xkWnBXcfCOD
         O1XJh8vP/Hl9Kmi+4ZpuLHZybCWOkBml9Whfi7NjbhSYijgyCm3jPMZvgS9GOlkoyU7Z
         /XoI54F3I2E6RIUTep18wO0+uN7qfJoA9MZNqY0jWUt26c5mnHOCDeYuQl+qMZUImah6
         Q2Pw==
X-Gm-Message-State: AOAM533NmOVQCMRBJsJKPhYg8uNs0CDqJ26S7vwTfMfQaz9/3ajCYENP
        DJPr+gULNAiJkIQYh8Yx5KxHYw==
X-Google-Smtp-Source: ABdhPJwPM4EsvlNxmcyTfRvkMb+/8M7At1A7hBEdBL/j0X7RoGt+d38G9+zoEsJLqPDwLHM0MzsnPA==
X-Received: by 2002:a63:ec48:0:b0:3fe:44a3:bf4d with SMTP id r8-20020a63ec48000000b003fe44a3bf4dmr2914113pgj.610.1654726967180;
        Wed, 08 Jun 2022 15:22:47 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e22-20020a17090a4a1600b001e345c579d5sm14405982pjh.26.2022.06.08.15.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 15:22:46 -0700 (PDT)
Date:   Wed, 8 Jun 2022 22:22:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        likexu@tencent.com
Subject: Re: [PATCH 2/2] KVM: x86: always allow host-initiated writes to PMU
 MSRs
Message-ID: <YqEhMxlPxzP+CPSR@google.com>
References: <20220531175450.295552-1-pbonzini@redhat.com>
 <20220531175450.295552-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531175450.295552-3-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022, Paolo Bonzini wrote:
> Whenever an MSR is part of KVM_GET_MSR_INDEX_LIST, it has to be always
> retrievable and settable with KVM_GET_MSR and KVM_SET_MSR.  Accept
> the PMU MSRs unconditionally in intel_is_valid_msr, if the access was
> host-initiated.

...so that userspace can explode in intel_get_msr() or intel_set_msr().  Selftests
that regurgitate MSRs are still failing.  The below "fixes" the issue, but I don't
know that it's actually a good idea.  I also haven't tried AMD.

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 515ab6594333..fcb5224028a6 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -401,7 +401,7 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
                        return 0;
        }

-       return 1;
+       return !msr_info->host_initiated;
 }

 static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
@@ -497,7 +497,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
                        return 0;
        }

-       return 1;
+       return !msr_info->host_initiated;
 }

 static void setup_fixed_pmc_eventsel(struct kvm_pmu *pmu)
