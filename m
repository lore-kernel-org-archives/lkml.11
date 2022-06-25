Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5754DC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jun 2022 06:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiFYGdV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jun 2022 02:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiFYGdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 02:33:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC7963BC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 23:33:18 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LVPJR5kDgzhXZ5;
        Sat, 25 Jun 2022 14:31:03 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (7.193.23.74) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 25 Jun 2022 14:33:14 +0800
Received: from [10.67.109.57] (10.67.109.57) by kwepemm600012.china.huawei.com
 (7.193.23.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 25 Jun
 2022 14:33:14 +0800
To:     <srikar@linux.vnet.ibm.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
From:   "guanjing (D)" <guanjing6@huawei.com>
Subject: Fwd: Question about how to fix numabalancing to work with isolated
 cpus?
Message-ID: <ccd220cd-fbca-ad8a-c290-e812c4850e2f@huawei.com>
Date:   Sat, 25 Jun 2022 14:33:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.57]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
     I notice a problem that you guys discussed in the link below:

     https://lore.kernel.org/all/1491464210.4718.82.camel@gmx.de/T/
     "The isolated cpus are part of the cpus allowed list. In the above 
case,
      numabalancing ends up scheduling some of these tasks on isolated 
cpus. "

     I wonder if we're going to fix this eventually?

Thanks,
Guan Jing

