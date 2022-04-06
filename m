Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899DBC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 16:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbiDFQ0z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbiDFQ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:26:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DBE3571FC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 19:21:40 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KY7Vw221yzDqMK;
        Wed,  6 Apr 2022 10:19:20 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 10:21:38 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 10:21:35 +0800
Message-ID: <70443d0a-51ea-6c44-5a99-784516aed68c@huawei.com>
Date:   Wed, 6 Apr 2022 10:21:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 1/2] Revert "powerpc: Set max_mapnr correctly"
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "songyuanzheng@huawei.com" <songyuanzheng@huawei.com>
References: <20220216121109.157605-1-wangkefeng.wang@huawei.com>
 <b2ff771c-01ef-3f14-f22d-9248735fdc77@huawei.com>
 <de3e12e2-6dff-90cd-3f47-fe8deaae1fa8@csgroup.eu>
 <0c6e13cc-f768-2cb4-0aa3-cd090b99fc8f@huawei.com>
 <877d8581y8.fsf@mpe.ellerman.id.au>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <877d8581y8.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/4 20:31, Michael Ellerman wrote:
> Kefeng Wang <wangkefeng.wang@huawei.com> writes:
>> On 2022/3/28 22:12, Christophe Leroy wrote:
>>> Hi,
>>>
>>> Le 26/03/2022 à 08:55, Kefeng Wang a écrit :
>>>> Hi maintainers，
>>>>
>>>> I saw the patches has been reviewed[1], could they be merged?
>>> Thinking about it once more, I think the patches should go in reverse
>>> order. Patch 2 should go first and patch 1 should go after.
>>>
>>> Otherwise, once patch 1 is applied and patch 2 is not applied yet,
>>> virt_addr_valid() doesn't work anymore.
>> Should I resend them or could the maintainer reverse order when merging
>> them?
> I'll reverse them. I've found some breakage in other code while testing
> this, so I'll fix that up first before merging these.
Thanks.
>
> In patch 2 you didn't say what hardware you hit this on, what CPU does
> your system have?

CPU e5500  from fsl,P5040DS.

>
> cheers
> .
