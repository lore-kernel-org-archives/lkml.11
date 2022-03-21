Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A9DC433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 03:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344320AbiCUDlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Mar 2022 23:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344046AbiCUDls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 23:41:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC262574AF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 20:40:22 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KML1M4859zCqnH;
        Mon, 21 Mar 2022 11:38:15 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 11:40:20 +0800
Received: from use12-sp2.huawei.com (10.67.189.20) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 11:40:20 +0800
From:   Jubin Zhong <zhongjubin@huawei.com>
To:     <lasse.collin@tukaani.org>
CC:     <akpm@linux-foundation.org>, <liaohua4@huawei.com>,
        <linux-kernel@vger.kernel.org>, <wangfangpeng1@huawei.com>,
        <zhongjubin@huawei.com>
Subject: Re: Re: [PATCH v2] kbuild: Enable armthumb BCJ filter for Thumb-2 kernel
Date:   Mon, 21 Mar 2022 11:40:17 +0800
Message-ID: <1647834017-23673-1-git-send-email-zhongjubin@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <20211121233722.708131a8@kaneli>
References: <20211121233722.708131a8@kaneli>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.20]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 2021-11-20 Jubin Zhong wrote:
>> xz_wrap.sh use $SRCARCH to detect the BCJ filter. However, assigning 
>> arm BCJ filter to Thumb-2 kernel is not optimal. In my case, about 5% 
>> decrease of image size is observed with armthumb BCJ filter:
>> 
>> Test results:
>>   hardware:      QEMU emulator version 3.1.0
>>   config:        vexpress_defconfig with THUMB2_KERNEL & KERNEL_XZ on
>>   arm BCJ:       4029808
>>   armthumb BCJ:  3827280
>> 
>> Choose armthumb BCJ filter for Thumb-2 kernel to make smaller images.
>> 
>> Signed-off-by: Jubin Zhong <zhongjubin@huawei.com>

>I still didn't test it but it looks good to me.

Hi, this patch is not accepted into the kernel mainline yet.
Please let me know if there is any problem with the patch, thanks.

