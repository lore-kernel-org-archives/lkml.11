Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3A2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 15:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347775AbiDKPTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 11:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347779AbiDKPTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:19:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F76832987;
        Mon, 11 Apr 2022 08:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MtDBJRz7aAvJeMtL3L+Os8sJX/edcjhGc1kTLngfBOY=; b=o8rQWz0v4zGDV4Gr0VwK/zxhsV
        TrzOTdh6PGBPxaCBbE39NfeLh81imlw+Cxe/x8gR5/LNHtKc4w27anQxz/54kVCZdK1OOAHxsK3xC
        YdRLEUAzoTTfQqh4vo5BM7B3wfHNYs88JNDgSznHwVkbAqFu++zWy9Y1ZQed6eblxAq8lGRhXHDJm
        NN/qBT7F31rUSzDyY1Z+ij+/Q0+5V9iPTGeKDRe3sjnIh0XM1jiL/bE6bTzj/eChUOdvoNSkCa8Uk
        gybtquzbuSIPrH8jMDst1sQT4Bi90JC/KAWzUoWTxNGOA9sBbVEJYyyYOJMQM8jGclTuMDgqd9Edx
        J2kCftsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndvmV-009VEz-MI; Mon, 11 Apr 2022 15:16:43 +0000
Date:   Mon, 11 Apr 2022 08:16:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stat: don't fail if the major number is >= 256
Message-ID: <YlRGW43oXfss6Lfj@infradead.org>
References: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com>
 <YlRDSXQG+ED1Okpp@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlRDSXQG+ED1Okpp@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 04:03:37PM +0100, Matthew Wilcox wrote:
> Is it better?  You've done a good job arguing why it is for this particular
> situation, but if there's a program which compares files by
> st_dev+st_ino, it might think two files are identical when they're
> actually different and, eg, skip backing up a file because it thinks
> it already did it.  That would be a silent failure, which is worse
> than this noisy failure.

Agreed.

> The real problem is clearly that Linus denied my request for a real
> major number for NVMe back in 2012 or whenever it was :-P

I don't think that is the real probem.  The whole dynamic dev_t scheme
has worked out really well and I'm glade drivers don't need a major
allocation anymore.  But I'm not sure why the dynamic major had to be
past 255 given these legacy issues, especially as there are plenty of
free ones with lower numbers.
