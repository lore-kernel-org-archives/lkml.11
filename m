Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E13CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 06:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244372AbiEaGuw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 02:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244361AbiEaGut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 02:50:49 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A82870922
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 23:50:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VEu7moQ_1653979844;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VEu7moQ_1653979844)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 31 May 2022 14:50:46 +0800
Date:   Tue, 31 May 2022 14:50:44 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Chao Yu <chao@kernel.org>
Cc:     Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] erofs: random decompression cleanups
Message-ID: <YpW6xNPXHig7Djee@B-P7TQMD6M-0146.local>
References: <20220529055425.226363-1-xiang@kernel.org>
 <903a5a66-be1c-6371-708e-ac7f491b9585@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <903a5a66-be1c-6371-708e-ac7f491b9585@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 02:45:38PM +0800, Chao Yu wrote:
> Acked-by: Chao Yu <chao@kernel.org>

Thanks Chao! It'd be much helpful for me if we apply these cleanups
so I can have a new folio rework+cleanup+rolling hash 5.20 cycle.

Thanks,
Gao Xiang

> 
> Thanks,
> 
> On 2022/5/29 13:54, Gao Xiang wrote:
> > From: Gao Xiang <hsiangkao@linux.alibaba.com>
> > 
> > Hi folks,
> > 
> > Now I'm working on cleanuping decompression code and doing some
> > folio adaption for the next 5.20 cycle, see:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/log/?h=erofs/folios
> > 
> > This cleanup work completely gets rid of PageError usage finally
> > and tries to prepare for introducing rolling hashing for EROFS
> > since EROFS supports compressing variable-sized data instead of
> > fixed-sized clusters.
> > 
> > Therefore, EROFS can support rolling hash easily and our mechanism
> > can make full use of filesystem interfaces (byte-addressed) naturally.
> > 
> > Before that, I'd like to submit some trivial cleanups in advance for
> > the 5.19 cycle. All patches are without any logical change, so I can
> > have a more recent codebase for the next rework cycle.
> > 
> > Thanks,
> > Gao Xiang
> > 
> > Gao Xiang (3):
> >    erofs: get rid of `struct z_erofs_collection'
> >    erofs: get rid of label `restart_now'
> >    erofs: simplify z_erofs_pcluster_readmore()
> > 
> >   fs/erofs/zdata.c | 165 +++++++++++++++++++----------------------------
> >   fs/erofs/zdata.h |  50 +++++++-------
> >   2 files changed, 88 insertions(+), 127 deletions(-)
> > 
