Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7E3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 06:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346117AbiFUGlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 02:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345877AbiFUGlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:41:07 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3051929A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 23:40:53 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LRxg935fCz1KC8b;
        Tue, 21 Jun 2022 14:38:45 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 14:40:50 +0800
Subject: Re: [PATCH v2 2/3] mm/swapfile: fix possible data races of
 inuse_pages
To:     Muchun Song <songmuchun@bytedance.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Qian Cai <quic_qiancai@quicinc.com>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220608144031.829-3-linmiaohe@huawei.com>
 <87edzjrcq8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <13414d6a-9e72-fb6c-f0a8-8b83ba0455de@huawei.com>
 <YrA8kxavqsDfH5R7@FVFYT0MHHV2J.usts.net>
 <09ffac27-7fe9-0977-cb33-30433e78e662@huawei.com>
 <b61771ad-9daa-741e-27e4-fdb50a7c5e38@huawei.com> <YrB6R5uHQaz1adhK@qian>
 <YrCCFwgoLKhDn7Fo@FVFYT0MHHV2J.usts.net> <YrDob8+9Xgig6mZw@qian>
 <87pmj2q0mf.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <YrE9jxTAvLjeBTiT@FVFYT0MHHV2J.usts.net>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c5bc3625-48a2-6b8d-b6f4-b3e8c18d11d7@huawei.com>
Date:   Tue, 21 Jun 2022 14:40:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YrE9jxTAvLjeBTiT@FVFYT0MHHV2J.usts.net>
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

On 2022/6/21 11:39, Muchun Song wrote:
> On Tue, Jun 21, 2022 at 09:14:00AM +0800, Huang, Ying wrote:
>> Qian Cai <quic_qiancai@quicinc.com> writes:
>>
>>> On Mon, Jun 20, 2022 at 10:20:07PM +0800, Muchun Song wrote:
>>>> The lock does not protect the read sides. So the write side should be
>>>> fixed by WRITTE_ONCE().
>>>
>>> https://lwn.net/Articles/816854/
>>>
>>> "Unmarked writes (aligned and up to word size) can be treated as if they had
>>> used WRITE_ONCE() by building with
>>> CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=y (also selected by default).
> 
> All right, CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC help us avoid KCSAN
> complaining.
> 
>>> Experience has shown that compilers are much less likely to destructively
>>> optimize in-kernel writes than reads. Some developers might therefore
>>> choose to use READ_ONCE() but omit the corresponding WRITE_ONCE(). Other
>>> developers might prefer the documentation benefits and long-term peace of
>>> mind accruing from explicit use of WRITE_ONCE()..."
>>
>> Thanks for pointing me to this great article.  So although not required
>> by KCSAN strictly, WRITE_ONCE() is still good for documentation, etc.
>> Just like we have done for swap_info_struct->highest_bit, etc.
>>
> 
> +1

I tend to agree with Muchun & Huang, Ying. Thanks all of you.

> 
>> Best Regards,
>> Huang, Ying
>>
> .
> 

