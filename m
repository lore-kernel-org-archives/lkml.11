Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DFCC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 19:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiBXTla (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 14:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiBXTl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:41:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD332763D9;
        Thu, 24 Feb 2022 11:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GrbBLAbtvC4chaYdzgUK1w1hf9+xtC4k6cVzY/iVx3U=; b=pUaNsZxVGnEHGlDh9Mk+nY4Puc
        WDK2PKuOlt4p0TsbO6ETD2kRFFIDMPq93CdkJa9Iab0H00mjKKQLei1dPnXOHapqa58yCw72eYM4E
        jlgrtc0l94HKpO/qSd6rRHBtIBI62VoEfbYdqDPC3hfIVl7cAWxyarEfP5GMPxxrivrWd2tj/QTtX
        vMrA9PdF5ZHtwmXXUbcDoAk3PZumDSG6NW/yIway8XVyvJu28V5/hlFS4SmLWB4bDAglam6GIOtPg
        EIakVt52CXxk2k40RN34UYCk8ko1gF5NiN2m5ieGbD1Qldb3mOTj2Ip+6w3fCOaQJD8L54/o+c8zk
        OLAW9wCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNJyt-0054y2-Hj; Thu, 24 Feb 2022 19:40:51 +0000
Date:   Thu, 24 Feb 2022 19:40:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [next] LTP: readahead02.c:295: TFAIL: readahead failed to save
 any I/O
Message-ID: <YhffQ6XStJycOmK1@casper.infradead.org>
References: <CA+G9fYs_8ww=Mi4o4XXjQxL2XJiTiAUbMd1WF08zL+FoiA7GRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYs_8ww=Mi4o4XXjQxL2XJiTiAUbMd1WF08zL+FoiA7GRw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 02:57:59PM +0530, Naresh Kamboju wrote:
> On Linux next 20220222 tag LTP syscalls test case readahead02 failed.
> Please find detail test output on below link [1]
> 
> test failed log:
> --------------------
> readahead02.c:181: TPASS: offset is still at 0 as expected
> readahead02.c:285: TINFO: read_testfile(0) took: 37567 usec
> readahead02.c:286: TINFO: read_testfile(1) took: 37263 usec
> readahead02.c:288: TINFO: read_testfile(0) read: 0 bytes
> readahead02.c:290: TINFO: read_testfile(1) read: 0 bytes
> readahead02.c:295: TFAIL: readahead failed to save any I/O

Confirmed, I can reproduce this with the folio tree.  Will work on
this once I've disposed of the other bug I'm looking at right now.
