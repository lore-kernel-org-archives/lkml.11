Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A44C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 05:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348314AbiDLFne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 01:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiDLFnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:43:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B352664CF;
        Mon, 11 Apr 2022 22:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+GTXbTDAHapmxbU/Ak8Sa4qd13+yPBQmPzPmou4+siQ=; b=Fej8YAWC25pyjwbc68KS+7dA31
        t5U1r2RHwGBtqGIF6Qn5sEverbndJOEwz9a4pS/WEv6AJGCk7EGHDUSVJxg8rOSgO4hgubvUE2xY0
        +JjUX1r1j91T7t9f+fCbZ4Wk0rHzVhwTGS/WbypmCGZrfRMBZD7h+lsItWlseAbFkU2PAVgB7A4S3
        b2TGeattX+RxIscQyVxWQaooRLXsfJ6/3FOQ8k4fxUl/3PendFJnWwF9jtoAwNSGHNuQled9Utefu
        OEsTaeucT/xs0tomCPF0hLRozPED4cPapqa/YONoRsBBKsVnsvag74EuCCWgev4sBWwdqsVKBv71V
        hA1jnXxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ne9H3-00BnD9-BQ; Tue, 12 Apr 2022 05:41:09 +0000
Date:   Mon, 11 Apr 2022 22:41:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] stat: don't fail if the major number is >= 256
Message-ID: <YlUQ9fnc+4eP3AE5@infradead.org>
References: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wijDnLH2K3Rh2JJo-SmWL_ntgzQCDxPeXbJ9A-vTF3ZvA@mail.gmail.com>
 <alpine.LRH.2.02.2204111236390.31647@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 07:37:44PM -1000, Linus Torvalds wrote:
> Realistically, nobody uses it. Apparently your OpenWatcom use is also
> really just fairly theoretical, not some "this app is used by people
> and doesn't work with a filesystem on NVMe".

And that is easily fixed by using a lower major for the block dynamic
dev_t.  In theory userspace should be able to copy with any major for
it, but I fear something might break so we could make it configurable.
