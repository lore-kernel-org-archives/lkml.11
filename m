Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D411C43334
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jun 2022 13:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbiFYNj5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jun 2022 09:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiFYNj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 09:39:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D9B18B0B;
        Sat, 25 Jun 2022 06:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H1b2WDsk+mj+vY991cx6kqmyfaX2i7Pf5yLchc29ZNU=; b=X+vTbl+/a5S7LX8PmZvmvhjxli
        Pgr6GAo47bhsiS0J24GJFSHAHrHVA6IV8qy0BANGpvR0fpjLSl/eFhOJzsuKonptYDtXe/eT1fDph
        VsX+ZeiJAinxP/L/wrXJ9r0oYLQw5M6oQGHVwplkaPYcOOgkmWQ3ICFRfgkebRQ7hIREvG83pEXky
        W2QqVxFMMshqOTr7r1bG3b237l9PQaLWQo3+jwinqG7hgJ+8syGLbQjyFW2OtsY3YVeLzwTgvh2eU
        o2T/9Tzb7KVoMWf08CKijw8pLb3tKUipl6Wzh9XyEYJhYr3itQuSNNkkApWnJSnzVS/q8B/wjQOZX
        TwCZ3rng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o560u-006Ees-Fb; Sat, 25 Jun 2022 13:39:52 +0000
Date:   Sat, 25 Jun 2022 06:39:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] fs: clear or set FMODE_LSEEK based on llseek
 function
Message-ID: <YrcQKIruM3w2gGho@infradead.org>
References: <20220625110115.39956-1-Jason@zx2c4.com>
 <20220625110115.39956-4-Jason@zx2c4.com>
 <YrcIoaluGx+2TzfM@infradead.org>
 <YrcNpdJmyFU+Up1n@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrcNpdJmyFU+Up1n@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 02:29:09PM +0100, Al Viro wrote:
> I wouldn't bet on that - as it is, an ->open() instance can decide
> in some cases to clear FMODE_LSEEK, despite having file_operations
> with non-NULL ->llseek.

The interesting cases here are nonseekable_open and stream_open,
and I don't see why we could not fix this up in the file_operations.
