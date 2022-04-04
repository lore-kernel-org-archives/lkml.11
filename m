Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36333C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 04:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377239AbiDDEy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 00:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377246AbiDDEyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:54:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4923A73A;
        Sun,  3 Apr 2022 21:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=SO3cNp9025nF4YRkaTNn4JftZQ
        wZn7tgTUBFpqRDi+GCLIrjw0ZWvrIjdrZlYBtzLhepMYHpS9ZMJu1o3ERAjPG4qfeq3/Y0/15yo4v
        ImnyJkDepkB1vKkVgQxnG4opNKjZi/IKhi4jLeqFLe1hA8DXhzFkO8Kwrl2tao8vZT3FNgEx0ug+m
        VzsydoxeKsEqxI7Knv3SxhwGgMLQfJdnWhmYrAJx576rEwdeUlRCYkFvjw1VH0u1YJFWk+tbTNlfW
        hm4v4Q3x4xx8AuXNHi5uNK9VkV2Sihk3RytNYUALOPtyRcPiKg4t1NWY7N273YZCHHNSK9LyYo6I7
        Xbj8RQhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbEhh-00D5bx-Jq; Mon, 04 Apr 2022 04:52:37 +0000
Date:   Sun, 3 Apr 2022 21:52:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 2/2] exfat: reduce block requests when zeroing a
 cluster
Message-ID: <Ykp5lXcYSDPB/Arq@infradead.org>
References: <HK2PR04MB3891C5C2430056F553BC51A681E39@HK2PR04MB3891.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK2PR04MB3891C5C2430056F553BC51A681E39@HK2PR04MB3891.apcprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
