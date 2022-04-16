Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F8CC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Apr 2022 05:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiDPFow (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Apr 2022 01:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiDPFot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 01:44:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC2DAC916;
        Fri, 15 Apr 2022 22:42:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4256768AFE; Sat, 16 Apr 2022 07:42:15 +0200 (CEST)
Date:   Sat, 16 Apr 2022 07:42:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH] fs-writeback: Flush plug before next iteration in
 wb_writeback()
Message-ID: <20220416054214.GA7386@lst.de>
References: <20220415013735.1610091-1-chengzhihao1@huawei.com> <20220415063920.GB24262@lst.de> <cf500f73-6c89-0d48-c658-4185fbf54b2c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf500f73-6c89-0d48-c658-4185fbf54b2c@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think the root cause is fsync gets buffer head's lock without locking 
> corresponding page, fixing 'progess' and flushing plug are both 
> workarounds.

So let's fix that.
