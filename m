Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6153C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jan 2022 12:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiAMMAb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jan 2022 07:00:31 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:54221 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232725AbiAMMAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:00:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V1jQymi_1642075226;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V1jQymi_1642075226)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jan 2022 20:00:28 +0800
Date:   Thu, 13 Jan 2022 20:00:26 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: fix fsdax partition offset handling
Message-ID: <YeAUWonU7Igf6+E7@B-P7TQMD6M-0146.local>
References: <20220113051845.244461-1-hsiangkao@linux.alibaba.com>
 <20220113072122.GA21315@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220113072122.GA21315@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 08:21:22AM +0100, Christoph Hellwig wrote:
> Looks good, thanks for fixing this up:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for the review. Will apply later..

Thanks,
Gao Xiang
