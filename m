Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F096C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 01:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiDEB6M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 21:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiDEB6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 21:58:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F192D0FF7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=g3/9ifIMe8499bJjqwtI6WMMgnnCdftgJ1sOXpFYRfY=; b=c7/E1W/TluDz3qbEGO7TtEdECf
        xdUiwylYxLnkjRVUhmmMUbUKeYVj6Wi6CDiTqMOt29O9v/cC9wk3GllU1k7jNEbOpyplvaukLBRpS
        0zGzm1+qdBqAImKIdMQHEKZ37pbM88sNerMTS53Ydg73AW9Mta9neNrciHWO4Ken0lWq+22Uktff9
        RkUKyfpYyjfbOFB8537CAl5RGjwQyy/IJqsslFTl6KsYzLyNnFyQ8aT90oJC+KeGk2AjAyMHmnuWj
        DnsohtaZo34vTipUNBEfPkmD31QpJ73PYfwcxTgroBQCkrw73zMzqRJHcvTbdLJHheCVhplb8wPfC
        aJDGKFvA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbWx6-006CUN-Sv; Tue, 05 Apr 2022 00:21:45 +0000
Message-ID: <008aae79-4a6c-721f-7ef5-7b73f6d7e000@infradead.org>
Date:   Mon, 4 Apr 2022 17:21:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] ARM: vexpress/spc: Fix doxygen comments
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        kernel test robot <lkp@intel.com>
References: <20220404130207.1162445-1-sudeep.holla@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220404130207.1162445-1-sudeep.holla@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/4/22 06:02, Sudeep Holla wrote:
> Kbuild bot reported the following doxygen build warning:
> 
>   |  arch/arm/mach-versatile/spc.c:231: warning: This comment starts with
>   |		'/**', but isn't a kernel-doc comment.
>   |		Refer Documentation/doc-guide/kernel-doc.rst
>   |  		* ve_spc_cpu_in_wfi(u32 cpu, u32 cluster)
> 
> Fix the issue by dropping the parameters specified in the kernel doc.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-doc/202204031026.4ogKxt89-lkp@intel.com
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/mach-vexpress/spc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
> index 1c6500c4e6a1..8f99d47d4b89 100644
> --- a/arch/arm/mach-vexpress/spc.c
> +++ b/arch/arm/mach-vexpress/spc.c
> @@ -228,7 +228,7 @@ static u32 standbywfi_cpu_mask(u32 cpu, u32 cluster)
>  }
>  
>  /**
> - * ve_spc_cpu_in_wfi(u32 cpu, u32 cluster)
> + * ve_spc_cpu_in_wfi()

This line still needs a "function short description," e.g.

+ * ve_spc_cpu_in_wfi() - fooble the barfloppity

similar to what you did in patch 2/2.

>   *
>   * @cpu: mpidr[7:0] bitfield describing CPU affinity level within cluster
>   * @cluster: mpidr[15:8] bitfield describing cluster affinity level

and I would s/doxygen/kernel-doc/ for both patches.

thanks.
-- 
~Randy
