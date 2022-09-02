Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50A9C38145
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 01:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiIBBMi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 21:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiIBBMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:12:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176F5A061D;
        Thu,  1 Sep 2022 18:12:35 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MJft00HCTzYcmw;
        Fri,  2 Sep 2022 09:08:08 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 2 Sep 2022 09:12:20 +0800
Subject: Re: [PATCH next-next 0/2] net: vlan: two small refactors to make code
 more concise
To:     Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <morbo@google.com>,
        <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <cover.1661916732.git.william.xuanziyang@huawei.com>
 <306bd3cb986764e60f7ac21809ab68094b2e3325.camel@redhat.com>
From:   "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <74d89f90-c717-2a72-b16b-812c1af1d6d2@huawei.com>
Date:   Fri, 2 Sep 2022 09:12:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <306bd3cb986764e60f7ac21809ab68094b2e3325.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/1 21:28, Paolo Abeni 写道:
> Hello,
> 
> On Wed, 2022-08-31 at 12:09 +0800, Ziyang Xuan wrote:
>> Give two small refactors to make code more concise.
>>
>> Ziyang Xuan (2):
>>   net: vlan: remove unnecessary err variable in vlan_init_net()
>>   net: vlan: reduce indentation level in __vlan_find_dev_deep_rcu()
>>
>>  net/8021q/vlan.c      |  5 +----
>>  net/8021q/vlan_core.c | 22 +++++++++-------------
>>  2 files changed, 10 insertions(+), 17 deletions(-)
> 
> The patches look correct to me, but I think is better to defer this
> kind of nun-functional refactors to some work actually doing new stuff,
> to avoid unneeded noise.
> 
> Note that I merged a few other clean-up recently, but e.g. they at
> least formally removed some unneeded branch.
> 
> Sorry, I'm not going to apply this series.

No problem, I will try to dig deeper.

> 
> Cheers,
> 
> Paolo
> 
> .
> 
