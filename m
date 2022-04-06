Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C0CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 13:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbiDFOBV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 10:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiDFOBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:01:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1532414EE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:17:53 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KYJlq3rpHzgYSy;
        Wed,  6 Apr 2022 17:16:07 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 17:17:51 +0800
Subject: Re: [PATCH] mm/mlock: remove unneeded start >= vma->vm_end check
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <hughd@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220314153223.53753-1-linmiaohe@huawei.com>
 <Yi9qq9hVloDXcW4b@casper.infradead.org>
 <c0ff39e2-27fc-170f-00f5-d5e9ab5a22cd@huawei.com>
Message-ID: <58fcd181-cadb-1e61-fc18-9994b93bb1bc@huawei.com>
Date:   Wed, 6 Apr 2022 17:17:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <c0ff39e2-27fc-170f-00f5-d5e9ab5a22cd@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/15 20:30, Miaohe Lin wrote:
> On 2022/3/15 0:17, Matthew Wilcox wrote:
>> On Mon, Mar 14, 2022 at 11:32:23PM +0800, Miaohe Lin wrote:
>>> If find_vma returns a vma, it must satisfies that start < vma->vm_end.
>>> Since vma list is sorted in the ascending order, so we will never see
>>> start >= vma->vm_end here. Remove this unneeded check.
>>
>> faulty logic; vm_start + len might wrap.

What do you mean is vm_start + len might wrap, so vm_end might be < vm_start ?
If so, this could not happen as get_unmapped_area guarantees this.

> 
> Many thanks for comment. I agree with you about "vm_start + len" might wrap.
> But what I mean here is that we will never see "start" >= vma->vm_end here
> as find_vma guarantees this. And I leave the "start + len <=  vma->vm_start"
> check untouched. So my cleanup should be right. Or am I miss something?

So I think this "start >= vma->vm_end" check is unneeded and we can remove it.
Or am I miss something?

Many thanks!

> 
> Thanks.
> 
>>
>> .
>>
> 

