Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74BCC00140
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Aug 2022 05:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiHUF5u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Aug 2022 01:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUF5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 01:57:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DBF15FD2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 22:57:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3F24A68AA6; Sun, 21 Aug 2022 07:57:45 +0200 (CEST)
Date:   Sun, 21 Aug 2022 07:57:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 14/19] nvme-rdma: Fix error check for ib_dma_map_sg
Message-ID: <20220821055745.GA26064@lst.de>
References: <20220819060801.10443-1-jinpu.wang@ionos.com> <20220819060801.10443-15-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819060801.10443-15-jinpu.wang@ionos.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't send me just two random patches out of a series, as I
have no way to review them.  If the patches are independent, send them
independently and if they depend on common prep work send the entire
series to everyone.
