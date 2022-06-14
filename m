Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7362C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 02:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354095AbiFNChc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 22:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355943AbiFNChR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:37:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90F03CA50
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:16:19 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LMX8K6JFqzjY0X;
        Tue, 14 Jun 2022 10:15:13 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 10:16:17 +0800
Subject: Re: [PATCH v3 1/1] mm/memory-failure: don't allow to unpoison hw
 corrupted page
To:     David Hildenbrand <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        zhenwei pi <pizhenwei@bytedance.com>,
        <naoya.horiguchi@nec.com>, <akpm@linux-foundation.org>
References: <20220610114646.162764-1-pizhenwei@bytedance.com>
 <20220610114646.162764-2-pizhenwei@bytedance.com>
 <0fedf6f3-3ab3-e1d2-fd6e-3dbe8e92f06d@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <844edb08-e145-0209-bf7a-60fb38503705@huawei.com>
Date:   Tue, 14 Jun 2022 10:16:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <0fedf6f3-3ab3-e1d2-fd6e-3dbe8e92f06d@redhat.com>
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

On 2022/6/10 20:12, David Hildenbrand wrote:
> 
> I really prefer just disabling the unpoisioning mechanism in case there
> is a real hw injected error.

IMHO, this would be a simple solution that also works on the arches that does not unmap
the kernel mapping when a page is hardware corrupted.

Thanks!

> 

