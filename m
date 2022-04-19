Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2CCC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 08:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349737AbiDSINu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 04:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349733AbiDSINh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:13:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B095E167C3;
        Tue, 19 Apr 2022 01:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CUndTrsqJFoM106lC4x26CnMR+Y77lrRAU5HyT6wp+4=; b=WlW05aSHPhNgABJfo46SfybTvT
        u9RLlWN2Hxn3fhsYN6JOYuvpiDj3mmEMdVlj+WCk+mboHAgHHTJEpd6c0yq6CTD9NpT2jy0jh+K9F
        QGT7pRnOY/zizVdNABBeRCH7zVCxBk/Jd/SsInQp9z+NUW9NXKRRoQtnQ0BuGf8doPX+sUjkStq/l
        DHnsRHVBwnzRZEjChjyPb2ZDvHJJpRGP7VrUvaK3DtctcDntid3M3SdQzFWxcvwWpS4hIShDssxJx
        v0UgBrb5DEuJJhUJVwIS5TsxLrONKFw4JAnI2Avv+i2Nh3ZFkDtkJip+WEIhL+U78NSTleiino7X2
        a6qtlOpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngiwd-002ueG-2y; Tue, 19 Apr 2022 08:10:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D84F98618A; Tue, 19 Apr 2022 10:10:41 +0200 (CEST)
Date:   Tue, 19 Apr 2022 10:10:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yukuai3@huawei.com
Subject: Re: [PATCH v2] fs-writeback: =?utf-8?Q?wri?=
 =?utf-8?Q?teback=5Fsb=5Finodes=EF=BC=9ARecalculat?= =?utf-8?Q?e?= 'wrote'
 according skipped pages
Message-ID: <20220419081041.GL2731@worktop.programming.kicks-ass.net>
References: <20220418092824.3018714-1-chengzhihao1@huawei.com>
 <CAHk-=wh7CqEu+34=jUsSaMcMHe4Uiz7JrgYjU+eE-SJ3MPS-Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh7CqEu+34=jUsSaMcMHe4Uiz7JrgYjU+eE-SJ3MPS-Gg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 12:43:43PM -0700, Linus Torvalds wrote:
> Similarly, tsk_is_pi_blocked() will disable the plug flush.

Bah, I'm forever confused by that clause... I did ask for a comment at
some point but that never seems to have happened.

  https://lore.kernel.org/all/20190816160626.12742-1-bigeasy@linutronix.de/T/#md983b64256814c046cec9ec875f4a975029b0daa

Seems to indicate it is about scheduling while holding a lock and the
unplug then leading to a deadlock.
