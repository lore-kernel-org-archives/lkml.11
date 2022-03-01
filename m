Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B310C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 16:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiCAQCF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 11:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbiCAQB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:01:58 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B5CAA2E9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:01:17 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b8so14425796pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 08:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FOTnEnGACgB5Bk0D14/AB+9Z+trEttYfi5rz0BAbtxY=;
        b=I/HkopzXNorheEyhcZ/g76CVw+5ll/sQ/+aXHyYy0GCtNyb39Gco5O+XdpP2j2CTGR
         UCp1DFd6yS2gs1jCniIkJmuUYLBEArSEXPKdwIks79kh6iuoZQOzE/i/h+cpXLRzsJS+
         ct42/TAF7A7jxr+lgGt90tdPIAl4isDw0cdKWNs3NmNdzwigV9aU/pZqWak28uEdOecw
         +NJ9JZljECf7fCgAfyMlRwYCcuHFdVXY9Jg4cXotUH9CXkvq5sSFUgo4tOJb69gcq/ED
         jbNtO3YqLJ5n/WhpP79q4bJVmlegR/q6saVmeX9KwVrbRd6jXhPjpHnNo7UimSUm3Ha3
         wpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FOTnEnGACgB5Bk0D14/AB+9Z+trEttYfi5rz0BAbtxY=;
        b=C+4k7Ay6uubqXJHXc6npDHJ0UKqttzezlTXj51eKTrEjYez4ENN/zCok5gBiHGqwyb
         umNWWyTQ6/3tJ7JC42jXtVKj6Qi973rP1Y31z+CHDO4X1GL1IpTUwDRXZEyEluwfq+UI
         A3p7+10lV60tV33QjRF1yOcixKF4cYGSIZoHcwOAQokPxe6TrKm/1/iipe62W446KQWb
         ENBzundHu4/LivuDZO8jIhsHfKGtuamscNXDWDmeN4sNk2flko7z/BEAlA8qEUrTCald
         t51boaHyLzPBcnz/RnicSA+enKOTFQa3pcZfgXZTCKxbTODj7deF6789FZ4nT141eQzn
         iriw==
X-Gm-Message-State: AOAM531wYJRuzx9JyMcHgwH2akaFyFH1obacAA/g9K6pEM7FgLVxChzE
        bLGNUsl3JJqVC3rjuRumPFTZaQ==
X-Google-Smtp-Source: ABdhPJwu+wbd17ov15qZLV0fRQZUccsU1xthamy45d06vJwkcDblxej43LRcZVyrB+uveMXngfSLQw==
X-Received: by 2002:a17:902:f68b:b0:14f:c84c:ad6d with SMTP id l11-20020a170902f68b00b0014fc84cad6dmr26210741plg.155.1646150476695;
        Tue, 01 Mar 2022 08:01:16 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 124-20020a620582000000b004dee0e77128sm16390756pff.166.2022.03.01.08.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 08:01:16 -0800 (PST)
Date:   Tue, 1 Mar 2022 16:01:12 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/i8259: Remove a dead store of irq in a
 conditional block
Message-ID: <Yh5DSMiqDrMPb/YH@google.com>
References: <20220301120217.38092-1-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301120217.38092-1-likexu@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> The [clang-analyzer-deadcode.DeadStores] helper reports
> that the value stored to 'irq' is never read.
> 
> Signed-off-by: Like Xu <likexu@tencent.com>

Reviewed-by: Sean Christopherson <seanjc@google.com>

> ---
> Note: not sure if "irq2 + 8" should be needed for "s->pics[0].irq_base + irq"

Nope, IRQ 2 is used to cascade PIC controllers, and the two controllers have separate
vector offsets/bases.  The code was there in the original commit, 85f455f7ddbe ("KVM:
Add support for in-kernel PIC emulation"), best guess is that it was leftover from
development, e.g. maybe a flawed assumption the the second PIC's vector was simply +8?
