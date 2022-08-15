Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8147C00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 12:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242172AbiHOM3p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 08:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242144AbiHOM3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:29:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085272657C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gLBxowRDfXXdNnS2Uq+RFwPmidP3H5C4Kk5j9GJTZFs=; b=QQPtrhVPAdG95r+VIbHei8w2k6
        4wv8m//LK8TSKKYblkP28KkhgaB8I92yaJhi3X0oW9pV1/6dK9b4iHx8T72x7NxLSkHkL9Lu+pGpL
        i+BKx9xlXZxiT63eGBvhSzUSzWoZY4WFAPz4OOhI8RdxO1uwJNZ+HjU7LnnjtYc4MgNE3ctS97uBK
        yUmOIWUpPQ/b8cOCyEFCJV3bytBb5xmlN07UDJHkReaMBeZ8Md/ENJ9VnogzV/PM+jwixAF04414w
        DusD4Oiq5x1QLtUVkW7m9kGKFvbxkM57olpfMEk7u8mxqLMDhgvFscz0/22Z8e9w/KYKIFiea7oTX
        RtWmyz4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNZDl-005how-D6; Mon, 15 Aug 2022 12:29:29 +0000
Date:   Mon, 15 Aug 2022 13:29:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: fs/ntfs/aops.c:378:12: warning: stack frame size (2216) exceeds
 limit (1024) in 'ntfs_read_folio'
Message-ID: <Yvo8KUKJBlMtoNgI@casper.infradead.org>
References: <202208140835.W6F1j6Da-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202208140835.W6F1j6Da-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 08:21:36AM +0800, kernel test robot wrote:
> Hi Matthew,
> 
> FYI, the error/warning still remains.

FYI, this is still not interesting.
This is a hexagon 256kB PAGE_SIZE config, and so the amount of stack
space is correspondingly larger.  The frame size warning should be
increased to allow for this.

> >> fs/ntfs/aops.c:378:12: warning: stack frame size (2216) exceeds limit (1024) in 'ntfs_read_folio' [-Wframe-larger-than]
