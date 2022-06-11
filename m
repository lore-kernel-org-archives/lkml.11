Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED127C43334
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jun 2022 09:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiFKJru (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jun 2022 05:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiFKJrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 05:47:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8A35623B
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 02:47:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A8EA60B6E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 09:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B818FC34116;
        Sat, 11 Jun 2022 09:47:44 +0000 (UTC)
Date:   Sat, 11 Jun 2022 10:47:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yee.lee@mediatek.com
Subject: Re: [PATCH v4 1/4] mm: kmemleak: remove kmemleak_not_leak_phys() and
 the min_count argument to kmemleak_alloc_phys()
Message-ID: <YqRkvdkBiWjf0VLE@arm.com>
References: <20220611035551.1823303-1-patrick.wang.shcn@gmail.com>
 <20220611035551.1823303-2-patrick.wang.shcn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611035551.1823303-2-patrick.wang.shcn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 11:55:48AM +0800, Patrick Wang wrote:
> Remove the unused kmemleak_not_leak_phys() function.
> And remove the min_count argument to kmemleak_alloc_phys()
> function, assume it's 0.
> 
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
