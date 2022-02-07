Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4396BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 07:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242107AbiBGHym (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 02:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347228AbiBGHxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:53:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E837C043185
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=xV5LH1K1cr5HakCxpebuA5rQNG
        swdOst5jMt0V2tjEXZ6PNL8bWUF/vgzlg1/d82/k31Oh09EtmGnDg1NuqPq8/6+GCVlR32ygRoHJv
        NiDsc0jy6eh7YedcRRtuMMucPwlwNrg4vaMise1LycUDn2mYwxzjqoF+9FiuAgLDyaKgx1qVON2bM
        85nG6rozUsr5VLrx9r0i1rf/Iq81s2fkOIjpLEjURu4osxFsKXU+GDr2FbQokAAMDgp66IO2Arb5x
        LbJ3InmcGUezLGSdqBsK1ETuCrbD64pYXqCDoVBYjIndnDGG7MUllR0KiOdWwnsxOLAdawBrHdXTX
        0efB6QtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGypr-009G4E-PS; Mon, 07 Feb 2022 07:53:19 +0000
Date:   Sun, 6 Feb 2022 23:53:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 36/75] mm: Add folio_mapcount()
Message-ID: <YgDP79cseVzf3Fip@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-37-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204195852.1751729-37-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
