Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944B3CCA47C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Jul 2022 01:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiGGBZw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 21:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbiGGBZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:25:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFA82E6BA;
        Wed,  6 Jul 2022 18:25:49 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lddvs22zVzhYst;
        Thu,  7 Jul 2022 09:23:21 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Jul 2022 09:25:37 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Jul 2022 09:25:36 +0800
Subject: Re: [PATCH 5.15 v3] mm/filemap: fix UAF in find_lock_entries
To:     Matthew Wilcox <willy@infradead.org>
References: <20220706074527.1406924-1-liushixin2@huawei.com>
 <YsWXeLo9gXTEv3pw@casper.infradead.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <536cb9e4-983d-80db-6590-44ae7fc02415@huawei.com>
Date:   Thu, 7 Jul 2022 09:25:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YsWXeLo9gXTEv3pw@casper.infradead.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/6 22:08, Matthew Wilcox wrote:
> On Wed, Jul 06, 2022 at 03:45:27PM +0800, Liu Shixin wrote:
>>  	rcu_read_lock();
>>  	while ((page = find_get_entry(&xas, end, XA_PRESENT))) {
>> +		unsigned long next_idx = xas.xa_index;
> It's confusing to have next_idx not be the actual next index.
> That was why I made it 'xas.xa_index + 1'.  I know it's somewhat
> used as an indicator that we don't need to call xas_set(), and so
> it doesn't really matter, but let's say what we mean.
I'll modify it and resend again, thanks.
>
>
> .
>

