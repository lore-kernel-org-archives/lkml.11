Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78613C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 12:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348237AbiCOMZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 08:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347311AbiCOMZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:25:19 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A6D639F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:24:07 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KHss85k7bz1GCDX;
        Tue, 15 Mar 2022 20:19:08 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 20:24:05 +0800
Subject: Re: [PATCH] mm/mlock: Use vma_lookup() instead of find_vma()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220314151728.20800-1-linmiaohe@huawei.com>
 <Yi9qdrJ9AXOJszmu@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b2dc4e8a-be8f-88e4-040a-91a6d033ab6d@huawei.com>
Date:   Tue, 15 Mar 2022 20:24:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yi9qdrJ9AXOJszmu@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/15 0:16, Matthew Wilcox wrote:
> On Mon, Mar 14, 2022 at 11:17:28PM +0800, Miaohe Lin wrote:
>> Using vma_lookup() verifies the start is contained in the found vma. This
>> results in easier to read the code.
> 
> This conflicts with the maple tree.

IIUC, maple tree is the implementation detail of the vma and this patch
should not be conflict with it. But there might be some trival conflict.
Am I supposed to delay this patch until the maple tree's work is done?

Thanks.

> 
> .
> 

