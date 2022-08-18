Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CB3C28B2B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Aug 2022 23:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245586AbiHRXwN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 19:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346079AbiHRXwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 19:52:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29418DEA48
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:51:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so6080541pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=oaC18ebf8HrnX38abtQXUfLjaqpAibW92E0Qqkdt/rc=;
        b=T+KC6Nt1AiimE8ajVV6KYoQlIjigEeIHZOXa96RmlUjkUaKHBFLPChl56oXynEXv06
         m6LiSq7U+1u3ZSYIhZe58zoOesMMElcJ9Je7BgFd4b6vuLSUZftlmdztHdhDkUvFt2Wa
         F6TnsVHJlZbWjZ2nQBBXjqEpMGLfWJUA6Tlx/sJKolGWyPrMx+6X/lKBYW2pSsy/c5fn
         DPnak6w/X9MluZeAV8+stZfVacubj1+36xrJmO0c38xyGrWM+zDLC4VNfnHwEhPKUJtE
         xs/VyPE2SMKQxexOpnTP5g9KPEbp347Ffg5ahkkGN0XiNSMBSKq56N1kNKwXfddWYrIV
         HOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=oaC18ebf8HrnX38abtQXUfLjaqpAibW92E0Qqkdt/rc=;
        b=ihenj6z+VBq5q8dP+KLN/ydbXGXxo7rfDT7FtwdDQVcUeNOOncbYvazyOgPve8r8KR
         MgiBUO+EWBIOScJ2KN0BI5otAO17nRy4F0LX2et14MBne96oO7w6NQ5wsucGuNP2vTCj
         Fgys7AW6sAzcKn1gGdMT2d5VnUO9qEsraT9nGBJDDJrjTaFXrWfgAReDlmELD9zxQsEQ
         TFURpY5QP8K1zbzTK6xE+ExPzNcWhPcC0KkEOc0HKjFaYSbxtEc8tKmxFvpBKiyhtyho
         Q9FleKobVV8fefIEoUMce4WN3GR3S1AcQVfFyBYFUIpcouOmUHJkmGUiMT111gRT5P/T
         5dDw==
X-Gm-Message-State: ACgBeo3K1fKYAIVz7f+dva3Fw3AB9mhmyoBiWtTZJaC1defKeqnUAQvK
        Gxri4xc6SV0ssZiQViEIAUGEaA==
X-Google-Smtp-Source: AA6agR7RugQg8R049DKqEu9NlWz+7KkOdqsnKfMKK3JgKLU3K4/GDSKuwTWOmbpCclmxkVbpasa2hA==
X-Received: by 2002:a17:902:8d8a:b0:16f:21fb:b97a with SMTP id v10-20020a1709028d8a00b0016f21fbb97amr4712515plo.160.1660866718568;
        Thu, 18 Aug 2022 16:51:58 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id f68-20020a625147000000b0052a297324cbsm2181877pfb.41.2022.08.18.16.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 16:51:58 -0700 (PDT)
Date:   Thu, 18 Aug 2022 23:51:54 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] kvm/kvm_main: The npages variable does not need to
 be initialized and assigned, it is used after assignment
Message-ID: <Yv7QmoHtVDNU7dYk@google.com>
References: <20220812101523.8066-1-kunyu@nfschina.com>
 <20220812103009.8362-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812103009.8362-1-kunyu@nfschina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please use "KVM: " for the shortlog scope, and write an actual shortlog.  E.g.

  KVM: Drop unnecessary initialization of "npages" in hva_to_pfn_slow()

On Fri, Aug 12, 2022, Li kunyu wrote:
> The npages variable does not need to be initialized and assigned, it is
> first assigned before it is used.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---

With a proper shortlog,

Reviewed-by: Sean Christopherson <seanjc@google.com>
