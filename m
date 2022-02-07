Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024BAC43217
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 19:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbiBGTXe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 14:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbiBGTVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:21:25 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E2CC0401E1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:21:24 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id on2so5473506pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 11:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dQAmEJaTjsYYRj2/TdOMTdvz+CnRCYyBekCT/t8kf+I=;
        b=sDoAX6Ob3ofOrHoMs08opCxUyc5qyAleP2EdPje331+PoY9+p3tHS81w/wOhERj1v0
         1Y6NHxbgaGvbgf+GfnJonkDP7YDfJ7F+4UwhIwJr9YvU3XI+g6x+OAqYPgV5Kyd8LPEc
         2VM2Ol0xD8wL7lCq0lEkbawbcKHzGYyegUbVYJ9sDWvQ2MfxhMVLb8G21aVb2qOXVrz2
         u0tCqjBaemKygGUudLqVQY4NcLRMDUy07FR6V8y3EUjNhDHMRXQReXGQdTzNKbit5/io
         hwEVTkStMysseSIvXNrYRYfppmCk9nI2r7dhQnk21INNuuVRU666S9oLYoDOF5teROrm
         Ul1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dQAmEJaTjsYYRj2/TdOMTdvz+CnRCYyBekCT/t8kf+I=;
        b=DDSWhN96iIEfufp14vONc1LB7pVkHbNPOYRnMPDd5SM7q3rjjp9iPTZ23o8Bn8k8go
         6rtqrF0IXiOZFLUVCSjTwgKl/9fZHJRD2FMzTOFTNCU6MRw7wY/6i2f5LA/ls1Gs7QKm
         YJCUmdJ+5EGhJbl09uP3i/RTtkLtFayIMT1i27isXCFoICFOfgQor0dKXjmgvMogvpOn
         ptps/Bek4zZHOMbWBX48fNcy8apl5eIx+bcrI1Vij3S4nH7azhGa0xfnokvIQoDKmp9X
         Kgl9aOWs0TRzd6Yc8jKPwaBkcMFh2Z/Q6CxcRvDh39OuPuQNENUNK9f9sZJjDo9Vf1Bj
         2Jng==
X-Gm-Message-State: AOAM53113cDB2HPOoOd+pP0sKLILphVP0Nmbf3kKrdyxxf0tNJ09fQsa
        eLhWqYN4BBAwnIu+mfdtLq28ZA==
X-Google-Smtp-Source: ABdhPJxXhdfSruO+ikpUuqBs1S04IgVhjGiIXc1y929u282qTpqJFP/GTOHlzX5pIpHxgc7zLNgqcQ==
X-Received: by 2002:a17:903:11c7:: with SMTP id q7mr1135434plh.83.1644261684169;
        Mon, 07 Feb 2022 11:21:24 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h14sm14265846pfh.95.2022.02.07.11.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 11:21:23 -0800 (PST)
Date:   Mon, 7 Feb 2022 19:21:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Gleb Natapov <gleb@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: x86/emulator: Defer not-present segment check
 in __load_segment_descriptor()
Message-ID: <YgFxL1uTKPCUpokQ@google.com>
References: <cover.1642669684.git.houwenlong.hwl@antgroup.com>
 <117283244eab58e94d589af58a5f2b245b8c0025.1642669684.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <117283244eab58e94d589af58a5f2b245b8c0025.1642669684.git.houwenlong.hwl@antgroup.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022, Hou Wenlong wrote:
> Per Intel's SDM on the "Instruction Set Reference", when
> loading segment descriptor, not-present segment check should
> be after all type and privilege checks. But the emulator checks
> it first, then #NP is triggered instead of #GP if privilege fails
> and segment is not present. Put not-present segment check after
> type and privilege checks in __load_segment_descriptor().

For posterity, KVM doesn't support CALL GATES or TASK GATES, so the "early" #NP
check for those is missing.

> Fixes: 38ba30ba51a00 (KVM: x86 emulator: Emulate task switch in emulator.c)
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
