Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB82C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 19:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiGOThx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 15:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiGOThs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:37:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1372599DE;
        Fri, 15 Jul 2022 12:37:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63DB8B82DFC;
        Fri, 15 Jul 2022 19:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6E3C34115;
        Fri, 15 Jul 2022 19:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657913865;
        bh=pQeC61oCW4TCk5zK0NUBRTJ+5ZqDV+FqvjopnaocqQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hz9VAhnsU2VhzPXPRjQf5IHGRah/cVdTcp8YRKVPslTSljExRhtCMwc7UAk/MNNmU
         frrUoqJfSmpzW3hWJBBXFx8qNWrfO4ZHWdOh3/uLBMZlalNpBqHep8Pyfl4L1Xt6zM
         GAF71ZN+mDmXAcVVxupBo2jR97mVU17liwOD32EksKRaHMNDZw+LMrKcH7xHwxxMxk
         Ifo3D2MH8fIuAdOpsl2vR+V/mdmi5VyfnJYd2aF9gnXgtavHPHkIQgZ+hpCD6OOoYB
         bfF6k8FNoqKvkkET/Bs4v6WYRzsGQmTdmZCkWmSFsIk5WVwRSZsQSYBahw/kzqUU/Q
         sWSSwkdMSELHg==
Date:   Fri, 15 Jul 2022 12:37:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: dsa: qca8k: move driver to qca dir
Message-ID: <20220715123743.419537e7@kernel.org>
In-Reply-To: <62d12418.1c69fb81.90737.3a8e@mx.google.com>
References: <20220713205350.18357-1-ansuelsmth@gmail.com>
        <20220714220354.795c8992@kernel.org>
        <62d12418.1c69fb81.90737.3a8e@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 03:57:46 +0200 Christian Marangi wrote:
> > Does the split mean that this code will move again?
> > If so perhaps better to put this patch in the series 
> > that does the split? We're ~2 weeks away from the merge 
> > window so we don't want to end up moving the same code
> > twice in two consecutive releases.  
> 
> What to you mean with "will move again"?
>  
> The code will be split to qca8k-common.c and qca8k-8xxx.c
> And later qca8k-ipq4019.c will be proposed. 
> 
> So the files will all stay in qca/ dir.
> 
> Or should I just propose the move and the code split in one series?

Yup that's what I prefer.

> Tell me what do you prefer.
