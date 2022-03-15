Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF44C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 12:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348384AbiCOMlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 08:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347660AbiCOMlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:41:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC18753738
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mbmH2/7iNqchy9xJr/7G1YcqvwOThvxqhQn1/DEFSlE=; b=fb4nEVRI3OY3KyUSB+B/+w82GB
        SnIMMtWyQEDc8aEqtn3K20stkh+AR9IlNMrcDm5xKDCF6qPBWhngNBsxnM6aK1XmoEBU829rUOkSC
        1ab2QGIqX/aFK0ohpnf88gGX8rczRBTQomn+H7nv62FDjiMCMXjPYI8iMgDQvDJO/vkZ6pCu2XGPj
        h3Lfod+h+kI4egwwUeUf1VHYZSHk+vZYI4P0/Ezd7hi1/jCA58noAdDoKDeGxCyWy1gyeOwIuLoxH
        n79RfdFb4Y2n4Pf40pKfsWvv4x1lnanmJ+aBaKRaPcNeBElls/LqLvk6V22AucYOrkhhgHUxVCYsf
        8MLO4/PQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nU6Sx-00529D-Bj; Tue, 15 Mar 2022 12:39:55 +0000
Date:   Tue, 15 Mar 2022 12:39:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, hughd@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mlock: Use vma_lookup() instead of find_vma()
Message-ID: <YjCJG2m84NSFrsHr@casper.infradead.org>
References: <20220314151728.20800-1-linmiaohe@huawei.com>
 <Yi9qdrJ9AXOJszmu@casper.infradead.org>
 <b2dc4e8a-be8f-88e4-040a-91a6d033ab6d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2dc4e8a-be8f-88e4-040a-91a6d033ab6d@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 08:24:04PM +0800, Miaohe Lin wrote:
> On 2022/3/15 0:16, Matthew Wilcox wrote:
> > On Mon, Mar 14, 2022 at 11:17:28PM +0800, Miaohe Lin wrote:
> >> Using vma_lookup() verifies the start is contained in the found vma. This
> >> results in easier to read the code.
> > 
> > This conflicts with the maple tree.
> 
> IIUC, maple tree is the implementation detail of the vma and this patch
> should not be conflict with it. But there might be some trival conflict.
> Am I supposed to delay this patch until the maple tree's work is done?

This function is rewritten as part of the maple tree patchset.
There's no point in merging it now, or later.
