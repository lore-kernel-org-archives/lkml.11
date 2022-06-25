Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7951C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jun 2022 13:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbiFYNKF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jun 2022 09:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiFYNKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 09:10:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF18A5F55;
        Sat, 25 Jun 2022 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nw24XXZnXVM2CczTxTtCDu7i5NW03WPL24qA7zFmQOU=; b=pxoYScQgHTX20njZz8ukZ/3Ddk
        GQeWwV4erOpLikcwHRhbrIUeCBoSxNdLconnWiktYP8EMVPEt9s3j43yyv/9mqNhcGq/sdaAKwAgx
        XT+croLLlujfhIGBQdlZV0TKDnpiLbqVtmWVHwmfRFlwnc8/NDKXfGJrvdJukmrjvPEST0LrSRGG8
        U7wrhj3+B+KHEQM/p2a9xLa4OI6zQkLd1fbhXo7TNigKBwP6x1klZmexGbm1rL2T6w8+Oqso3TBjl
        +m7bu0bo9CNUsrXl6z76d8j3pg7XTRHsCeUM5dgdkB46HOszbKRF1RfKFkunly/bV1lfIkuL7eWOx
        XFTHDn4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o55Y2-0067pL-9w; Sat, 25 Jun 2022 13:10:02 +0000
Date:   Sat, 25 Jun 2022 06:10:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] fs: remove no_llseek
Message-ID: <YrcJKtZQLDvRgX7P@infradead.org>
References: <20220625110115.39956-1-Jason@zx2c4.com>
 <20220625110115.39956-7-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625110115.39956-7-Jason@zx2c4.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 01:01:13PM +0200, Jason A. Donenfeld wrote:
> Now that all callers of ->llseek are going through vfs_llseek(), we
> don't gain anything by keeping no_llseek around. Nothing compares it or
> calls it.

Shouldn't this and the checks for no_llseek simply be merged into patch
2?

> +	if ((file->f_mode & FMODE_LSEEK) && file->f_op->llseek)
> +		return file->f_op->llseek(file, offset, whence);
> +	return -ESPIPE;

No function change, but in general checking for the error condition
in the branch tends to be more readable.  i.e.:

	if (!(file->f_mode & FMODE_LSEEK) || !file->f_op->llseek)
		return -ESPIPE;
	return file->f_op->llseek(file, offset, whence);

