Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B10C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 03:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379885AbiFQDAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 23:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbiFQDAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 23:00:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC256620C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 20:00:46 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LPNxd0nk6zSgxd;
        Fri, 17 Jun 2022 10:57:25 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 11:00:44 +0800
Subject: Re: [PATCH v2 0/3] A few cleanup and fixup patches for swap
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Huang Ying <ying.huang@intel.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220608144031.829-1-linmiaohe@huawei.com>
 <20220616193713.7ca68b49a0dabc749c495a0f@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8884b075-aa73-a77f-884e-2dcda0f83a25@huawei.com>
Date:   Fri, 17 Jun 2022 11:00:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220616193713.7ca68b49a0dabc749c495a0f@linux-foundation.org>
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

On 2022/6/17 10:37, Andrew Morton wrote:
> On Wed, 8 Jun 2022 22:40:28 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> This series contains a cleaup patch to remove unneeded swap_cache_info
>> statistics, and two bugfix patches to avoid possible data races of
>> inuse_pages and so on. More details can be found in the respective
>> changelogs. 
> 
> It would be nice to get [1/3] reviewed please.

I'd like too.

Hi David & Hugh & Huang, Ying,
It's very kind of you if you can help review this patch!

Thanks!

BTW: It should be convenient if there are mm/swap reviewers. ;)

> 
> 
> .
> 

