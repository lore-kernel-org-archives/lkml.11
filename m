Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607C7C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Apr 2022 05:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353880AbiDBFe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Apr 2022 01:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiDBFeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 01:34:25 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD94147AF2;
        Fri,  1 Apr 2022 22:32:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V8yMzNQ_1648877547;
Received: from 30.225.24.59(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V8yMzNQ_1648877547)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 Apr 2022 13:32:29 +0800
Message-ID: <11bb4271-8a87-945f-96ef-be3a1acd01a5@linux.alibaba.com>
Date:   Sat, 2 Apr 2022 13:32:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 02/19] cachefiles: notify user daemon with anon_fd when
 looking up cookie
Content-Language: en-US
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
References: <20220331115753.89431-1-jefflexu@linux.alibaba.com>
 <20220331115753.89431-3-jefflexu@linux.alibaba.com>
In-Reply-To: <20220331115753.89431-3-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/22 7:57 PM, Jeffle Xu wrote:
>  
> +	ret = cachefiles_ondemand_init_object(object);
> +	if (ret < 0) {
> +		file = ERR_PTR(ret);
> +		goto out_unuse;
> +	}
> +

Sorry, this patch really depends on [1] which introduces "out_unuse" label.

[1] https://www.spinics.net/lists/linux-cachefs/msg05972.html


My git branch has already contained this commit [2].

[2]
https://github.com/lostjeffle/linux/commit/3c71705e777fa75d37f784640a232db14ce62c31


-- 
Thanks,
Jeffle
