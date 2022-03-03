Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EBDC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 00:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiCCAPm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiCCAPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:15:34 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FF5123BDC;
        Wed,  2 Mar 2022 16:14:47 -0800 (PST)
Received: from [192.168.43.69] (unknown [182.2.41.243])
        by gnuweeb.org (Postfix) with ESMTPSA id 88C177E247;
        Thu,  3 Mar 2022 00:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1646266486;
        bh=pjIJzJiKgtGI6lOvU1gIl3bz4ZoAsWLGIwIxTBOaBXo=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=n336WWVvPX+eTpTbvL/FgGKFA4bFJGsfhx7ZPlcexoW0rPuh3cfOBKHYV6yeB5U77
         wMmz7eXs3575SZmAXBJ3ZG4pYsUcRUKmCyer22k2R9z0ZYcs1s+pKZv7h94R19EDNL
         LEg8YrMt7LWpNS+nHmVAhUvfpv+fekXMCEDR1fMNmAVaRIXB2/wr9j47OUhRaFhG2A
         YzvHi+8lIcoo4AJ253Wh5KSgLqFUaDmisvb69xzQq7alLyMrqx0ZFUlWmTIv+3LTY3
         hJfJyKOlnN8lOaLs8TxN0VjTCkn72b09b5FfXG8l6RnhFErJHfOzbEZyi6WxLvE+jr
         k+Lec4y+/uNQQ==
Message-ID: <ad4f351e-202b-fa07-871e-a0c70c310ee7@gnuweeb.org>
Date:   Thu, 3 Mar 2022 07:14:38 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gwml@vger.gnuweeb.org" <gwml@vger.gnuweeb.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Jiri Hladky <hladky.jiri@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220301094608.118879-1-ammarfaizi2@gnuweeb.org>
 <20220301094608.118879-2-ammarfaizi2@gnuweeb.org>
 <0642444da1844f8dae2dc98b34b8ab74@AcuMS.aculab.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH v4 1/2] x86/delay: Fix the wrong asm constraint in
 `delay_loop()`
In-Reply-To: <0642444da1844f8dae2dc98b34b8ab74@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/22 4:54 PM, David Laight wrote:
> Both the function pointers in that code need killing.
> They only have two options (each) so conditional branches
> will almost certainly always have been better.

Yes, I agree with simply using conditional branches to handle this
case. But to keep the changes minimal for the stable tree, let's fix
the obvious real bug first. Someone can refactor it later, but I
don't see that as an urgent thing to refactor.

> I also wonder how well the comment
>     The additional jump magic is needed to get the timing stable
>     on all the CPU' we have to worry about.
> applies to any modern cpu!
> The code is unchanged since (at least) 2.6.27.
> (It might have been moved from another file.)
Not sure about that...

Thanks for the feedback.

-- 
Ammar Faizi
