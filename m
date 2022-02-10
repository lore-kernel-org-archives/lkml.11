Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61545C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 05:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbiBJF6d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 00:58:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBJF6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 00:58:19 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4391C5;
        Wed,  9 Feb 2022 21:58:20 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0V42eJYQ_1644472693;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V42eJYQ_1644472693)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Feb 2022 13:58:15 +0800
Date:   Thu, 10 Feb 2022 13:58:13 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
        xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        gregkh@linuxfoundation.org, tao.peng@linux.alibaba.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, eguan@linux.alibaba.com,
        gerry@linux.alibaba.com, torvalds@linux-foundation.org
Subject: Re: [Linux-cachefs] [PATCH v3 00/22] fscache,  erofs: fscache-based
 demand-read semantics
Message-ID: <YgSpdW1LjK2901ix@B-P7TQMD6M-0146.local>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
        xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        gregkh@linuxfoundation.org, tao.peng@linux.alibaba.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, eguan@linux.alibaba.com,
        gerry@linux.alibaba.com, torvalds@linux-foundation.org
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wed, Feb 09, 2022 at 02:00:46PM +0800, Jeffle Xu wrote:

...

> 
> 
> Jeffle Xu (22):
>   fscache: export fscache_end_operation()
>   fscache: add a method to support on-demand read semantics
>   cachefiles: extract generic function for daemon methods
>   cachefiles: detect backing file size in on-demand read mode
>   cachefiles: introduce new devnode for on-demand read mode

...

> 
>  Documentation/filesystems/netfs_library.rst |  18 +
>  fs/cachefiles/Kconfig                       |  13 +
>  fs/cachefiles/daemon.c                      | 243 +++++++++--
>  fs/cachefiles/internal.h                    |  12 +
>  fs/cachefiles/io.c                          |  60 +++
>  fs/cachefiles/main.c                        |  27 ++
>  fs/cachefiles/namei.c                       |  60 ++-

Would you mind taking a review at this version? We follow your previous
advices written in v2 and it reuses almost all cachefiles code except
that it has slightly different implication of cachefile file size and
a new daemon node.

I think it could be as the first step to implement fscache-based
on-demand read.

Thanks,
Gao Xiang

