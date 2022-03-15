Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C08C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 07:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345483AbiCOHgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 03:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345492AbiCOHgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:36:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2F54B1F5;
        Tue, 15 Mar 2022 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=zi+xvPKDntF14F7jNL0IAJnYe7
        CIrv6Cl8TGyXU8PAPqFzkF5YFZY8+oVYNCPocs6Uxu2LNJByI247kYVpz2e3qrUPcZtj/6r2uVdrR
        B8KAESZ7iMLS9gL/zsOPgTsWU4jkKm4ua2QYv1HSUTtK81h/oEilC4h7ahCmQsz+jHwL47qrDvurh
        v1rdnVcfS5bO+1dDdJr9pmB8OnZGhSOKBMUTQCmoV64FjZMN2wQ9CnH+fluVX1NQMBcyAHOw0IPRz
        fadmeDrcJW1f34uZ4GHdi9l5RsWCbYBQLmOPGcrW7g+L3x051zzuow+qcL39OS8oE9yauMfkq41mA
        0ACT7zlg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nU1i9-0088Av-JY; Tue, 15 Mar 2022 07:35:17 +0000
Date:   Tue, 15 Mar 2022 00:35:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guo Xuenan <guoxuenan@huawei.com>
Cc:     willy@infradead.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        houtao1@huawei.com, fangwei1@huawei.com,
        hsiangkao@linux.alibaba.com
Subject: Re: [PATCH] iomap: fix an infinite loop in iomap_fiemap
Message-ID: <YjBBtZHud8r7ItnX@infradead.org>
References: <20220315065745.3441989-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315065745.3441989-1-guoxuenan@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
