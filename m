Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6506BC0502E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 01:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiH2B0w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Aug 2022 21:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiH2B0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 21:26:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFBF2A962;
        Sun, 28 Aug 2022 18:26:49 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MGCPC4MrbzkWh6;
        Mon, 29 Aug 2022 09:23:11 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 09:26:47 +0800
Message-ID: <59402dc4-ee21-940e-ea24-0bffdbed8d48@huawei.com>
Date:   Mon, 29 Aug 2022 09:26:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next] net: sched: red: remove unused input parameter
 in red_get_flags()
To:     Cong Wang <xiyou.wangcong@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <jhs@mojatatu.com>, <jiri@resnulli.us>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>
References: <20220827043545.248535-1-shaozhengchao@huawei.com>
 <Ywpmky1B0oh+KQgU@pop-os.localdomain>
From:   shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <Ywpmky1B0oh+KQgU@pop-os.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/28 2:46, Cong Wang wrote:
> On Sat, Aug 27, 2022 at 12:35:45PM +0800, Zhengchao Shao wrote:
>> The input parameter supported_mask is unused in red_get_flags().
>> Remove it.
>>
> 
> It looks like this is incomplete code unification of the following
> commit:
> 
> commit 14bc175d9c885c86239de3d730eea85ad67bfe7b
> Author: Petr Machata <petrm@mellanox.com>
> Date:   Fri Mar 13 01:10:56 2020 +0200
> 
>      net: sched: Allow extending set of supported RED flags
> 
> How about completing it? ;)
> 
> Thanks.

Hi Wang：
	Thank you for your reply. Your suggestion is good. I will try to 
complete it later.

Zhengchao Shao
