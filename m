Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108D1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 18:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245127AbiC1SQz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 14:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiC1SQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 14:16:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1283329AE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:15:10 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w8so15357055pll.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yx9kLPZnDKhG+ivFoq+Z75QS1wPbQ4/wxiiI/bt3KCk=;
        b=BTPpWTU8xrIwoxNqU6R1SSY0gPXLBH+zjlrIdX/FdmWY88Uj0bMGhuiEPCRpNq794v
         TB3d6mGf0oczE0OzBTfSNngIUHBFcfRbJvzVl6w4k7sBIziwW/A6CCsTDRMNdPpVSsVq
         JE5xGaF3bi7sLoGDWWg9L7lyMuX/Gi2LyW7sQG34e4NeAAh9M75FVZN7lZe36yHNivVp
         VaRoHiYlDBkxao5T6kbaNsY4O15oyN2NClhmmqZq/gxx2UmRid59HwKLcKZYj77aTZc3
         D13YfxDBj346PkTGdKndOIxCFIHEhROiPEGagSCxXpcdqrW7ssGDTg/Ne1mdyIxGXa9f
         mOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yx9kLPZnDKhG+ivFoq+Z75QS1wPbQ4/wxiiI/bt3KCk=;
        b=XR2lLSi6zbY1zTTrA+LGi/2O13ojRdAb8NlIjm9cLGcPoY/qwp7OY71IBe5mwzd2b/
         udhN9RpM9JMuFA1gGFxsuLUiTHqiTS4RtxQGZQK1cc7Ns9LDq3isOqiTBW4rIO/vFE1C
         Vq2DllwcP4xzMmjZp0X3obGZYULYIYVbRUfekgQdYR1/zgotSGtwv23kntgEnrB/judw
         cMtKtBpVSd+bGWMg42FX+6Dx5YyzPpmc2+0GEj4H/vtYFMlWQqFfVTes/CyN0rDKPFZV
         P22U7NX8WKNRFrwN7rozm+iip6wH757IHDK83O+FZhnIBist/gAIiy8hc8mg0+QRJNFj
         peFw==
X-Gm-Message-State: AOAM531yYbtWEZeoXtIvTQjvx1aP5usWI0hWcYor7E+uUuudtMJ8UteD
        FM0D4NYrRYb4wxSh2zvZt0+XPw==
X-Google-Smtp-Source: ABdhPJyxl/grzo9wrN4NyoMupFLzcrY8lyyPwkdDjRKFBM0KgUaIFFSabfBfzkW8SlJl1Ha/MHGT9g==
X-Received: by 2002:a17:90a:3b06:b0:1c6:7140:348d with SMTP id d6-20020a17090a3b0600b001c67140348dmr418330pjc.99.1648491310293;
        Mon, 28 Mar 2022 11:15:10 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id c18-20020a056a000ad200b004f0f9696578sm18399890pfl.141.2022.03.28.11.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 11:15:09 -0700 (PDT)
Date:   Mon, 28 Mar 2022 18:15:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: add lockdep check before
 lookup_address_in_mm()
Message-ID: <YkH7KZbamhKpCidK@google.com>
References: <20220327205803.739336-1-mizhang@google.com>
 <YkHRYY6x1Ewez/g4@google.com>
 <CAL715WL7ejOBjzXy9vbS_M2LmvXcC-CxmNr+oQtCZW0kciozHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL715WL7ejOBjzXy9vbS_M2LmvXcC-CxmNr+oQtCZW0kciozHA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022, Mingwei Zhang wrote:
> With that, I start to feel this is a bug. The issue is just so rare
> that it has never triggered a problem.
>
> lookup_address_in_mm() walks the host page table as if it is a
> sequence of _static_ memory chunks. This is clearly dangerous.

Yeah, it's broken.  The proper fix is do something like what perf uses, or maybe
just genericize and reuse the code from commit 8af26be06272
("perf/core: Fix arch_perf_get_page_size()).

> But right now,  kvm_mmu_max_mapping_level() are used in other places
> as well: kvm_mmu_zap_collapsible_spte(), which does not satisfy the
> strict requirement of walking the host page table.

The host pfn size is used only as a hueristic, so false postives/negatives are
ok, the only race that needs to be avoided is dereferencing freed page table
memory.  lookup_address_in_pgd() is really broken because it doesn't even ensure
a given PxE is READ_ONCE().  I suppose one could argue the caller is broken, but
I doubt KVM is the only user that doesn't provide the necessary protections.
