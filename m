Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B069DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 14:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355558AbiELOqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 May 2022 10:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355593AbiELOqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:46:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3A9289B0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:46:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652366769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+F2xDGOsy2uquCq56PXknf31hnVzXI6nb9v3w4WcNc=;
        b=c53TXvAGB+EtpvdOoNmfuR9lzEdIKm0QmNBAMk2SgIX3RwNyRDMBJvdHBJ1k1FX8E33fWY
        ysvplNSDGPTBIOV01BnX9yC38LmZzDmKDgtSK9A+PtpUp6uEe8ePsoNc3amgBcShBOQcsk
        /lMD+55iveacdequgowysOXL/7IELtEW5Rqxg1cT23Jzzwpv93Vt7+3GhN/3/vgR9JR1XR
        H9gW0aDRKOSomB0bl+Llyf0IGkiKKs0n+vy4WvsDfoQnm66XBMflh8x0pjBzMCD/6mQAb3
        baXso2XFHY9YmAEyn5aWPLJzkRNdoD7Ykkp9sL9//Ecn9AjGEAKGHvkJY3b4uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652366769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+F2xDGOsy2uquCq56PXknf31hnVzXI6nb9v3w4WcNc=;
        b=51Rwl7xI97zYkIYKObqfq0D2lBrxNyNt8Fo6OljjyqIfCVKXlBtGVBIkP60ilmj1kIi8Vp
        /5+omwMjwBN/HrDQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 09/10] x86/mm: Add userspace API to enable Linear
 Address Masking
In-Reply-To: <20220511072651.GV76023@worktop.programming.kicks-ass.net>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-11-kirill.shutemov@linux.intel.com>
 <20220511072651.GV76023@worktop.programming.kicks-ass.net>
Date:   Thu, 12 May 2022 16:46:09 +0200
Message-ID: <87y1z6vmfi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11 2022 at 09:26, Peter Zijlstra wrote:

> On Wed, May 11, 2022 at 05:27:50AM +0300, Kirill A. Shutemov wrote:
>> @@ -1013,8 +1017,23 @@ static long thread_feature_prctl(struct task_struct *task, int option,
>>  
>>  	/* Handle ARCH_THREAD_FEATURE_ENABLE */
>>  
>> +	if (features & (X86_THREAD_LAM_U48 | X86_THREAD_LAM_U57)) {
>> +		long ret;
>> +
>> +		/* LAM is only available in long mode */
>> +		if (in_32bit_syscall())
>> +			return -EINVAL;
>
> So what happens if userspace sets up a 32bit code entry in the LDT and
> does the LAM thing as a 64bit syscamm but then goes run 32bit code?

AFAICS, nothing happens. The only requirements are CR4.PAE = 1,
IA32_EFER.LME = 1. Those are unaffected from user space running 32bit
code, no?

32bit code can't use 64bit pointers so it can't have metadata bits
set. But x32 can and is excluded by the above too.

So the whole muck must be conditional on CONFIG_X86_64=y and does not
need any other restrictions IMO.

Thanks,

        tglx


