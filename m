Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CEDC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 21:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiCYVtg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 17:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbiCYVte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 17:49:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8402072E2B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 14:47:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 442D4B829BA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 21:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DDEC2BBE4;
        Fri, 25 Mar 2022 21:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648244876;
        bh=h69lJXxPvdDbpf3yxkrVDt5yfQsu4aPDbdi8wU3rEIU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lOelYMROko3tudh2p6g2zXIfc3GhY2JxOsoAHFD8KYilnjCUi5JZ5NuUVN6j6VbIJ
         3BlqYOxuKldnpTzj0zjZd7uzoloHcI9DmdiMmXU/u8CaCP7W3O38Jl88v7bEonpFjY
         N+XJo9SLXcdlTQnpi4s2Irp/kkdbr7PTJ6+014BE=
Date:   Fri, 25 Mar 2022 14:47:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     xkernel.wang@foxmail.com
Cc:     glider@google.com, andreyknvl@gmail.com, elver@google.com,
        dvyukov@google.com, ryabinin.a.a@gmail.com,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/test_meminit: optimize
 do_kmem_cache_rcu_persistent() test
Message-Id: <20220325144755.c0a92c6fd934b4cb98c41c16@linux-foundation.org>
In-Reply-To: <tencent_7CB95F1C3914BCE1CA4A61FF7C20E7CCB108@qq.com>
References: <tencent_7CB95F1C3914BCE1CA4A61FF7C20E7CCB108@qq.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2022 11:48:24 +0800 xkernel.wang@foxmail.com wrote:

> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> To make the test more robust, there are the following changes:
> 1. add a check for the return value of kmem_cache_alloc().
> 2. properly release the object `buf` on several error paths.
> 3. release the objects of `used_objects` if we never hit `saved_ptr`.
> 4. destroy the created cache by default.
> 
> ...
>
> --- a/lib/test_meminit.c
> +++ b/lib/test_meminit.c
> @@ -300,13 +300,18 @@ static int __init do_kmem_cache_rcu_persistent(int size, int *total_failures)
>  	c = kmem_cache_create("test_cache", size, size, SLAB_TYPESAFE_BY_RCU,
>  			      NULL);
>  	buf = kmem_cache_alloc(c, GFP_KERNEL);
> +	if (!buf)
> +		goto out;

OK, Normally we don't bother checking allocation success in __init
code, but this test can run via modprobe, so I guess checking is the
right thing to do.

