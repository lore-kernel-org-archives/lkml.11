Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D448C433FE
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Feb 2022 00:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbiBSAAS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 19:00:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbiBSAAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:00:16 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2062599C9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:59:59 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d187so3573546pfa.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bF+kadvtXphhO74WqkXqArBv71tts+NWvqqIHsF6pqU=;
        b=fR9iTp6Jc38F95EPHtI42XUM74mmtiWgyfLjsrZq+94KR33LFTdbWl73/13Q0m+1Il
         iN4McXYYOkb9kHHDSdXqaipcdhZ+BnoPP9gnI0a+7wXOwIcNi1id3Gt5Fz+cWg7yyoNC
         CR/wnlTyV/CbjIOD3s2DATFcJCbHDt8f40ddcz2lBQI4qeMWO7NM11YUyvVJbg1kvzeA
         vEx/m+ZDhtvfzTtewb5FGXtqhmLLUGTG32HmTk9vqmDzvzWkzhjBJqOfgHEkliD+gSQX
         g+DW7YsQ+XO0rtpZ0GwnWAzCKL9889gMKT0+U85EnD5OS6ihiHWczZnkBpga76NFv2T2
         6/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bF+kadvtXphhO74WqkXqArBv71tts+NWvqqIHsF6pqU=;
        b=FQFHI8HzNVLXTwQa/jm3GRq2UFaf4GpjKVPI3VeuieEyqddrofFnHfjE6/o6wIMr64
         r5w+StSSnnQHxFKOLKAqrlwamkPP9gZs/tEEZUs6TqcAKR38UfJf1UlR3L1yXN7ST3Z4
         ZRZm4F5WvM02Yyh4sWbzGpjX2QGZ8HLAo2zmyweFn3n9FX8ZwabXFQJi6yzbfD6aUdZw
         hPoPefeB07pZSoxFfGKWqFF4cyO1AlOYzG7MDKdk4fgs9Ki0bpgc9DD4NvO1jG/50YQL
         TZKWZ8ZOnfv8q8SL+IMOd1hIqw+nOjBmSghsh/+FBUNOXd7x19tvYhd05yi3XTCOoYYW
         p7dw==
X-Gm-Message-State: AOAM531HfCgambX1beTh1ePumm2RgY/veOgzZhmM4rbmEifIczbHDmFO
        XQ60rTEZQyKZtw69PXHSHxAlEQ==
X-Google-Smtp-Source: ABdhPJw5EQVwQses0OZ5O/BbE5LuFqDk2NwDxSOBbA/mnTV4r7uT5knR9p1zTWZP4nqy9lrMqDkSaQ==
X-Received: by 2002:a63:f357:0:b0:373:9242:6b95 with SMTP id t23-20020a63f357000000b0037392426b95mr8113263pgj.536.1645228798470;
        Fri, 18 Feb 2022 15:59:58 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f8sm1192550pfv.100.2022.02.18.15.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 15:59:57 -0800 (PST)
Date:   Fri, 18 Feb 2022 23:59:54 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 11/18] KVM: x86/mmu: Always use current mmu's role
 when loading new PGD
Message-ID: <YhAy+lFk+pEIt0gf@google.com>
References: <20220217210340.312449-1-pbonzini@redhat.com>
 <20220217210340.312449-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217210340.312449-12-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022, Paolo Bonzini wrote:
> Since the guest PGD is now loaded after the MMU has been set up
> completely, the desired role for a cache hit is simply the current
> mmu_role.  There is no need to compute it again, so __kvm_mmu_new_pgd
> can be folded in kvm_mmu_new_pgd.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
