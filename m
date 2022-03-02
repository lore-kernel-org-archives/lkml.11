Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395F0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 03:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbiCBDEq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 22:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiCBDEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 22:04:43 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273C95F4D8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 19:03:58 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V60eo0v_1646190234;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V60eo0v_1646190234)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Mar 2022 11:03:56 +0800
Date:   Wed, 2 Mar 2022 11:03:54 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@yulong.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: fix ztailpacking on > 4GiB filesystems
Message-ID: <Yh7emmP7TkMZ+Q8B@B-P7TQMD6M-0146.local>
References: <20220222033118.20540-1-hsiangkao@linux.alibaba.com>
 <4c8ce495-a27b-cba7-7a81-26adf9a4c604@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c8ce495-a27b-cba7-7a81-26adf9a4c604@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 10:49:47AM +0800, Chao Yu wrote:
> On 2022/2/22 11:31, Gao Xiang wrote:
> > z_idataoff here is an absolute physical offset, so it should use
> > erofs_off_t (64 bits at least). Otherwise, it'll get trimmed and
> > cause the decompresion failure.
> > 
> > Fixes: ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline support")
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Thanks Chao. Yeah, I will submit it this week..

Thanks,
Gao Xiang

> 
> Thanks,
