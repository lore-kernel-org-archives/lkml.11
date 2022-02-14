Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F6FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 09:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343600AbiBNJxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 04:53:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245606AbiBNJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:49:57 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6597A1A8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:41:07 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jxzhl1g6kzccyW;
        Mon, 14 Feb 2022 17:39:51 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 17:40:55 +0800
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 17:40:55 +0800
Message-ID: <b6dc758b-492d-1000-24e5-643e38d3166e@huawei.com>
Date:   Mon, 14 Feb 2022 17:40:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Question about nohz and sysidle
Content-Language: en-US
From:   Yu Liao <liaoyu15@huawei.com>
CC:     <paulmck@kernel.org>, <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>
References: <b881759b-d281-fdc3-71b7-4429d84cd734@huawei.com>
To:     <frederic@kernel.org>
In-Reply-To: <b881759b-d281-fdc3-71b7-4429d84cd734@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.173]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I sent to the old email address.

On 2022/2/14 16:28, Yu Liao wrote:
> Hi Frederic,
> 
> I'm working on an issue about nohz. When NO_HZ_FULL is enabled, CPU 0 
> handles the timekeeping duty on behalf of all other CPUs, which means 
> CPU 0 never stop tick even in sysidle state. This is a powersaving issue.
> 
> I found your patchset (nohz: Support sysidle) in the below link.
> https://lore.kernel.org/all/1406569056-30217-1-git-send-email-fweisbec@gmail.com/ 
> 
> But these patches haven't been merged into mainline yet and sysidle 
> state detection has been removed by commit fe5ac724d81a (rcu: Remove 
> nohz_full full-system-idle state machine) as well.
> 
> I tried your patches and it does work, why are we no longer 
> working on stopping timekeeping duty when all full dynticks CPUs are idle?
> 
> Thanks,
> Yu
