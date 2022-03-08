Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E742FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 06:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344180AbiCHGH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 01:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244126AbiCHGHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:07:25 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF94A33E0F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 22:06:28 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2339068AFE; Tue,  8 Mar 2022 07:06:25 +0100 (CET)
Date:   Tue, 8 Mar 2022 07:06:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chao Yu <chao@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] f2fs: pass the bio operation to bio_alloc_bioset
Message-ID: <20220308060624.GA23629@lst.de>
References: <20220228124123.856027-1-hch@lst.de> <20220228124123.856027-3-hch@lst.de> <782226e0-5e7a-aec8-b9aa-e7fd7b3110a7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <782226e0-5e7a-aec8-b9aa-e7fd7b3110a7@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 10:49:06AM +0800, Chao Yu wrote:
> On 2022/2/28 20:41, Christoph Hellwig wrote:
>> Refactor block I/O code so that the bio operation and known flags are set
>> at bio allocation time.  Only the later updated flags are updated on the
>> fly.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Reviewed-by: Chao Yu <chao@kernel.org>

Is it okay for Jens to pick these two patches up in the
https://git.kernel.dk/cgit/linux-block/log/?h=for-5.18/alloc-cleanups
branch?

>
> Thanks,
---end quoted text---
