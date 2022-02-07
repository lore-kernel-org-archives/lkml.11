Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12D6C433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 07:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348714AbiBGHxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 02:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344919AbiBGHwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:52:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571D3C0401C9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=h0hQ0gHm64vzVCdD4axk0UtHMb
        03MTX4oltnZDaL/ERiDC0OFihpUsXBg6RpSvWvkQR/ZkxDFCWwylcu5Vh6U1xWmlWvMyiwCbIZVAc
        tWskv1FnPVwIqlWAOGJw3LcDwORdJkoVE77uRU7CM3SPLWe3sAdyEEpf+ANZrVLalYj4CJk2cgss9
        jmf6RDOwefPk5y+zBi1gVGY/JQ+eqR6xPWlxU75lA/tQi9cKkYRbZNlFlAnHgRmn6V2DXO0gFyqpY
        aeGt4CU8CNRvcf5sCCyeyAkmzyMIWC92oDH98B2Q7WF1ASt1CB0YHpl2wsckZylPYTtTR7K2O1k7b
        nIOOaSgQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGyop-009G1Q-Q3; Mon, 07 Feb 2022 07:52:15 +0000
Date:   Sun, 6 Feb 2022 23:52:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 35/75] mm: Turn head_compound_mapcount() into
 folio_entire_mapcount()
Message-ID: <YgDPr/+BgsyQusod@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-36-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204195852.1751729-36-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
