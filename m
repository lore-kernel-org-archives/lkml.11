Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB33C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Jul 2022 03:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiGIDOo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Jul 2022 23:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIDOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 23:14:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCEF5E310
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 20:14:40 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LfwGM6bg6zFq0P;
        Sat,  9 Jul 2022 11:13:47 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Jul 2022 11:14:38 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Jul 2022 11:14:37 +0800
Message-ID: <b7ae1cf8-2809-f618-5340-fb8def9a8be0@huawei.com>
Date:   Sat, 9 Jul 2022 11:14:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] ntfs: fix use-after-free in ntfs_ucsncmp()
To:     Hawkins Jiawei <yin31149@gmail.com>
CC:     <akpm@linux-foundation.org>, <anton@tuxera.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-ntfs-dev@lists.sourceforge.net>,
        <liuyongqiang13@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>, <18801353760@163.com>,
        <skhan@linuxfoundation.org>, <paskripkin@gmail.com>,
        <linux-kernel-mentees@lists.linuxfoundation.org>
References: <20220707105329.4020708-1-chenxiaosong2@huawei.com>
 <20220709005450.2220-1-yin31149@gmail.com>
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
In-Reply-To: <20220709005450.2220-1-yin31149@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/7/9 8:54, Hawkins Jiawei 写道:> In my opinion, name_length field 
just means the number of characters,
> yet each character is a ntfschar type. So name should be
> name_length * sizeof(ntfschar) bytes. The example is at
> https://elixir.bootlin.com/linux/v5.19-rc5/source/fs/ntfs/attrib.c#L1667

Yes, thank you for your reply, I will send v3 patch.
