Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B70C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 00:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbiBYA1q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 19:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbiBYA1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:27:43 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549771A276C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:27:12 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d187so3279422pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cw+klcamA272Cb5ODXPvx6exJVMPsgC02NTpWPnz0OM=;
        b=Ikdqgy/jVnfO2L3OLbVdKLMW8dEfP1zO5vRc8PFJNoknO1XoRQlBZP+flkXI8Mahch
         XAO2z3nSEkZPYpX2Pe85cvXYC6MvpyCM5mPK96jtw09q9cxht/i9B0aMnLQgS1kFKMjA
         n8Kqv7HKW0KieoOm/oh85MBBXF1fY0NwPyl18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cw+klcamA272Cb5ODXPvx6exJVMPsgC02NTpWPnz0OM=;
        b=Zyk2EhWeHXseYxcy/afXMEI70wbC64SLsCRFJEX0sUyS2w56oOcsreUJ+13B5I4jM2
         y9zubkUxhqa6DiYsw/nuUGehXtlpL1xcwfBFSplKocflskcsHX7aLlKi7ESdPgW9ogGa
         sbNdKI5enx23LFbeKuKArEgRwq+cK/9FDtaZbaEWGF9/qAJX0cqulvqxZriGS0knajz9
         UoZHeH7DuNnlyQsheCm0MqXNzJWg+0SQZOaR+Vekh0iHLRJ4PGTW7rD/nr2ym4AzNPHQ
         Tkag6SH865KEV+/ngYSXB+CSEKeALiwI16vflJIcq660oa3w+8qcmkDoK2sY8D7Vfhf2
         Ij5g==
X-Gm-Message-State: AOAM531y/2lsnRd5EZ70nr34cCU8Es88UMp6UwVJm0N41XoIKIH5Kunp
        sBVFVFXbF0fe9Vmler346UIyjw==
X-Google-Smtp-Source: ABdhPJx9Tq0nOY+LjkUD318qRA9/WOyOM4kzpCtQpV3PobzAcUHpHHEa9fSy8CvBhwyzIHtOp55Rsw==
X-Received: by 2002:a05:6a00:2311:b0:4e1:52bf:e466 with SMTP id h17-20020a056a00231100b004e152bfe466mr4986889pfh.77.1645748831778;
        Thu, 24 Feb 2022 16:27:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090a890c00b001b8efcf8e48sm7316514pjn.14.2022.02.24.16.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:27:11 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:27:10 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 04/39] objtool: Add --dry-run
Message-ID: <202202241627.82D924E72@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.248747148@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224151322.248747148@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:42PM +0100, Peter Zijlstra wrote:
> Add a --dry-run argument to skip writing the modifications. This is
> convenient for debugging.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Yes please. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
