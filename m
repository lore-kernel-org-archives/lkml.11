Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B3AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 05:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiBOFfn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 00:35:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiBOFfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:35:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2C1B7D;
        Mon, 14 Feb 2022 21:35:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C55661338;
        Tue, 15 Feb 2022 05:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BE0C340EC;
        Tue, 15 Feb 2022 05:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644903331;
        bh=R9thlo1WvN2/WhvdvZoFRszkO4H/txvCZdYcwEipM+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UhqnI0X5EVWRtkgsBUlFjAqF00M6mYTcZ4qn7QgLXc+qxAs6ViONZJ0iIfOyRuBgi
         moWmUxjZklkXG/LJNFHTxlJdmhHOE+3Pekj+LZGJ7mIMjXGOEldLddJfyP11esKT9D
         pOH20HYRIRmHXEPTt/APHULaSl6JW1IGnvTmxhFD71X1J8R5q3i0LU+XMsZjduR6I7
         bdM5nPCQqhD5+LXJN/bhZe6W9oRjDtgciAPOwBZCl/erHE09C4MWear3QcN1VMhnwx
         Pw7VZ9F/+5mB3+iu+f22OtpC3aGVUDXa+DGytpoldSijVszlT7DI3lZVzuG/YaepUq
         SaV2EhPRj15Uw==
Date:   Tue, 15 Feb 2022 11:05:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>
Cc:     broonie@kernel.org, laurent.pinchart@ideasonboard.com,
        arnd@arndb.de, christophe.jaillet@wanadoo.fr,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: shdma: Fix runtime PM imbalance on error
Message-ID: <Ygs7nwawFmaApt9+@matsya>
References: <1642311296-87020-1-git-send-email-lyz_cs@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642311296-87020-1-git-send-email-lyz_cs@pku.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-01-22, 21:34, Yongzhi Liu wrote:
> pm_runtime_get_() increments the runtime PM usage counter even
> when it returns an error code, thus a matching decrement is needed on
> the error handling path to keep the counter balanced.

Applied, thanks

-- 
~Vinod
