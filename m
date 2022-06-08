Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885FECCA489
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 07:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbiFHHCL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jun 2022 03:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354410AbiFHGTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:19:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2E1E207A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 23:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Dm+0N9bVBV/dPO7+JV71WRbWzJ
        rzzjZ8CWbsKt51bXUALvZWLP2zTlUSudoKjHn89MLZOQj/69F6N77qSD5yKcG6zZ4H4CZZgBw3TdX
        QNxRCPU/KspshAaX6pO+W9+TDx2y1xm/8NmdKvIyQNJayiuXoYWUJJ6vJ+etSySA2BxHeMUGaUT0z
        6npwqd0Dd0xuGwPsgb4Yo5JB4wLxMwdbq7Mw3e6/KM9kRo8EmYCczibqtFC7Dlrx3LEIrJJOLvdlx
        Osie+kMKB0uWyWwsvX1u7X8cO8aW0Y55m/alMm1CrvisMsyMN/9EgtZDuqoz8dqOC799aweGAgQIv
        5oZOCvVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyosq-00BF69-LJ; Wed, 08 Jun 2022 06:09:36 +0000
Date:   Tue, 7 Jun 2022 23:09:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, arnd@arndb.de, anshuman.khandual@arm.com
Subject: Re: [PATCH v5 2/6] mm: ioremap: Use more sensibly name in
 ioremap_prot()
Message-ID: <YqA9IL9opEie6iT8@infradead.org>
References: <20220607125027.44946-1-wangkefeng.wang@huawei.com>
 <20220607125027.44946-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607125027.44946-3-wangkefeng.wang@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
