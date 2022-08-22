Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C63C32772
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 17:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbiHVRwk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 13:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237075AbiHVRwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:52:38 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91DC44542
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:52:34 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s199so13092256oie.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=U2h5OXIBtshmMp3mHspaMeSDYtMFmp6iDWsUHs1xsvE=;
        b=DPE70e9T2KhFYle8ZEtERFl+OtAzDLlj7JzEHgoh+udL+iBNNhw+/09fRAyhoaK8Sq
         Atnb0PglyST4kowizHMLWZapRO8ixt5dvKZkpIoQrlmlIejPxAikNZx8sEOafM4ZHwMr
         wqm9lbxm1EMEJZWqVkZGVNbAw3oLdjJte637zPgr/EibG4hs9MDa09zpewKgMTTwX9tD
         GfukNr/sgUnsFKK36mszlgRh29Z7twjQRUaGwlQRCmY3/wKWWOz4nKwKhqcbOJXS2f4K
         +8Fkg80/Epe6tfYySghxpUA9guu4MLbDAy1c3q9ueOqG27DrgPRD0gxThAjgY5ZfJNHB
         J8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=U2h5OXIBtshmMp3mHspaMeSDYtMFmp6iDWsUHs1xsvE=;
        b=NW27ZBxNEbIxu5Wu4rWg/SfqCfAyZZNPtlpcIrzBRgrvy1H9+cqwNPEYvmv3NVu5BM
         YCoKOJBzK03Go1yK2aGV6XTV6ZzbiJlOab/6XitgV4jWILKVbhnP9HFXXIfYmByB7BwC
         ++Fi9RnaNWRhPNSTvEZTC3zTCUTxHKy1JqnnC8KE8xZQQdRno9ydcQdaswMxif+p5kIM
         NlJQFP4YS2Z5hnI6s9Y1aZ+14VWJvfzxUHLV/xLy+viOADssGE6mJyqYy4rUmUa6qLSL
         hmuF7B1UupDpo1DEYhQID+2pSue5caatFokwuU7mF+BwXg8by8VZYRZgX3zcRLIEgHqN
         auIA==
X-Gm-Message-State: ACgBeo2NizMzczHVIyFN+z82tlyyFc/zkyNAqnSOjdnfEtOlwoPTVDk5
        VQF3DyyOCfj0D4jVV/Nz4TToX/Pza8WXJSORRhF/3A==
X-Google-Smtp-Source: AA6agR79ebV5129RKavswXPVJ+9jQjtHbNqi7U32f7bcfK5zHIBh170ynXk7u8oGwLYI2TrCnHetzVwH+oC9/CUzayw=
X-Received: by 2002:aca:170f:0:b0:343:171f:3596 with SMTP id
 j15-20020aca170f000000b00343171f3596mr9159402oii.181.1661190753993; Mon, 22
 Aug 2022 10:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220822170659.2527086-1-pbonzini@redhat.com> <20220822170659.2527086-4-pbonzini@redhat.com>
In-Reply-To: <20220822170659.2527086-4-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 22 Aug 2022 10:52:23 -0700
Message-ID: <CALMp9eRaTV+B6+SA0ecwi6u6KfNyVX33VToYQe-A5ovS=UAwUg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] KVM: nVMX: Make an event request when pending an
 MTF nested VM-Exit
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        mlevitsk@redhat.com, seanjc@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 10:08 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Set KVM_REQ_EVENT when MTF becomes pending to ensure that KVM will run
> through inject_pending_event() and thus vmx_check_nested_events() prior
> to re-entering the guest.
>
> MTF currently works by virtue of KVM's hack that calls
> kvm_check_nested_events() from kvm_vcpu_running(), but that hack will
> be removed in the near future.  Until that call is removed, the patch
> introduces no functional change.
>
> Fixes: 5ef8acbdd687 ("KVM: nVMX: Emulate MTF when performing instruction emulation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
What happens if live migration occurs before the KVM_REQ_EVENT is processed?
