Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFC6C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 21:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiF2Vjn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 17:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiF2Vjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:39:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E9D34676
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:39:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E12BB82759
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 21:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41930C341C8;
        Wed, 29 Jun 2022 21:39:36 +0000 (UTC)
Date:   Wed, 29 Jun 2022 22:39:33 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     yee.lee@mediatek.com
Cc:     linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KFENCE" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 1/1] mm: kfence: apply kmemleak_ignore_phys on early
 allocated pool
Message-ID: <YrzGlSUtnXuiuUEK@arm.com>
References: <20220628113714.7792-1-yee.lee@mediatek.com>
 <20220628113714.7792-2-yee.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628113714.7792-2-yee.lee@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 07:37:11PM +0800, yee.lee@mediatek.com wrote:
> From: Yee Lee <yee.lee@mediatek.com>
> 
> This patch solves two issues.
> 
> (1) The pool allocated by memblock needs to unregister from
> kmemleak scanning. Apply kmemleak_ignore_phys to replace the
> original kmemleak_free as its address now is stored in the phys tree.
> 
> (2) The pool late allocated by page-alloc doesn't need to unregister.
> Move out the freeing operation from its call path.
> 
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Yee Lee <yee.lee@mediatek.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
