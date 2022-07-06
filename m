Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C61C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 14:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiGFOJV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 10:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiGFOJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:09:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C049C101B;
        Wed,  6 Jul 2022 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=piwH4EuK6B8CIBnV7kfny7sAtZcwgU731fkSt6WPOoY=; b=P/xBSSG2VS+IuEtPIeDItN3f13
        bqtDGCz6eMIafEtsc3QyeeaM1q1fIS07mPhIWDJ8I+RQJj/04VSr1lVrQzR8ivMsTw511x76nENsv
        tWcqZke6ZIMR+bXEWs5SkRIVa/SD0+wOOuFYmSaw6t+KKZn+A2DF2v2pssLnmfm0qMoEaKhtrQ4bJ
        noHjc5CJ1c4HrJCIsfFqnHFA0VxxXYELNOurfOcgc1AroYloMkiZwQ3mEvmmhhkTHzwP8QdUvasXu
        qeEvoJpOG64LZOwrE8C8j74AfGDnBP/RyDBdnRCx7VbcDw95jBdGyKdBjbHK8/0Jk0LNr/0HUWfXE
        YGXQUGaA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o95i4-001hai-JC; Wed, 06 Jul 2022 14:08:56 +0000
Date:   Wed, 6 Jul 2022 15:08:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.15 v3] mm/filemap: fix UAF in find_lock_entries
Message-ID: <YsWXeLo9gXTEv3pw@casper.infradead.org>
References: <20220706074527.1406924-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706074527.1406924-1-liushixin2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 03:45:27PM +0800, Liu Shixin wrote:
>  	rcu_read_lock();
>  	while ((page = find_get_entry(&xas, end, XA_PRESENT))) {
> +		unsigned long next_idx = xas.xa_index;

It's confusing to have next_idx not be the actual next index.
That was why I made it 'xas.xa_index + 1'.  I know it's somewhat
used as an indicator that we don't need to call xas_set(), and so
it doesn't really matter, but let's say what we mean.

