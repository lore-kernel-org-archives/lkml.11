Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6673EC43217
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 22:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiCIWDq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 17:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiCIWDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:03:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E380178044
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:02:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A895B823DE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 22:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1F4C340F9;
        Wed,  9 Mar 2022 22:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646863360;
        bh=54nrL5lVac8LjdxWYEk3XM1hS8aXwfsY4Gwc979sn2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LKxn4zeRbr8UReEWIs2MYfw36rLOgozvWXOp+NyjCvgHv+6MgLd1YGuSBvie5u8n9
         8UFrc1/Yr4WuhBQw65VLb0k0trc19wx7IDDU7x8i1W9RBtPJ5mSpIM7k5ZqX8FpK9L
         SSPKSJtG7oU06ExTFuxO3mvuZ8z8K/XsmypaqOy9TJDNhRdCD3km82TXlM0cn68M43
         aQuPnms6ZQFLs6qA4DkK8XTLIK3pIP3cCAlF5fmBAjuc2S5HQvfL4iirvKkljeWEr3
         MUX1ip+SySLMxSrrou31D1w7JEP1A9YYB9Wmv5Edi3zGx+O73hHAefG95eEerCAuxp
         C2Fn768+zpwrw==
Date:   Wed, 9 Mar 2022 14:02:38 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] f2fs: pass the bio operation to bio_alloc_bioset
Message-ID: <Yikj/k/59no8yyLQ@google.com>
References: <20220228124123.856027-1-hch@lst.de>
 <20220228124123.856027-3-hch@lst.de>
 <782226e0-5e7a-aec8-b9aa-e7fd7b3110a7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <782226e0-5e7a-aec8-b9aa-e7fd7b3110a7@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01, Chao Yu wrote:
> On 2022/2/28 20:41, Christoph Hellwig wrote:
> > Refactor block I/O code so that the bio operation and known flags are set
> > at bio allocation time.  Only the later updated flags are updated on the
> > fly.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>

> 
> Thanks,
