Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E926C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jun 2022 14:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236789AbiFKO4h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jun 2022 10:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbiFKO4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 10:56:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145BDB481
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 07:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EesJp6Q28Dva5LrN482KPkK1Tg2M3LLR40lrcCvgAAk=; b=WMGh50naDvnyC2S29Ju83tWUBS
        aEzMG9CJXl92X/gsKJ/OXv7EBMXs63k3gZkWiwavEUQAP2d24xo6/D3ReKv2dcJoMSMxQgQs+o0LD
        AILEIcXZRk1OZZZw2FukdV8MKv4UyBBjUXFoW3RBMqmC+Q3b4nP5ENAHg8qq9fTf1U0atiy33QZTm
        j6nsvfemD/IEUDObGwdIh5j8vLWLZTf9S0c/6EF7pqWiZLOZYVWBkO1+0QlkTk1g4HZeuC5Rv/uvi
        dSQex/M7UvtgSHsmkF0kYUapzwb+n+/qldIAldWSIhK0aQFSDCBn+0iJzhT3zhgmBD2f1436NUzR+
        WW10RAjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o02X8-00FJxM-7v; Sat, 11 Jun 2022 14:56:14 +0000
Date:   Sat, 11 Jun 2022 15:56:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        shameerali.kolothum.thodi@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix is_pinnable_page return value
Message-ID: <YqStDm5sdDL6YXn8@casper.infradead.org>
References: <20220611133442.15290-1-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611133442.15290-1-zhangfei.gao@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 09:34:42PM +0800, Zhangfei Gao wrote:
> Commit 1c563432588d ("mm: fix is_pinnable_page against a cma page")
> Changes from
> return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
>         is_zero_pfn(page_to_pfn(page));
> to
> return !(is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page)));

Mailing lists can be read as well as written.

https://lore.kernel.org/linux-mm/165490039431.944052.12458624139225785964.stgit@omen/
