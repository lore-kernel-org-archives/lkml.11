Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40265C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 12:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346230AbiDKMxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 08:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346216AbiDKMxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:53:05 -0400
Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5799233369;
        Mon, 11 Apr 2022 05:50:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V9pCfav_1649681444;
Received: from 30.225.24.83(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V9pCfav_1649681444)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Apr 2022 20:50:46 +0800
Message-ID: <1225fb70-a785-9d4d-5532-28bfde8214f1@linux.alibaba.com>
Date:   Mon, 11 Apr 2022 20:50:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v8 05/20] cachefiles: implement on-demand read
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com,
        tianzichen@kuaishou.com, fannaihao@baidu.com
References: <20220406075612.60298-6-jefflexu@linux.alibaba.com>
 <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <1091905.1649681074@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1091905.1649681074@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/22 8:44 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>>  	/*
>>  	 * Uninstall anon_fd to the cachefiles object, so that no further
>>  	 * associated requests will get enqueued.
>>  	 */
> 
> "Uninstall anon_fd from..."?

Okay, will be fixed.

> 
>> +static int init_read_req(struct cachefiles_req *req, void *private)
> 
> Prefix with "cachefiles_" please (or "cachefiles_ondemand_").

Alright.

Thanks for reviewing.

-- 
Thanks,
Jeffle
