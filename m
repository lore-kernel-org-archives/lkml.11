Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2CBC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jun 2022 09:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiFKJqW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jun 2022 05:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiFKJqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 05:46:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A37A1EC43
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 02:46:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BE8F60B15
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 09:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F74C34116;
        Sat, 11 Jun 2022 09:46:13 +0000 (UTC)
Date:   Sat, 11 Jun 2022 10:46:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yee.lee@mediatek.com
Subject: Re: [PATCH v3 3/3] mm: kmemleak: check physical address when scan
Message-ID: <YqRkYtT+Z1r2Y76s@arm.com>
References: <20220609124950.1694394-1-patrick.wang.shcn@gmail.com>
 <20220609124950.1694394-4-patrick.wang.shcn@gmail.com>
 <YqI44Q20oJNVl+QV@arm.com>
 <957f5626-2c89-f53a-2156-bbde2bb545f2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <957f5626-2c89-f53a-2156-bbde2bb545f2@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 11:46:27AM +0800, Patrick Wang wrote:
> I've received an auto build test WARNING from kernel test robot:
> 
>    mm/kmemleak.c: In function 'scan_object':
>   >> arch/powerpc/include/asm/page.h:215:42: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>        215 | #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) + VIRT_PHYS_OFFSET))
>            |                                          ^
>      mm/kmemleak.c:1403:19: note: in expansion of macro '__va'
>       1403 |                   __va((void *)object->pointer) :
>            |                   ^~~~

Ah, yes, arm32 has the same issue with phys_addr_t defined as u64 in
some configurations while long is 32-bit.

> So I will replace __va((void *)object->pointer)
> to __va((phys_addr_t)object->pointer) for fixing this warning,

It makes sense.

-- 
Catalin
