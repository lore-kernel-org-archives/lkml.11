Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37997C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 08:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349579AbiE0IYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 May 2022 04:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240686AbiE0IYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:24:38 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DC5366AC
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:24:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VEWM8cC_1653639872;
Received: from 30.32.82.202(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VEWM8cC_1653639872)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 May 2022 16:24:33 +0800
Message-ID: <c674af89-5596-3298-1730-47c0bfe6230d@linux.alibaba.com>
Date:   Fri, 27 May 2022 16:25:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [syzbot] upstream build error (18)
To:     syzbot <syzbot+a0b95614aef2afe9e488@syzkaller.appspotmail.com>,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.kravetz@oracle.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, will@kernel.org
References: <000000000000f2655205dff90da9@google.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <000000000000f2655205dff90da9@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/27/2022 3:14 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7e284070abe5 Merge tag 'for-5.19/dm-changes' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1233ae81f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=854cea6cbaeb1d1b
> dashboard link: https://syzkaller.appspot.com/bug?extid=a0b95614aef2afe9e488
> compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a0b95614aef2afe9e488@syzkaller.appspotmail.com
> 
> arch/arm64/mm/hugetlbpage.c:515:9: error: implicit declaration of function 'get_clear_flush'; did you mean 'ptep_clear_flush'? [-Werror=implicit-function-declaration]
> arch/arm64/mm/hugetlbpage.c:515:9: error: incompatible types when returning type 'int' but 'pte_t' was expected
> arch/arm64/mm/hugetlbpage.c:516:1: error: control reaches end of non-void function [-Werror=return-type]

I've sent out a fix patch [1], please try it. Thanks.

[1] 
https://lore.kernel.org/all/814e20c19b110209ee12ecae7cb05f8a78d021c8.1653625820.git.baolin.wang@linux.alibaba.com/
