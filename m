Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F047EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 07:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbiESHyH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 03:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiESHyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:54:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8499E33A29;
        Thu, 19 May 2022 00:54:00 -0700 (PDT)
Received: from kwepemi100022.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L3hsc1550z1JCBr;
        Thu, 19 May 2022 15:52:36 +0800 (CST)
Received: from kwepemm600018.china.huawei.com (7.193.23.140) by
 kwepemi100022.china.huawei.com (7.221.188.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 15:53:58 +0800
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemm600018.china.huawei.com (7.193.23.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 15:53:57 +0800
Message-ID: <4aa8c53d-fe4e-e34f-5843-359c331e680e@huawei.com>
Date:   Thu, 19 May 2022 15:53:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 -next] docs/zh_CN: Add
 dev-tools/gdb-kernel-debugging.rst Chinese translation
To:     Jonathan Corbet <corbet@lwn.net>, <alexs@kernel.org>
CC:     <siyanteng01@gmail.com>, <bobwxc@email.cn>, <src.res@email.cn>,
        <wanjiabing@vivo.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220513061035.605-1-gaochao49@huawei.com>
 <20220514100046.1683-1-gaochao49@huawei.com> <87lev0ueuz.fsf@meer.lwn.net>
From:   "gaochao (L)" <gaochao49@huawei.com>
In-Reply-To: <87lev0ueuz.fsf@meer.lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600018.china.huawei.com (7.193.23.140)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,
I'll make sure that in future patches

在 2022/5/18 3:40, Jonathan Corbet 写道:
> gaochao <gaochao49@huawei.com> writes:
> 
>> Translate dev-tools/gdb-kernel-debugging.rst into Chinese.
> 
> I've applied this, but one potential concern:
> 
>> Signed-off-by: gaochao <gaochao49@huawei.com>
>> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
>> Reviewed-by: Wu XiangCheng <bobwxc@email.cn>
> 
> When you posted this, XiangCheng's Reviewed-by had not been seen in any
> public place.  It was later offered, so no harm done here, but please be
> sure not to add such tags unless they have been explicitly given to you.
> 
> Thanks,
> 
> jon
> .
