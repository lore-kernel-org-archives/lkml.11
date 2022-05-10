Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17AEC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 07:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiEJHgf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 03:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240016AbiEJHRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:17:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89992992C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kNBj/iu5HaP6U5A3B694vyzaegPgkU/q7AXS/gs/lck=; b=4O7fojCxxpel6vIt7Z3ZRK4Zva
        vsjiknNNfESf9ZcDwlk74NODpyF2is03W3ZltK3U9kFP4CCgvD3lEH6jf5/CeNZWKyZY9VCMBMowM
        tvlUvdyU5nHGF7bNzWl41tDX5CdTCcdVg50smlymdO+8bFCvZBpmsaT6QqXoBDSSFFDZjo6zZzlDu
        RPFK6mp0mkSzOgovpP9kAcyfZfmt1D5ONFtD/6jGdvgInW8gxakWUW1mIAIy5UnYQ+RLAALpffHgB
        cC959OSOZsOuK9/iE2S5veSxQZZJTglGl1wK6HRlSDChTC91d0ofXdLWGcku1iWrHuSYeBRC1Rr4s
        4MS7V/sA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noK3m-000JAw-Cf; Tue, 10 May 2022 07:13:30 +0000
Date:   Tue, 10 May 2022 00:13:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bill Wendling <morbo@google.com>, cluster-devel@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfs2: Use container_of() for gfs2_glock(aspace)
Message-ID: <YnoQmuPgK9c5V8ZC@infradead.org>
References: <20220508100630.2642320-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508100630.2642320-1-keescook@chromium.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* gfs2_glock_get(), "glock" must be first. */
> +struct glock_aspace {
> +	struct gfs2_glock	glock;
> +	struct address_space	mapping;
> +};

Why does glock need to be first?  The whole point of using container_of
is that we don't have to make that assumption.

>  static inline struct address_space *gfs2_glock2aspace(struct gfs2_glock *gl)
>  {
>  	if (gl->gl_ops->go_flags & GLOF_ASPACE)
> -		return (struct address_space *)(gl + 1);
> +		return &(container_of(gl, struct glock_aspace, glock)->mapping);

Do we even need the braces here?

>  	struct inode *inode = mapping->host;
>  	if (mapping->a_ops == &gfs2_meta_aops)
> -		return (((struct gfs2_glock *)mapping) - 1)->gl_name.ln_sbd;
> +		return container_of(mapping, struct glock_aspace, mapping)->glock.gl_name.ln_sbd;

A local variable would be really nice for the reader here to decompose
this a bit:

		struct glock_aspace *a =
			container_of(mapping, struct glock_aspace, mapping);

		return a->glock.gl_name.ln_sbd;

