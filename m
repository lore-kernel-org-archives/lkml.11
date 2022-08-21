Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6653DC32789
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Aug 2022 06:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiHUG5i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Aug 2022 02:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUG5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 02:57:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDDD1D32B
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 23:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tbA8GPJvpZPjyT8xHzEYgyx5w9Okhk3popffrDAY7oI=; b=YQLHw+2HeEkLn1TFXnAvnkNWuQ
        CMyJ6wld0ZyFCBh86KeBcBe+lLp2TWnlT6BiMubAZLJ0ABQA26Nhcz7LIp4ysQytdifnmFp/uPWab
        majGosilWVAwMpzMrnkoxMRXSsB1DVftzKSWOvBM/sna7VtHeYFEGArhRaH/wJyqe0nMdgy0L0Ha6
        QtYT1Xby+15OePctot8MDtVp27E8nBpwmzewLKX6qX2Yz2Aadsae2jvS+LFIsaFbdRkntWv6B4g0Y
        ouqQQjGQb4h7XHQHzTsUbVEvMjB0sdNSsziNUhkgiYus8hjbVwXhS9jOvm5AH0kqlhBikY4I458hD
        0K1JB16A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oPetl-0071xF-ID; Sun, 21 Aug 2022 06:57:30 +0000
Date:   Sat, 20 Aug 2022 23:57:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 03/11] mm: ioremap: allow ARCH to have its own ioremap
 definition
Message-ID: <YwHXWdycBZr+bluG@infradead.org>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820003125.353570-4-bhe@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 08:31:17AM +0800, Baoquan He wrote:
> Architectures like xtensa, arc, can be converted to GENERIC_IOREMAP,
> to take standard ioremap_prot() and ioremap_xxx() way. But they have
> ARCH specific handling for ioremap() method, than standard ioremap()
> method.

Do they?

For arc, the arc_uncached_addr_space case can be easily handled by
arch_ioremap, and the xtensa case looks very similar to that.

I'd really like to kill off arch definitions of ioremap going
forward, as they should just be a special case of ioremap_prot
by definition.
