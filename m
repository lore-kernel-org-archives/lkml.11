Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC50FC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 14:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346696AbiDAOKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346679AbiDAOKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:10:33 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F538137F54
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 07:08:43 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bc27so2496473pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 07:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Y01ccpg4aRT7Y3aBGXmonKaDsl4cnQt+ZD5CqEeB9o=;
        b=BIF/4cp0GMNppj/pJYpz/PIku56d0u+v9cjCE2X0WM7u9Ka9o51X5OL9WJoJMqMayF
         /Z/rOvkXYI90QanST6RsDdIxj+0YUvGQOH6VSpqYmv2sYWNZvYAo0FH7/z5xHPKii14h
         KUpxnCLjhAxWRRhGPrc2fxAkC37ygvJ66rjnqXVpTYpxm4yLTOk/65ZrDiGFh27I84Dt
         FfdkU13D3qtDIEoFOPEjdWg3hxmz46o2hsYi5UF2/JBXH6S+bMnCc2bDXKtg8vdQfaQI
         JjwwRaBGdo3ainePBLK4xtqtFYM9nGD5+wDTWeb5dCxGvaz0ZzRmJVRfokJDBxslTpuz
         1EiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Y01ccpg4aRT7Y3aBGXmonKaDsl4cnQt+ZD5CqEeB9o=;
        b=MJ331ai8H2wdhNLjZsCqaXz9H8I2rMt9BYwtIpsmsHc9Yqaxm0PuM/3fzPDK+b9ccd
         +5Zdv2opCkkgoLyrY43Cr+Oe/u2FPBXH8lGdL3qbeRmToGkxGfduBUcxINfOx47LefTL
         QKoamgqxT9bxZsoDfclq5PYOGm6XF+NHr9OQ6dFN0BRqjUbBsCos5QBevj+b62WtOFbs
         NfrKyldKyyn1h0NC+Hc8Pmv326BAYxg4iwyqzKJEqTFoE+RB5evFRWtoC2wEsrGv1MKp
         ueDWoDe1liTqIYin8F0LDSRWx8Goy8MDOyqG6G5KP2KqNrZ+wEpwvok/gk2QGZNAbeFh
         ywug==
X-Gm-Message-State: AOAM530DnHJXsGuC+IrsJ+ZsFLNNrEV2WBayCJV6UL7BQHkJNpUqI28J
        2qYyRKQE/Wqxmhx25eMk+jesNjIQhN3NJQ==
X-Google-Smtp-Source: ABdhPJxVvxCf6ws9DPMK9t3qqYhMiCd1b0MpABhK5fkCNrkPwKBsX8WAnN+EgBl36yTeXj0VqKqaYw==
X-Received: by 2002:aa7:8490:0:b0:4fa:a623:b036 with SMTP id u16-20020aa78490000000b004faa623b036mr11150575pfn.64.1648822122488;
        Fri, 01 Apr 2022 07:08:42 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s22-20020a056a00179600b004fb28a97abdsm3612801pfg.12.2022.04.01.07.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 07:08:41 -0700 (PDT)
Date:   Fri, 1 Apr 2022 14:08:38 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>
Subject: Re: [RFC PATCH v5 038/104] KVM: x86/mmu: Allow per-VM override of
 the TDP max page level
Message-ID: <YkcHZo3i+rki+9lK@google.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <5cc4b1c90d929b7f4f9829a42c0b63b52af0c1ed.1646422845.git.isaku.yamahata@intel.com>
 <c6fb151ced1675d1c93aa18ad8c57c2ffc4e9fcb.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6fb151ced1675d1c93aa18ad8c57c2ffc4e9fcb.camel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022, Kai Huang wrote:
> On Fri, 2022-03-04 at 11:48 -0800, isaku.yamahata@intel.com wrote:
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> > 
> > In the existing x86 KVM MMU code, there is already max_level member in
> > struct kvm_page_fault with KVM_MAX_HUGEPAGE_LEVEL initial value.  The KVM
> > page fault handler denies page size larger than max_level.
> > 
> > Add per-VM member to indicate the allowed maximum page size with
> > KVM_MAX_HUGEPAGE_LEVEL as default value and initialize max_level in struct
> > kvm_page_fault with it.
> > 
> > For the guest TD, the set per-VM value for allows maximum page size to 4K
> > page size.  Then only allowed page size is 4K.  It means large page is
> > disabled.
> 
> Do not support large page for TD is the reason that you want this change, but
> not the result.  Please refine a little bit.

Not supporting huge pages was fine for the PoC, but I'd prefer not to merge TDX
without support for huge pages.  Has any work been put into enabling huge pages?
If so, what's the technical blocker?  If not...
