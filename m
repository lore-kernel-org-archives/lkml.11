Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C262C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 10:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiFXKSz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 06:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFXKSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:18:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8F44DF6E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:18:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4360B827F9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0B7C34114;
        Fri, 24 Jun 2022 10:18:47 +0000 (UTC)
Date:   Fri, 24 Jun 2022 11:18:43 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yee Lee <yee.lee@mediatek.com>
Cc:     Patrick Wang <patrick.wang.shcn@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>
Subject: Re: [PATCH v4 3/4] mm: kmemleak: add rbtree and store physical
 address for objects allocated with PA
Message-ID: <YrWPg3xIHbm9bFxP@arm.com>
References: <20220611035551.1823303-1-patrick.wang.shcn@gmail.com>
 <20220611035551.1823303-4-patrick.wang.shcn@gmail.com>
 <09d9066b3e55966c108670219711482791d38880.camel@mediatek.com>
 <10660122efb538669144e4c46558b83400125d79.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10660122efb538669144e4c46558b83400125d79.camel@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 07:25:15PM +0800, Yee Lee wrote:
> On Thu, 2022-06-23 at 16:45 +0800, Yee Lee wrote:
> > Now we have seperated rb_tree for phys and virts addresses. But why
> > can't we have kmemleak_free_phys()? It may apply the same format to
> > delete_object_full(). 
> > 
> > Some users would request to remove the kmemleak object from the phys
> > tree but we don't have this one.
> 
> Please check this, an issue happened at kfence with the latest kmemleak
> patches. kfence pool allocated memory from memblock but have no way to
> free it from the phys tree.
> https://lkml.org/lkml/2022/6/23/486

I don't think I was cc'ed on the other thread but at a quick look, what
you probably want is:

	kmemleak_ignore_phys(__kfence_pool);

instead of the current kmemleak_free(). With Patrick's changes, you can
no longer tell kmemleak about an object with a physical address and free
it with the virtual one.

-- 
Catalin
