Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEAEC00140
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 02:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243630AbiHSCjR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 22:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiHSCjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 22:39:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223F44DB0D;
        Thu, 18 Aug 2022 19:39:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B296D61488;
        Fri, 19 Aug 2022 02:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A4FC433D6;
        Fri, 19 Aug 2022 02:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660876751;
        bh=m87u2q3r+0BovI98LmxRpA15dVnsXyZidaSe9e1Pcg8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GJyViPVp5c5ju7QAk4T/fsrIn0LjI0+WFcjMxxbcMgK2KchKayD1AGa+d+mmEHYxP
         MyVpcgP+RHwl5iB4rswKPV/dpvpcJNULiU0Ne30p/ijM3zM/jWt6mQDZzCl3NgrI2A
         J7NeuTSBN1We7GKXjfVSK/GEpXEdCNcrDBEBBMP59MYMU50GJr3Lxe92X7PbkliBR1
         losYe5unRDVgcmERAIT1lbeAIZtRYN8r5y7ZbPMIjvCQ8vBav8QBeB+JLyZV6NIOry
         gKcAwB8tk/8zeSFGxtLRN3fCrUsmxwRwxAibhoPhcOGD2/IxT7wPRGS7khx6touxcL
         vBmOmptvOYwTg==
Date:   Thu, 18 Aug 2022 19:39:10 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     "Denis V. Lunev" <den@virtuozzo.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>
Subject: Re: [PATCH -next] net: neigh: use dev_kfree_skb_irq instead of
 kfree_skb()
Message-ID: <20220818193910.50100711@kernel.org>
In-Reply-To: <6fab4f14-3afd-2576-e539-da37408f6b84@huawei.com>
References: <20220818043729.412753-1-yangyingliang@huawei.com>
        <79784952-0d15-8a4a-aa8d-590bc243ab5e@virtuozzo.com>
        <20220818093224.2539d0bc@kernel.org>
        <6fab4f14-3afd-2576-e539-da37408f6b84@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 09:44:29 +0800 Yang Yingliang wrote:
> On 2022/8/19 0:32, Jakub Kicinski wrote:
> > Please put [PATCH net] as the tag for v2, this is a fix, not -next
> > material.  
> OK.
> I don't find the commit 66ba215cb513 ("neigh: fix possible DoS due to 
> net iface start/stop loop")

I see where the confusion is coming from. It's too fresh to have made
it to Linus. It's part of this pull request:

https://lore.kernel.org/all/20220818195549.1805709-1-kuba@kernel.org/

but Linus has not pulled yet.

I believe if something is in the "pending-fixes" branch of linux-next:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=pending-fixes

you can consider it to be an immediate fix, rather than -next material.

Not sure if that makes sense but that's the best I can do explaining
it...
