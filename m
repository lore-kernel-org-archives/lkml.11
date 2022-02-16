Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1754C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 08:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiBPISC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 03:18:02 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiBPIR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:17:59 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BB6163D53;
        Wed, 16 Feb 2022 00:17:47 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V4cQ8KA_1644999462;
Received: from 30.225.24.51(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V4cQ8KA_1644999462)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Feb 2022 16:17:44 +0800
Message-ID: <b33d4e29-bf89-13cf-17f3-63208bf8f70d@linux.alibaba.com>
Date:   Wed, 16 Feb 2022 16:17:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v3 05/22] cachefiles: introduce new devnode for on-demand
 read mode
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org, willy@infradead.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
        torvalds@linux-foundation.org
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
 <20220209060108.43051-6-jefflexu@linux.alibaba.com>
 <bd9cb3bb-e29c-d4b3-e9bf-915b9771b553@linux.alibaba.com>
 <YguCYmvdyRAOjHcP@kroah.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YguCYmvdyRAOjHcP@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/22 6:37 PM, Greg KH wrote:
> On Tue, Feb 15, 2022 at 05:03:16PM +0800, JeffleXu wrote:
>> Hi David,
>>
>> FYI I've updated this patch on [1].
>>
>> [1]
>> https://github.com/lostjeffle/linux/commit/589dd838dc539aee291d1032406653a8f6269e6f.
> 
> We can not review random github links :(

Thanks. The new version patch has been replied in the email.

-- 
Thanks,
Jeffle
