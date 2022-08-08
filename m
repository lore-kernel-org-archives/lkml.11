Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017D6C00140
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 17:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbiHHRwW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243591AbiHHRwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:52:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E34EDFFA
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:52:19 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98cb329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98cb:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 613A51EC02F2;
        Mon,  8 Aug 2022 19:52:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659981133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JRJo7F2gCg2Q0iwSOcsKqBEMEw8Tt1m4hAD6oBd1hBg=;
        b=AjsuszBWb38+AQP//zAjgl4mLUEBfRlAVHX8WdLlXNMROy2LTy85rsEusvE0Z2NOmYV0Ay
        zTFzRRfIwC9ex4UR4ZA+4IFJNgG/2uPOZtLzNB1z67e6KcswZ/+2YwcA8pu7oPJPEbtnhx
        +UgpaaHtxXkXvoAwoh5HDQf9WTDLdBg=
Date:   Mon, 8 Aug 2022 19:52:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 1/5] entry: Pass pt_regs to
 irqentry_exit_cond_resched()
Message-ID: <YvFNSTho79DO4P8E@zn.tnic>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-2-ira.weiny@intel.com>
 <YvDnkALyHl77R/Ug@zn.tnic>
 <YvFJGxU0k492npYT@iweiny-desk3>
 <YvFKHaRdOkg5RHtv@zn.tnic>
 <b929e415-def2-b47b-fd1e-57877a98c2ad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b929e415-def2-b47b-fd1e-57877a98c2ad@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 10:43:35AM -0700, Dave Hansen wrote:
> Might have been me.  Function calls that look like this:
> 
> 	foo(&ptr, false, true, false, true, 1, 0);
> 
> are incomprehensible.  A true/false is effectively a magic number here
> and you have to go looking at the code implementing 'foo()' or at least
> the declaration hoping that the variable names help (if the declaration
> has variable names).

Yap, agreed.

It would start getting on my nerves after the second bool. :)

> I think I've encouraged Ira to do something like this instead:
> 
> enum foo_mode {
> 	MODE_BAR,
> 	MODE_BAZ
> }
> 
> where the call ends up looking like:
> 
> 	foo(&ptr, MODE_BAR);
> 
> which is much more self-documenting.

Yap, that's much better.

I suggested the bool thing in thinking that this would be the only
exception to the usage, i.e., a one-off thing. I probably should talk
to Jürgen whether we even need this one-off thing and maybe solve it
differently.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
