Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74199C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 02:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiCaCa3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 22:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiCaCaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:30:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A6D13DFC;
        Wed, 30 Mar 2022 19:28:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31C7BB81E87;
        Thu, 31 Mar 2022 02:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7637EC340F0;
        Thu, 31 Mar 2022 02:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648693709;
        bh=+adBEntIzSSCVYqEhFC0POeZQwSN/e4WeFGSC39cYN0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EcssqheLZ56lijPSSHBApcxEaeL+Lmoj5IBhJoTd7QNYuZPZuSuA/3LYmjVFeQhb0
         J1syqwcskBuQ0fhmx0C2KAj1OIE8NRR1bBLk599P3q83/j0nJjxapeSy7J2GGPgTPE
         dJUkmRKtvEOQS/V13ifwMGLP5tMhovnjLpD7laGY=
Date:   Wed, 30 Mar 2022 19:28:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v6 1/4] mm: hugetlb_vmemmap: introduce
 STRUCT_PAGE_SIZE_IS_POWER_OF_2
Message-Id: <20220330192827.4b95e3d7fb149ef9cc687ccb@linux-foundation.org>
In-Reply-To: <20220330153745.20465-2-songmuchun@bytedance.com>
References: <20220330153745.20465-1-songmuchun@bytedance.com>
        <20220330153745.20465-2-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 23:37:42 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> If the size of "struct page" is not the power of two and this
> feature is enabled,

What is "this feature"?   Let's spell it out?

> then the vmemmap pages of HugeTLB will be
> corrupted after remapping (panic is about to happen in theory).
> But this only exists when !CONFIG_MEMCG && !CONFIG_SLUB on
> x86_64.  However, it is not a conventional configuration nowadays.
> So it is not a real word issue, just the result of a code review.
> But we have to prevent anyone from configuring that combined
> configuration.  In order to avoid many checks like "is_power_of_2
> (sizeof(struct page))" through mm/hugetlb_vmemmap.c.  Introduce
> STRUCT_PAGE_SIZE_IS_POWER_OF_2 to detect if the size of struct
> page is power of 2 and make this feature depends on this new
> macro.  Then we could prevent anyone do any unexpected
> configuration.
> 
> ...
>
> --- /dev/null
> +++ b/mm/struct_page_size.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generate definitions needed by the preprocessor.
> + * This code generates raw asm output which is post-processed
> + * to extract and format the required data.
> + */
> +
> +#define __GENERATING_STRUCT_PAGE_SIZE_IS_POWER_OF_2_H
> +/* Include headers that define the enum constants of interest */
> +#include <linux/mm_types.h>
> +#include <linux/kbuild.h>
> +#include <linux/log2.h>
> +
> +int main(void)
> +{
> +	if (is_power_of_2(sizeof(struct page)))
> +		DEFINE(STRUCT_PAGE_SIZE_IS_POWER_OF_2, is_power_of_2(sizeof(struct page)));

Why not

	DEFINE(STRUCT_PAGE_SIZE_IS_POWER_OF_2, 1);

?

> +	return 0;
> +}
> -- 
> 2.11.0
