Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A80C25B0D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Aug 2022 05:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiHMFBd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Aug 2022 01:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMFBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 01:01:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960C570E7D
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 22:01:29 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M4Sxz72CVzmVlZ;
        Sat, 13 Aug 2022 12:59:19 +0800 (CST)
Received: from huawei.com (10.67.174.191) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 13 Aug
 2022 13:01:27 +0800
From:   Li Hua <hucool.lihua@huawei.com>
To:     <frederic@kernel.org>
CC:     <bristot@redhat.com>, <bsegall@google.com>,
        <dietmar.eggemann@arm.com>, <hucool.lihua@huawei.com>,
        <juri.lelli@redhat.com>, <linux-kernel@vger.kernel.org>,
        <mgorman@suse.de>, <mingo@redhat.com>, <peterz@infradead.org>,
        <rostedt@goodmis.org>, <vincent.guittot@linaro.org>
Subject: Re: [Question] Reading /proc/stat has a time backward issue
Date:   Sun, 14 Aug 2022 02:58:38 +0800
Message-ID: <20220813185838.49743-1-hucool.lihua@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220811124958.GB3284884@lothringen>
References: <20220811124958.GB3284884@lothringen>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for not seeing your reply in time

Your patch doesn't seem to fix the problem.  The root cause of the problem is that
the "vtime->utime" and "delta" are temporarily added to the stack and show to the user.

I tried to submit a patch to avoid presenting time backwards to the user. as bellow:
https://lkml.org/lkml/2022/8/12/261

Hope you have better suggestions, thank you for your reply.
