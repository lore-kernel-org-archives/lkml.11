Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9117C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 01:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbiEJBUH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 21:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiEJBUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 21:20:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D384BB87;
        Mon,  9 May 2022 18:16:04 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ky0Qx6h0WzGpgM;
        Tue, 10 May 2022 09:13:13 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 09:15:59 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 09:15:59 +0800
Subject: Re: [PATCH] net: stmmac: fix missing pci_disable_device() on error in
 stmmac_pci_probe()
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <netdev@vger.kernel.org>, <peppe.cavallaro@st.com>,
        <alexandre.torgue@foss.st.com>, <davem@davemloft.net>,
        <edumazet@google.com>
References: <20220506094039.3629649-1-yangyingliang@huawei.com>
 <20220509155525.26e053db@kernel.org>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <e54d585b-3295-127e-0a49-08293eaed2ed@huawei.com>
Date:   Tue, 10 May 2022 09:15:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220509155525.26e053db@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/5/10 6:55, Jakub Kicinski wrote:
> On Fri, 6 May 2022 17:40:39 +0800 Yang Yingliang wrote:
>> Fix the missing pci_disable_device() before return
>> from stmmac_pci_probe() in the error handling case.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Here indeed pcim_enable_device() seems like a better fit.
OK, I will send a v2 later.

Thanks,
Yang
> .
