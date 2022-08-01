Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D8BC00144
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 18:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiHASXU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 14:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiHASXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 14:23:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8947A2870F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 11:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gPdrcUpLAcK6oYiMvTryLalqWjaKI86cW7a7OxyjYBc=; b=B5vl6MV01f/2wsZuU83jCIsej1
        U299QIo1COaVF7aXM9uJlLZiiGM0UvF8xSkDc7PnV0FKYOwLUtgucDSqkdxayzPd66P0kl8xXWV3G
        pz/AKuSK30hVgEO8cqKR5A7M1zGlUADU2IvkTOSiILaS+avAYlubQ+41FXmq5ILrVNK6q2BtlPd6e
        3OIbmSDROAXhg/b+u1xyQw2UKzpjtB5XuLvzeC5P+UTmJ3CkKSwl9zI61UMd+CYrroe+CGN9TOugy
        otP9rE4j0YeT5fkj99FRn3tNsPQkCyU3BXtGNOYxXCA5y2FHKMiF8vGFaH5LvsvHZ9hwSUYVOUjyc
        XWNbuFlA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oIa4E-008sGW-NW; Mon, 01 Aug 2022 18:23:02 +0000
Date:   Mon, 1 Aug 2022 11:23:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     studentxswpy@163.com
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Hacash Robot <hacashRobot@santino.com>
Subject: Re: [PATCH -next] f2fs: Replace kmalloc() with f2fs_kmalloc
Message-ID: <YugaBtQcoR4XhXiQ@infradead.org>
References: <20220801092202.3134668-1-studentxswpy@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801092202.3134668-1-studentxswpy@163.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 05:22:02PM +0800, studentxswpy@163.com wrote:
> From: Xie Shaowen <studentxswpy@163.com>
> 
> replace kmalloc with f2fs_kmalloc to keep f2fs code consistency.

For that removing f2fs_kmalloc entirely would be way better.
