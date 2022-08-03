Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8997BC3F6B0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Aug 2022 18:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbiHCSpA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Aug 2022 14:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbiHCSo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:44:58 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0948C5A2F5;
        Wed,  3 Aug 2022 11:44:56 -0700 (PDT)
Date:   Wed, 3 Aug 2022 18:44:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1659552295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g7bMaMFszZ1MPKgJtTZ+sgj6npq+ZvD/i5D5SsBGMIY=;
        b=XQ5jnXfVQrAfNHlxUqUVo/nmzws8N4oK9IQKiB2ND+dvvJL1kkbvd5xe5/MeCuH287gFGB
        CHOGgmH2Jkgk71FjoRfPReNmxS2zLK/AYkcfR721XdKO5sWXF8hmWvK6jLWkz0F3iEKlpm
        XuuBgIjgZ2asBfla5nd0aCDmYwlFkm4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] selftests: KVM/x86: Fix vcpu_{save,load}_state() by
 adding APIC state into kvm_x86_state
Message-ID: <YurCI5PQu44UJ0a7@google.com>
References: <20220802230718.1891356-1-mizhang@google.com>
 <20220802230718.1891356-3-mizhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802230718.1891356-3-mizhang@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mingwei,

On Tue, Aug 02, 2022 at 11:07:15PM +0000, Mingwei Zhang wrote:
> Fix vcpu_{save,load}_state() by adding APIC state into kvm_x86_state and
> properly save/restore it in vcpu_{save,load}_state(). When vcpu resets,
> APIC state become software disabled in kernel and thus the corresponding
> vCPU is not able to receive posted interrupts [1].  So, add APIC
> save/restore in userspace in selftest library code.

Of course, there are no hard rules around it but IMO a changelog is
easier to grok if it first describes the what/why of the problem, then
afterwards how it is fixed by the commit.

> [1] commit 97222cc83163 ("KVM: Emulate local APIC in kernel").

What is the reason for the citation here?

> Cc: Jim Mattson <jmattson@google.com>
> 

nit: no newline between footers.

> Signed-off-by: Mingwei Zhang <mizhang@google.com>

--
Thanks,
Oliver
