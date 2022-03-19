Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD02FC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Mar 2022 03:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbiCSDdk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 23:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239260AbiCSDdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 23:33:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A4E269345;
        Fri, 18 Mar 2022 20:32:13 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KL5xY2ZyMzfYls;
        Sat, 19 Mar 2022 11:30:41 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 19 Mar 2022 11:32:10 +0800
Subject: Re: [PATCH net-next v2 1/3] net: ipvlan: fix potential UAF problem
 for phy_dev
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <edumazet@google.com>, <sakiwit@gmail.com>,
        <sainath.grandhi@intel.com>, <maheshb@google.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1647568181.git.william.xuanziyang@huawei.com>
 <83116bde1ddf39420e24466684c9488bff46f43c.1647568181.git.william.xuanziyang@huawei.com>
 <20220318105311.21ca32bd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <0561bc6a-00f5-8fb1-80ae-fcbba3af0d1a@huawei.com>
Date:   Sat, 19 Mar 2022 11:32:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20220318105311.21ca32bd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 18 Mar 2022 09:57:47 +0800 Ziyang Xuan wrote:
>> Add the reference operation to phy_dev of ipvlan to avoid
>> the potential UAF problem under the following known scenario:
>>
>> Someone module puts the NETDEV_UNREGISTER event handler to a
>> work, and phy_dev is accessed in the work handler. But when
>> the work is excuted, phy_dev has been destroyed because upper
>> ipvlan did not get reference to phy_dev correctly.
>>
>> That likes as the scenario occurred by
>> commit 563bcbae3ba2 ("net: vlan: fix a UAF in vlan_dev_real_dev()").
> 
> There is no equivalent of vlan_dev_real_dev() for ipvlan, AFAICT.
> The definition of struct ipvl_dev is private to the driver. I don't 
> see how a UAF can happen here.
> 
> You should either clearly explain how the bug could happen or clearly
> state that there is no possibility of the bug for this driver, and the
> patch is just future proofing.
> 
> If the latter is the case we should drop the Fixes tag and prevent this
> patch from getting backported into stable.
> 

It is to prevent ipvlan from occurring the similar problem in the future.
For now, there is not way to access phy_dev outside ipvlan module as vlan
real_dev using vlan_dev_real_dev(). I will make this clear.

I think it is necessary to protect lower netdevice using the feature of
netdevice refcnt. So I do it.

Thank you for your valuable opinions! I believe I can do more and more better
with your help.

>> Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> .
> 
