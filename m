Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C5AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 00:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbiBYAhE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 19:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiBYAhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:37:03 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AE7DC9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:36:31 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id n15so1114139plf.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/fHoBkozEjPo59VZpoS1m+m0V+1WtFDicdeo8x0G/6w=;
        b=A0i60vmWcJZtQ7JA/taGjHTqkC0GUNufgp2AdAHq0/5PktbYAGVKN/JT+UZQt4Y24l
         3LoYZQsNW2FTQfh6p5PGRzArI9V87CtCfvSi58Z6jpkuEqNIcJGv6Da7jeRt4xmW57Q+
         H3HQZJjgxP21W7cnzCFbO6wHax3W8snkrfkiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/fHoBkozEjPo59VZpoS1m+m0V+1WtFDicdeo8x0G/6w=;
        b=UKL2k+5sras0hsAFzDIGxX50887V7lDhPZ99GhsKCOttz5LiLARqneionL4U+uftJ+
         ipXk3ydH5SB0Js7PY/+YDI2qHRKznb3BCuS3BOCjbGHk0Nczzy6Q5OQ4QW/belTiKixs
         K2vBpefoBxz3vVmt2k18Y6TPUBYzWZIoeXUAjVSH7B/HComviQQZdPlQRulTkBLfxbqE
         roFZxMnxUkS7MUPESqRPYJn0Ip3xV3TDGqVXI7jwDGV9FWb7MQTxjmBnUSUNEOeUdmJg
         9am5/BhxcoGbHcrzrAhdePMHZ6UaC2GTQx8Gr14nkcFzEuq4PRxIWIQDQ5GPAaVEg4/L
         z7WQ==
X-Gm-Message-State: AOAM531ig0PkjtGYzk4SReRLHXCOmpHW+yLDcol3UDKU1C0mKSOLPEne
        KaLOyC5tukeJiKFW3/7rRbMIuMNEXV59mg==
X-Google-Smtp-Source: ABdhPJwLWpzGRU5WDJ3F034xJzTfBQsj+GT9Ng+8AS/lkWlnJYQhyW5jkwO2t78vO5q8juWBzNDuGw==
X-Received: by 2002:a17:902:f789:b0:14e:ebbc:264b with SMTP id q9-20020a170902f78900b0014eebbc264bmr5168927pln.169.1645749390719;
        Thu, 24 Feb 2022 16:36:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gz13-20020a17090b0ecd00b001bc5defa657sm7310285pjb.11.2022.02.24.16.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:36:30 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:36:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 06/39] x86/ibt: Add ANNOTATE_NOENDBR
Message-ID: <202202241636.31E280D7@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.365217607@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224151322.365217607@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:44PM +0100, Peter Zijlstra wrote:
> In order to have objtool warn about code references to !ENDBR
> instruction, we need an annotation to allow this for non-control-flow
> instances -- consider text range checks, text patching, or return
> trampolines etc.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
