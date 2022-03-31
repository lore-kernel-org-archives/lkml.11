Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1290BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 01:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352372AbiCaBwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350934AbiCaBw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 21:52:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7FF48E76
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 18:50:38 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KTR8B6cWNz1GD0d;
        Thu, 31 Mar 2022 09:50:18 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 31 Mar 2022 09:50:36 +0800
Subject: Re: [PATCH] mm/mlock: remove unneeded start >= vma->vm_end check
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <hughd@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220314153223.53753-1-linmiaohe@huawei.com>
 <Yi9qq9hVloDXcW4b@casper.infradead.org>
 <c0ff39e2-27fc-170f-00f5-d5e9ab5a22cd@huawei.com>
Message-ID: <602a1658-9b29-1752-d5a0-c5dd338fcc4c@huawei.com>
Date:   Thu, 31 Mar 2022 09:50:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <c0ff39e2-27fc-170f-00f5-d5e9ab5a22cd@huawei.com>
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

On 2022/3/15 20:30, Miaohe Lin wrote:
> On 2022/3/15 0:17, Matthew Wilcox wrote:
>> On Mon, Mar 14, 2022 at 11:32:23PM +0800, Miaohe Lin wrote:
>>> If find_vma returns a vma, it must satisfies that start < vma->vm_end.
>>> Since vma list is sorted in the ascending order, so we will never see
>>> start >= vma->vm_end here. Remove this unneeded check.
>>
>> faulty logic; vm_start + len might wrap.
> 
> Many thanks for comment. I agree with you about "vm_start + len" might wrap.
> But what I mean here is that we will never see "start" >= vma->vm_end here
> as find_vma guarantees this. And I leave the "start + len <=  vma->vm_start"
> check untouched. So my cleanup should be right. Or am I miss something?
> 

friendly ping. :)

> Thanks.
> 
>>
>> .
>>
> 

