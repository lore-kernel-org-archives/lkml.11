Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D93C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 02:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbiC3CEi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 22:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbiC3CEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:04:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F67B820C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:02:51 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KSqRB6TCdzfZMV;
        Wed, 30 Mar 2022 10:01:10 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 10:02:48 +0800
Subject: Re: [PATCH 3/8] mm/vmscan: introduce helper function
 reclaim_page_list()
To:     Christoph Hellwig <hch@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220329132619.18689-1-linmiaohe@huawei.com>
 <20220329132619.18689-4-linmiaohe@huawei.com>
 <YkMQ/RX8dWxoeCi4@infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f4c4dc9f-5726-8107-77cb-bdd0c4b2ddf2@huawei.com>
Date:   Wed, 30 Mar 2022 10:02:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YkMQ/RX8dWxoeCi4@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/29 22:00, Christoph Hellwig wrote:
>> +static inline unsigned int reclaim_page_list(struct list_head *page_list, struct pglist_data *pgdat)
> 
> This is completely unreadable with the crazy long lines.

Will break this long lines.

> 
> Also why would you force inline this?

It seems inline is indeed not needed. Will change this too.

> .
> 

Many thanks for your comment.
