Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A69AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 02:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiCACt6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 21:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiCACtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:49:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D1B47548
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:49:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A66F6615F3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA988C340FA;
        Tue,  1 Mar 2022 02:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646102950;
        bh=KBM7Zi6UaFQwiF1vKbsCZWoDlDUJvqp3nrY82ducTY4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P+1ZEZpHYdKhEC/GWzAkoI/qtNS7jj8rgLjWkdzynrxE1yfM8h9McK8HeuH9B5Ob9
         0jKYEj9zxjHH+Y3exJcgnUTq2RWPqpB3ar9RX5xcHvviWKqufg5aDLCD2w7FWmPYWT
         tMUn+N5tjk1H4Mz8sT3T9ukivXZBiZt27OLaqwMuqLizDFG6fcBbS7S6zsFQx6DmRb
         djFo7rOkGXNBL6ggN7ZdX31Q+Pw0rOY45Y3IajzvhURO+0fLK0LmuTvBp3/pnRJj5o
         4qzo1bCFNXsQEhB6Wt7TAp/TZ2iSoW02NP07W/I+AwayRuRpIUv/XVr12MC31hWhCH
         WwInl4n9XgbdQ==
Message-ID: <782226e0-5e7a-aec8-b9aa-e7fd7b3110a7@kernel.org>
Date:   Tue, 1 Mar 2022 10:49:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] f2fs: pass the bio operation to bio_alloc_bioset
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20220228124123.856027-1-hch@lst.de>
 <20220228124123.856027-3-hch@lst.de>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220228124123.856027-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/28 20:41, Christoph Hellwig wrote:
> Refactor block I/O code so that the bio operation and known flags are set
> at bio allocation time.  Only the later updated flags are updated on the
> fly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
