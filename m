Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D50C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 06:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343554AbiDZHBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 03:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343548AbiDZHBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:01:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2545E75C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:58:29 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KnXfW49PfzCsR9;
        Tue, 26 Apr 2022 14:53:55 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 14:58:26 +0800
Subject: Re: [PATCH v3 3/6] mm/vmscan: activate swap-backed executable folios
 after first usage
To:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <iamjoonsoo.kim@lge.com>, <hch@lst.de>, <osalvador@suse.de>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220425111232.23182-1-linmiaohe@huawei.com>
 <20220425111232.23182-4-linmiaohe@huawei.com>
 <20220425140711.0c1898862fc817135bbbc56e@linux-foundation.org>
 <6b74e6f3799032d4f12bae0d97a453dc85d03028.camel@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5a108252-4eb8-e353-da3d-a96b8799fadf@huawei.com>
Date:   Tue, 26 Apr 2022 14:58:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <6b74e6f3799032d4f12bae0d97a453dc85d03028.camel@intel.com>
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

On 2022/4/26 10:02, ying.huang@intel.com wrote:
> On Mon, 2022-04-25 at 14:07 -0700, Andrew Morton wrote:
>> On Mon, 25 Apr 2022 19:12:29 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>>> We should activate swap-backed executable folios (e.g. tmpfs) after first
>>> usage so that executable code gets yet better chance to stay in memory.
>>
>> Does this not erase the intended effect of Joonsoo's b518154e59a
>> ("mm/vmscan: protect the workingset on anonymous LRU")?
> 
> I don't think so.  This is only for executable folios (vm_flags &
> VM_EXEC).  The behavior for all other anonymous pages are not affected.
> 

Agree. Only executable folios are changed! Thanks both!

> Best Regards,
> Huang, Ying
> 
> .
> 

