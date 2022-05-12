Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F39CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 03:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244910AbiELDHI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 23:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244837AbiELDHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:07:06 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C0538DA1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:06:57 -0700 (PDT)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KzGlg64RZzCsb7;
        Thu, 12 May 2022 11:02:07 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.125) by kwepemi500011.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 12 May
 2022 11:06:55 +0800
Message-ID: <627C79CE.3070402@hisilicon.com>
Date:   Thu, 12 May 2022 11:06:54 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Miaoqian Lin <linmq006@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Kevin Hilman <khilman@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: hisi: Fix refcount leak in hi3xxx_smp_prepare_cpus
References: <20220512025839.50333-1-linmq006@gmail.com>
In-Reply-To: <20220512025839.50333-1-linmq006@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500011.china.huawei.com (7.221.188.124)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian,

On 2022/5/12 10:58, Miaoqian Lin wrote:
> of_find_compatible_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: a9434e96d9f0 ("ARM: hi3xxx: add smp support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  arch/arm/mach-hisi/platsmp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
> index a56cc64deeb8..15e63b72df3a 100644
> --- a/arch/arm/mach-hisi/platsmp.c
> +++ b/arch/arm/mach-hisi/platsmp.c
> @@ -68,13 +68,16 @@ static void __init hi3xxx_smp_prepare_cpus(unsigned int max_cpus)
>  		ctrl_base = of_iomap(np, 0);
>  		if (!ctrl_base) {
>  			pr_err("failed to map address\n");
> +			of_node_put(np);
>  			return;
>  		}
>  		if (of_property_read_u32(np, "smp-offset", &offset) < 0) {
>  			pr_err("failed to find smp-offset property\n");
> +			of_node_put(np);
>  			return;
>  		}
>  		ctrl_base += offset;
> +		of_node_put(np);
>  	}
>  }
>  
> 

