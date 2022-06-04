Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E437CC433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jun 2022 09:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbiFDJvQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jun 2022 05:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbiFDJvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 05:51:12 -0400
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769881CB34;
        Sat,  4 Jun 2022 02:51:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VFIW16m_1654336265;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VFIW16m_1654336265)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 04 Jun 2022 17:51:06 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH] proc: export page young and skip_kasan_poison flag via
 kpageflags
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     changbin.du@intel.com, sashal@kernel.org, adobriyan@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220602154302.12634-1-xhao@linux.alibaba.com>
 <20220602110454.319467e7e0f7f662142b5c39@linux-foundation.org>
Message-ID: <d641c927-0784-3a7e-2abd-d05df1a40c83@linux.alibaba.com>
Date:   Sat, 4 Jun 2022 17:51:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220602110454.319467e7e0f7f662142b5c39@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/3/22 2:04 AM, Andrew Morton wrote:
> On Thu,  2 Jun 2022 23:43:02 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> Now the young and skip_kasan_poison flag are supported in
>> show_page_flags(), but we can not get them from /proc/kpageflags,
>> So there add them.
> Can we have a documentation update please?
>
> hp2:/usr/src/25> grep -rl kpageflags Documentation
> Documentation/admin-guide/mm/idle_page_tracking.rst
> Documentation/admin-guide/mm/pagemap.rst
> Documentation/filesystems/proc.rst
> Documentation/translations/zh_CN/vm/hwpoison.rst
> Documentation/vm/hwpoison.rst
OK, will do in the next version, thanks

-- 
Best Regards!
Xin Hao

