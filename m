Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382F7C28B2B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 03:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiHQDmF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 23:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiHQDmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 23:42:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CAA7F0B3;
        Tue, 16 Aug 2022 20:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EFA3B81AD3;
        Wed, 17 Aug 2022 03:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D2AC433D6;
        Wed, 17 Aug 2022 03:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660707720;
        bh=JB+uYnew1TY4hlA/hravuGJRZJpftlS1oeDaF0n04pw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KPvi5Be+9yCdfykFTpkB0jkAFXiVC+34Af7CdqYqQd5AnSrEjClmDB4aMxH5sjM3H
         3LRLxiZgYyz81i55uacqlj+Y8SxuHsB36RchqpbtIX5jmTKRgmQbwcDtyFVG+wZczA
         UGpddhg7HBISAsBpENs5+EBwuMlP5CSNvW/TBSa6zovaj48c6fyrffSQ+6Mk50Yk8+
         hR4e92Xp9msKozGS6DU8SFd2kOIg5wMWkRVQxRYeFOoInZnMiVpHfwJM40eEALQyij
         r0mx0cOWVbNInTEsxGPP/SueTYRd6G8vuqHwgSmpxphm7o5dQWFOOujPm6qZpt3jOs
         yuAaZZ4OqAu7w==
Date:   Tue, 16 Aug 2022 20:41:58 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Aleksander Jan Bajkowski <olek2@wp.pl>
Cc:     hauke@hauke-m.de, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] net: lantiq_xrx200: confirm skb is allocated
 before using
Message-ID: <20220816204158.32f24172@kernel.org>
In-Reply-To: <20220815145740.12075-2-olek2@wp.pl>
References: <20220815145740.12075-1-olek2@wp.pl>
        <20220815145740.12075-2-olek2@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 16:57:38 +0200 Aleksander Jan Bajkowski wrote:
> +		netdev_err(net_dev, "failed to build skb\n");

I don't thinkg this is needed, is build_skb() using GFP_NOWARN?
Otherwise there will be an OOM splat anyway. Do check, I'm not sure.

If there won't be an OOM splat this line should be rate limited.
