Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02138C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jun 2022 08:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbiFTIqZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jun 2022 04:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239620AbiFTIqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:46:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5442BE9A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:46:21 -0700 (PDT)
Received: from kwepemi100013.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LRNVQ5NBzzhYYG;
        Mon, 20 Jun 2022 16:44:14 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi100013.china.huawei.com (7.221.188.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 20 Jun 2022 16:46:19 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2375.024;
 Mon, 20 Jun 2022 16:46:19 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "xuqiang (M)" <xuqiang36@huawei.com>
Subject: Re: [PATCH 1/1] lockdep: pass curr_inner to
 print_lock_invalid_wait_context
Thread-Topic: [PATCH 1/1] lockdep: pass curr_inner to
 print_lock_invalid_wait_context
Thread-Index: AQHYgk0/9VHjoiftGU6cvzdp/UjhBQ==
Date:   Mon, 20 Jun 2022 08:46:18 +0000
Message-ID: <233a8820e3df4c8ca594c4a78fdb0fb9@huawei.com>
References: <20220616134042.130002-1-chenjun102@huawei.com>
 <YqyAAvSw3+0GyHhg@worktop.programming.kicks-ass.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.43]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/6/17 21:22, Peter Zijlstra 写道:
> On Thu, Jun 16, 2022 at 01:40:42PM +0000, Chen Jun wrote:
>> Same information (task_wait_context(curr)) is printed twice.
> 
> Yes, because at that point the inner and outer context are the same.
> 
>> curr_inner in check_wait_context is what we need.
> 
> IIRC it simply prints the task_wait_context as a starting point, the
> lockdep_print_held_locks() should include the contexts for each of
> those, after which you can compute the resulting value.
> 
> IOW, the information is complete.
> 
> 
> 

Thanks for pointing this out.

-- 
Regards
Chen Jun
