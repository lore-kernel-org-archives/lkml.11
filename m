Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3DDC4332F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 02:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbiDHCQz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 22:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiDHCQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 22:16:49 -0400
Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com [47.90.199.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8FF23D766;
        Thu,  7 Apr 2022 19:14:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V9Ta7DP_1649384078;
Received: from 30.225.24.70(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V9Ta7DP_1649384078)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 08 Apr 2022 10:14:40 +0800
Message-ID: <e5014f57-8de4-dfb3-0828-bd133f9f5637@linux.alibaba.com>
Date:   Fri, 8 Apr 2022 10:14:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v8 12/20] erofs: add anonymous inode managing page cache
 for data blob
Content-Language: en-US
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <20220406075612.60298-13-jefflexu@linux.alibaba.com>
 <Yk53FOjDLzN941b4@B-P7TQMD6M-0146.local>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <Yk53FOjDLzN941b4@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/22 1:31 PM, Gao Xiang wrote:
> On Wed, Apr 06, 2022 at 03:56:04PM +0800, Jeffle Xu wrote:
>> Introduce one anonymous inode managing page cache for data blob. Then
>> erofs could read directly from the address space of the anonymous inode
>> when cache hit.
> 
> Introduce one anonymous inode for data blobs so that erofs
> can cache metadata directly within such anonymous inode.
> 

Thanks. Commit message will be updated in the next version.

-- 
Thanks,
Jeffle
