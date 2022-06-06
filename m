Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F07EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 07:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiFFHtu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 03:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiFFHts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:49:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74792CCA5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 00:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=g5yjwU5qCf2dcQ5FOj0qpbw8jN
        LOnpcLOZGz8s49Q0MxPUq2WHkAiZRXH+e8GsFF4OIp/Dqk9CBqRPm9Y/fvLHicIcIJJFThSBJoAvJ
        Inw2vta5WWQlWKwfpLItFJmo91AwEDtBPzAksR22aecHmUstAIReXlAxA4NH0AuS01z734uklNORG
        2FGSBUQIVCIawF+iB8Wq52T7A6OeapII4DqPpPAYw+tZ23mgbta0A8TPfQIRlONOr64QRDpkmj584
        8otqac1tg3PiZ/fb0uy/Yw3JrBV8R0VQTRotC0dJ6HIS+UriE+0ZXvO8kZunmCi+hmyWPi0gVOrZ8
        0DBey2zQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ny7UZ-00HZlM-NY; Mon, 06 Jun 2022 07:49:39 +0000
Date:   Mon, 6 Jun 2022 00:49:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, arnd@arndb.de, anshuman.khandual@arm.com,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 1/6] ARM: mm: kill unused runtime hook arch_iounmap()
Message-ID: <Yp2xk3fu4jvA6R1R@infradead.org>
References: <20220606074815.139265-1-wangkefeng.wang@huawei.com>
 <20220606074815.139265-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606074815.139265-2-wangkefeng.wang@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
