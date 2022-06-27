Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B9FC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 16:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbiF0Q1U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 12:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239139AbiF0Q1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:27:16 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8F813DCA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:27:15 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id k14so8640185plh.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mvInyOfSwUwozjAA99zs61ByhccL7VTO1x3ICoYmzBc=;
        b=ajnq7ke4Zz4McbdwS+PvHKW0VTT+5/HKbvbyUSU1xxNO95siL3s1Jpz428GFKykOXg
         d8VB6gCmL6MAhNlqxOFU83q7MUtfZqaThTeljwRubrjY3FXr/nSrG8ysRcwC3JY9oXHY
         E/nazIf3ro2KlZr4d5FeO++ZCODHw1FvBEgFN0RUD7vpMXappy8dWxMkU57GzU0Zjw2G
         vT0p9IwlEukEh7Kxuyd/5hL3Huv66bpmY8YLrafTKaNkvkRpdXflG8tpbnFvxHj6/fm2
         e1NOsQAKbZvXwYzS6mETspy+MSA2+b26DyQwX1r3nMVNhSoR9V6muHqeAQbGFgyO+Apl
         N6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mvInyOfSwUwozjAA99zs61ByhccL7VTO1x3ICoYmzBc=;
        b=waw0nTJy5SEElA6qBOWdioKit77XQ4kM5jgSIEXOjnBmsv5ezuXrZtMoHLYnHJqviS
         f/HJrT7I8/cs6FcSVYHEpK+mYNPbWqOLHhaNswtrLybpBYkyx86TXT7PZpHEYCkal/Rz
         n5kL3fZYVnWLCHclT14fPcO82zDMmvechYTfNjqg8suyWy1+tXetuQpgzeRhQ3qZ19LS
         ugPPOMDOpABZPL964mSF8RGJg+psCzUCjIFBW97REFZioknEScfVpjkfmaleIXFuvcCW
         VqIW3rSUkKhbcl6AApsaraixFwIrYLyiWfBPdhbV1kYK/LpLTAzDXFfY/GtokKI9hQiF
         I1aw==
X-Gm-Message-State: AJIora8D56DaeQcsOXk1xRHZj97QOgKqXhVfYdCI08o2FuQ0Aulux56i
        VDhj3Ja+q5lvEhw7ylIneUwP3Q==
X-Google-Smtp-Source: AGRyM1tcFjGd3kEd1e3VvK1h2C/OoW2/ELgvNDxXEU16p6UpdQ8fqhAPxyZ462XWYdnE86YgJ158JA==
X-Received: by 2002:a17:90a:14e4:b0:1ee:dd88:f38c with SMTP id k91-20020a17090a14e400b001eedd88f38cmr6385973pja.62.1656347235128;
        Mon, 27 Jun 2022 09:27:15 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b00164097a779fsm7614578plh.147.2022.06.27.09.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:27:14 -0700 (PDT)
Date:   Mon, 27 Jun 2022 16:27:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Oliver Upton <oupton@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v5 1/4] mm: add NR_SECONDARY_PAGETABLE to count secondary
 page table uses.
Message-ID: <YrnaX/GzivdLPel5@google.com>
References: <20220606222058.86688-1-yosryahmed@google.com>
 <20220606222058.86688-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606222058.86688-2-yosryahmed@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022, Yosry Ahmed wrote:
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 061744c436d99..894d6317f3bdc 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -973,6 +973,7 @@ You may not have all of these fields.
>      SReclaimable:   159856 kB
>      SUnreclaim:     124508 kB
>      PageTables:      24448 kB
> +    SecPageTables:	 0 kB

If/when you rebase, this should probably use all spaces and no tabs to match the
other fields.  Given that it's documentation, I'm guessing the use of spaces is
deliberate.
