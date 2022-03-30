Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4501C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 15:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348460AbiC3P6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 11:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348475AbiC3P6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:58:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A0D11152
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VDwf7xknVsKm4j6m+5m5/wje9BO0M2R51UqnrsEK8uY=; b=CGZDkgLHeNjoQXOlpycse36D2X
        TRbzQDZREozoG0/ENbdQtegSD3zbfShoGwwp9cdCxSFTf4yuuUq6j1drvezVsjikeRgY9Uuz3/aPU
        9hyfJ5cYk1i2cLqS2YYZNkt67Xnos23QkCu0epA87QDTzDsHYhAw81EFkxiUdO6xmfjXU+qhd8FtJ
        7CP/yfM+z9d7tNNWs+6NZlpNgQcYxCh3ugJJbm4jY/+qep5VX04p4LwB23aHepXzkQ+GU0Cy71k0B
        iYPSvz5AEreN4Hw0BBQGdsMYUNV8HmYaDWKV2qY8JdxZc9uf/YvwvKjNLzykvslb7A8zBW0rD9t3u
        ND2XtrnQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZagb-00GhUG-Ad; Wed, 30 Mar 2022 15:56:41 +0000
Date:   Wed, 30 Mar 2022 08:56:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     rpeterso@redhat.com, agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Cluster-devel] [PATCH] gfs2: Add check for mempool_alloc
Message-ID: <YkR9uT3/eRHqGtbe@infradead.org>
References: <20220311083616.2213689-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311083616.2213689-1-jiasheng@iscas.ac.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 04:36:16PM +0800, Jiasheng Jiang wrote:
> As the potential failure of mempool_alloc(),
> it could return NULL pointer.
> Therefore, it should be better to check it
> in order to avoid the dereference of the NULL
> pointer.
> 
> Fixes: e8c92ed76900 ("GFS2: Clean up log write code path")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Please explain how it could fail to start with.
