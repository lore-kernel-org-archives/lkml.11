Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF3DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Apr 2022 02:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244576AbiDTCKG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 22:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343625AbiDTCKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:10:02 -0400
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD83111150
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:07:17 -0700 (PDT)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 7032F22565;
        Wed, 20 Apr 2022 02:07:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 0E06B2002C;
        Wed, 20 Apr 2022 02:07:14 +0000 (UTC)
Message-ID: <53b4a92efb83d893230f47ae9988282f3875b355.camel@perches.com>
Subject: Re: [PATCH] octeon_ep: Remove unnecessary cast
From:   Joe Perches <joe@perches.com>
To:     Haowen Bai <baihaowen@meizu.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Apr 2022 19:07:14 -0700
In-Reply-To: <1650419232-7982-1-git-send-email-baihaowen@meizu.com>
References: <1650419232-7982-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kg541wpz5r8mbtaraiymomu81xh8837f
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 0E06B2002C
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18NG+yv3Q8u1koYHE0CnuBdl8L3tatgtgs=
X-HE-Tag: 1650420434-864539
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-20 at 09:47 +0800, Haowen Bai wrote:
> Fix the following coccicheck warning:
> 
> ./drivers/net/ethernet/marvell/octeon_ep/octep_rx.c:161:18-40: WARNING:
> casting value returned by memory allocation function to (struct
> octep_rx_buffer *) is useless.
[]
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
[]
> @@ -158,8 +158,7 @@ static int octep_setup_oq(struct octep_device *oct, int q_no)
>  		goto desc_dma_alloc_err;
>  	}
>  
> -	oq->buff_info = (struct octep_rx_buffer *)
> -			vzalloc(oq->max_count * OCTEP_OQ_RECVBUF_SIZE);
> +	oq->buff_info = vzalloc(oq->max_count * OCTEP_OQ_RECVBUF_SIZE);
>  	if (unlikely(!oq->buff_info)) {
>  		dev_err(&oct->pdev->dev,
>  			"Failed to allocate buffer info for OQ-%d\n", q_no);

probably better to use kvcalloc or maybe vcalloc if oq->max_count is
always expected to be huge.

OCTEP_OQ_RECVBUF_SIZE is pretty small (just a pointer and a u64).


