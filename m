Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0E0C43334
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Jul 2022 05:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiGHFl6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Jul 2022 01:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbiGHFl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 01:41:56 -0400
Received: from out199-3.us.a.mail.aliyun.com (out199-3.us.a.mail.aliyun.com [47.90.199.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282D16308
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 22:41:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VIiBeZe_1657258907;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VIiBeZe_1657258907)
          by smtp.aliyun-inc.com;
          Fri, 08 Jul 2022 13:41:49 +0800
Date:   Fri, 8 Jul 2022 13:41:47 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     guowei du <duguoweisz@gmail.com>
Cc:     xiang@kernel.org, Chao Yu <chao@kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        duguowei <duguowei@xiaomi.com>
Subject: Re: [PATCH 2/2] erofs: sequence each shrink task
Message-ID: <YsfDm5q9wIyewtWR@B-P7TQMD6M-0146.local>
References: <20220708031155.21878-1-duguoweisz@gmail.com>
 <YsejnaY7cy3SeHBF@B-P7TQMD6M-0146.local>
 <CAC+1NxvifeHmrerWUqhC-gCUk11vudLVc=o=Hnr5EwYJv+N0ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC+1NxvifeHmrerWUqhC-gCUk11vudLVc=o=Hnr5EwYJv+N0ZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 08, 2022 at 12:49:07PM +0800, guowei du wrote:
> hi,
> I am sorry，there is only one patch.
> 
> If two or more tasks are doing a shrinking job, there are different results
> for each task.
> That is to say, the status of each task is not persistent each time,
> although they have
> the same purpose to release memory.
> 
> And, If two tasks are shrinking, the erofs_sb_list will become no order,
> because each task will
> move one sbi to tail, but sbi is random, so results are more complex.

Thanks for the explanation. So it doesn't sound like a real issue but seems
like an improvement? If it's more like this, you could patch this to the
products first and beta for more time and see if it works well.. I'm
more careful about such change to shrinker since it could impact
downstream users...

Yes, I know this behavior, but I'm not sure if it's needed to be treated
as this way, because in principle shrinker can be processed by multiple
tasks since otherwise it could be stuck by some low priority task (I
remember it sometimes happens in Android.)

> 
> Because of the use of the local variable 'run_no', it took me a long time
> to understand the
> procedure of each task when they are concurrent.
> 
> There is the same issue for other fs, such as
> fs/ubifs/shrink.c、fs/f2fs/shrink.c.
> 
> If scan_objects cost a long time ,it will trigger a watchdog, shrinking
> should
> not make work time-consuming. It should be done ASAP.
> So, I add a new spin lock to let tasks shrink fs sequentially, it will just
> make all tasks shrink
> one by one.

Actually such shrinker is used for managed slots (sorry I needs more
work to rename workgroup to such name). But currently one of my ongoing
improvements is to remove pclusters immediately from managed slots if
no compressed buffer is cached, so it's used for inflight I/Os (to merge
decompression requests, including ongoing deduplication requests) and
cached I/O only.  So in that way objects will be more fewer than now.

> 
> 
> Thanks very much.

Thank you.

Thanks,
Gao Xiang

