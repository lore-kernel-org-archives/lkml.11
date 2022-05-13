Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E966C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 20:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380485AbiEMU1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 16:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355333AbiEMU1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:27:38 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C031116A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:27:37 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id e189so11463556oia.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=99/RQ/TEDrl/cI0bVmdjzMtZB4uNUmEzljOvC28iEz8=;
        b=bZVS/9dhIQBdgxOQIoWwLltNrxEIHGDAhZIDN3/6OIjPwFdpBvz0iopKN7ya6UOdi5
         981dYqD4MjZmXZWtlYUYnovgp19XgUSRR6jeR7FqqzmLelkgcKCNd00rVNfF8VD0c0cd
         nb3hXRs6ATTiffpfG2R/iSJRhZAHBvI3ALIRE+G5oRoBk0lvRjXvFxR8Qv+10AKq/TD9
         0r2rSrT/PxSlrqYAfX52ZZtoZh22LZzRuNzoOkgwWdl4RKWsVz+iEJuLYn+N2akSv6tB
         4A5YgWcfF1Gd9SJc48V/3qz4pYZ5XMHRStI9LaOoecPrT8XTr4VHt7J5mR72djfj/sE2
         lBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=99/RQ/TEDrl/cI0bVmdjzMtZB4uNUmEzljOvC28iEz8=;
        b=H3oA2I7HSw4XuUh6ZHQScXINtdQuoJ03x57ePl93y93RQUWLYt2K8+4rPhlyDzLe30
         SsJbryvmybeQEMyBt9HFd6RsrsYsboWhbeePVmxffrO4nTwBvsstLPsG90auXPhV52WF
         2wPYKVo8xGultA48i23A/H1muTTQ5vUKdkyNWTIOcKFc4vo4C7C6ppse2UDizD7BnW1u
         pkQK5vqvqOwONavDsFf29FSwk+q8om0JWupmAGCTJnS/Rx8jA5/PdIhXa7vCvScgVNKE
         AD0whZxZosA0X7fUhvghN6NC/1jBWbNgMMRwQRXmSTUKuk7871/gGGEHuRyZeUzXx7f0
         Ph8A==
X-Gm-Message-State: AOAM5306AKp3SlcB55mILp3dlpG63NFENOBYEHCbT+fUpJ+TRnNmdacr
        Qohii6Y6lNj9MUlxLIokBzur4vnt5rQMdK9yNG5Frw==
X-Google-Smtp-Source: ABdhPJzjkjfXXwZJSABHc+7d9SbZttIFfFJyNa10z9JjsNyAbpCHZoW5BfjYx/hT0G28JwsC7f+aJcbiOHjbFiBKBOg=
X-Received: by 2002:a05:6808:c2:b0:325:eb71:7266 with SMTP id
 t2-20020a05680800c200b00325eb717266mr8793970oic.269.1652473656784; Fri, 13
 May 2022 13:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220513195000.99371-1-seanjc@google.com> <20220513195000.99371-3-seanjc@google.com>
In-Reply-To: <20220513195000.99371-3-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 13 May 2022 13:27:25 -0700
Message-ID: <CALMp9eQn+QaK630apzOz-L-btHxGQuXcbEiovO8FLOtMmQp_CQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Comment FNAME(sync_page) to document
 TLB flushing logic
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 12:50 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Add a comment to FNAME(sync_page) to explain why the TLB flushing logic
> conspiculously doesn't handle the scenario of guest protections being
> reduced.  Specifically, if synchronizing a SPTE drops execute protections,
> KVM will not emit a TLB flush, whereas dropping writable or clearing A/D
> bits does trigger a flush via mmu_spte_update().  Architecturally, until
> the GPTE is implicitly or explicitly flushed from the guest's perspective,
> KVM is not required to flush any old, stale translations.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
Reviewed-by: Jim Mattson <jmattson@google.com>
