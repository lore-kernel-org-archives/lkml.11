Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28CAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 20:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbiCCUEk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 15:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiCCUEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:04:38 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B858D4B40D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 12:03:52 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id j1so1711224pfj.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 12:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pi8iH0FAYkIoz6MeuCkLdqM2juK9qQBoN4Ks48wQ+iA=;
        b=kwAxKx2fJbB7ljjwDZJV2FM0kwSPs73r6pQ8wAnY/3kHs37v6JZsIrTXQN53Bt4skz
         yyqVxn6+X7N3wpZLLN8h9GKt32c6qIlcAPqIDKfo9dH5iB1eeQ6v22e/xOtcht6inFUJ
         B6F87BAaFpwNu1r6QBlFyBpzdbDDpoOM224IxSKT+Abshs68aZSvbBiNdoE0jevxiMAj
         7rbmoLO/r5urHspdeg6T/wy63VhA3E3KCf0BgXYo3dI6ht7Ge1Q6QDHUgN+O+RgQCiv/
         uDwKWtOFhUyDGdvaJccDbRAxzkpHF8jms3QQ+IAqDUnsN9OFu1H/B7iQO8Z/CgnwzUjM
         uhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pi8iH0FAYkIoz6MeuCkLdqM2juK9qQBoN4Ks48wQ+iA=;
        b=M/OFCkyB6gf3XaVkijrl8FPnqTP3DUKWiXgP6TO6EQgUnaM2E4hsAlIXkN2jzYdpVr
         R9AG5YSpxK87qFQnnka3tOh/xLms/dNbMalFOzG1DYWJJEIJUJnvlTWLO7mdHDP4jnJv
         n+7/PlCnpfH77qYlQsKUxEWv/AtKMZnTs1721Myr+/FXQ5Altp3cH54VNkMU3yvijxIt
         2p2aDYSahD9ZXycrBSXOo3dCVzDuyg1AJ6is6JR1nJgpVifUvokPFxYF6mCedypcwRIm
         OUC2zFxKPFczvlDPFo6NVe8nSkCu0l9+znIyLLSCiOX8395en5CBBGOMBEBA6U1xP4et
         ABSw==
X-Gm-Message-State: AOAM530GIK9e5mvsUXqGaSQAuULdwKrmwCWY6gcg4sKGxWcq09yv1Ds/
        1ywy0OO4ycWpTYwMKevhalisvw==
X-Google-Smtp-Source: ABdhPJzWDDSu+QZHAmizrO5aMSiFU6NdT3KLIfTXE5v94X6e4+P4/7SuaoNqW/drd1Cpjh/dctSSSg==
X-Received: by 2002:a63:d252:0:b0:363:271c:fe63 with SMTP id t18-20020a63d252000000b00363271cfe63mr31827445pgi.524.1646337831852;
        Thu, 03 Mar 2022 12:03:51 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m4-20020a17090a7f8400b001bef3fc3938sm2837806pjl.49.2022.03.03.12.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 12:03:51 -0800 (PST)
Date:   Thu, 3 Mar 2022 20:03:47 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH v4 06/30] KVM: x86/mmu: only perform eager page splitting
 on valid roots
Message-ID: <YiEfI0s6PJyHR96L@google.com>
References: <20220303193842.370645-1-pbonzini@redhat.com>
 <20220303193842.370645-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303193842.370645-7-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022, Paolo Bonzini wrote:
> Eager page splitting is an optimization; it does not have to be performed on
> invalid roots.  It is also the only case in which a reader might acquire
> a reference to an invalid root, so after this change we know that readers
> will skip both dying and invalid roots.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
