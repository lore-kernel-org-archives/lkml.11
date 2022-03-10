Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440F5C4332F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 15:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbiCJPSe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 10:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244259AbiCJPSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:18:01 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7374DFEB;
        Thu, 10 Mar 2022 07:16:59 -0800 (PST)
Received: from kwepemi100014.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KDt0N47l5zBrlV;
        Thu, 10 Mar 2022 23:15:00 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 kwepemi100014.china.huawei.com (7.221.188.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 23:16:56 +0800
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 23:16:56 +0800
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "maz@kernel.org" <maz@kernel.org>, <jbaron@akamai.com>,
        <akpm@linux-foundation.org>, <khazhy@google.com>,
        <kaleshsingh@google.com>, <dbueso@suse.de>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
From:   "wanghai (M)" <wanghai38@huawei.com>
Subject: epoll: Does anyone know about CVE-2021-39634
Message-ID: <37574411-707e-89c9-5e77-35b254337664@huawei.com>
Date:   Thu, 10 Mar 2022 23:16:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.245]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've spent a long time and can't figure out the details of the following 
CVE, can anyone help me?

CVE-2021-39634 [1]
In fs/eventpoll.c, there is a possible use after free.

I have two questions:
1. How does the UAF problem happen?
2. Why it can be fixed by commit f8d4f44df056 ("epoll: do not insert 
into poll queues until all sanity checks are done") [2]

I'm guessing that patch [3] solved a problem similar to [4], is this 
correct?

Any feedback would be appreciated, thanks.

[1] https://nvd.nist.gov/vuln/detail/CVE-2021-39634
[2] https://www.linuxkernelcves.com/cves/CVE-2021-39634
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=f8d4f44df056c5b504b0d49683fb7279218fd207
[4] 
https://cloudfuzz.github.io/android-kernel-exploitation/chapters/root-cause-analysis.html

-- 
Wang Hai

