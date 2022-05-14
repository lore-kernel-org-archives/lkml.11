Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39690C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 May 2022 21:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiENVzM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 May 2022 17:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbiENVyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:54:49 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF812DABD
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:54:48 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 137so10682100pgb.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t2yObVrbf/L9Jq6+JbbAXZHKIfGO1DeBECBvtcKWJrQ=;
        b=a2vCFtT3tXCJFlaBwLlox/cAPNUXQljxjpojw0pEncSqcq0/+C10zLDNqQyY4H4MZd
         kD7/dRMNsR6kSF64Nx5WKF94/fOyf5uHx7flzonMY2TVUorztqn2oJepkCTboXILUDhF
         ufEifGfG/qIMCjWxrANBavsxx++WXTI1Q3Clc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t2yObVrbf/L9Jq6+JbbAXZHKIfGO1DeBECBvtcKWJrQ=;
        b=JtbwmVBk8BPrMNgD8KXucWgdmLXjxH1jh2aJQhotl6IENJb6NWhmCdDa4rAsqYPc0E
         woFjYQhUwH6EZa9wnTXLMgiczaZuC4ogEhIi5Zf24W9pkICJ0JE0klEGc1cLHHMYfQxr
         7rqQ1gK4TXCK8xKPtDq3e2AUuQEeJAwKCOobL8axN5OaQBRHgCGG6JWZJ/RGT1FHkSe8
         i8RPgh2bznOp0cA0/5dCIhzcMG7xXN2sQeOvKBkQ/wxqMhTgUCQxVo7pOSXo3v4wqQcy
         SA2Iccl+YNuNU/+wxjNpLB7sQuBr8xng43LU7kA6pC35uguT1i7Jd19CMLdhrRImV8NG
         BBHQ==
X-Gm-Message-State: AOAM531mUvLMlWhwCJBaYVx0A5s1xWHAvt3qVGGiTBkwvUAr8hFqjnVc
        cSamFR4wuRLdDVKh5QXIg6im8g==
X-Google-Smtp-Source: ABdhPJzEbT+xSq2G7nTj/6I7DpbTkFKAAE5DIrDPZRYeOTIN7iK2Q3o6lSrZl7RpCs6ZWKyW4Fzjtg==
X-Received: by 2002:a63:381e:0:b0:3c6:d5e4:fed9 with SMTP id f30-20020a63381e000000b003c6d5e4fed9mr9243439pga.553.1652565287615;
        Sat, 14 May 2022 14:54:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u23-20020a1709026e1700b0015e8d4eb1ffsm4184143plk.73.2022.05.14.14.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:54:47 -0700 (PDT)
Date:   Sat, 14 May 2022 14:54:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 13/21] treewide: Drop WARN_ON_FUNCTION_MISMATCH
Message-ID: <202205141454.12B573ABC@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-14-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-14-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:51PM -0700, Sami Tolvanen wrote:
> CONFIG_CFI_CLANG no longer breaks cross-module function address
> equality, which makes WARN_ON_FUNCTION_MISMATCH unnecessary. Remove
> the definition and switch back to WARN_ON_ONCE.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

This one always felt like a trade-off, so I'm happy to see it go. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
