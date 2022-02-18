Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FCBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 04:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiBREw3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 23:52:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiBREwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:52:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC39013FAB;
        Thu, 17 Feb 2022 20:52:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82AD5B82499;
        Fri, 18 Feb 2022 04:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36B7C340E9;
        Fri, 18 Feb 2022 04:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645159923;
        bh=uVJfEu+xW11wsO1oXDxEUy1ONTXTBEQ/j80dZ6m2VGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ateDoHk2L90L0ImxhAfpFwST64FplrE+8OFDL57JFyTYPmS6C5RNZqjHNONH7efIE
         FKwHD0TmzKJd5cQgCXYsM6gg9DVk1k5Fk7A/BEr9JtjtHy3U7661PLg192gqs9fe40
         KzyL98R8tej6QN3yAR55F1XrZ/ythnF3NaBVQegOfecd4Et+OeYkKY4WYZc9G8ulR1
         RUMIfhB7K9k76VjNvWcnJDm0fxGrlFRbkG1flVydn2i09ahJ0tzlrOvThYKvl7RxJW
         8I7Ltc5mTL1Lqx+Nvdfj5mFfIv3q2woMftNKSnQJT3C8coJP8kpKYeH29EeCDLHOL9
         /Odiiu3/xkSkw==
Date:   Thu, 17 Feb 2022 20:52:01 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>
Cc:     netdev@vger.kernel.org, Taras Chornyi <taras.chornyi@plvision.eu>,
        Mickey Rachamim <mickeyr@marvell.com>,
        Serhiy Pshyk <serhiy.pshyk@plvision.eu>,
        Volodymyr Mytnyk <vmytnyk@marvell.com>,
        Taras Chornyi <tchornyi@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: prestera: flower: fix destroy tmpl in
 chain
Message-ID: <20220217205201.3909b634@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1645022624-2010-1-git-send-email-volodymyr.mytnyk@plvision.eu>
References: <1645022624-2010-1-git-send-email-volodymyr.mytnyk@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 16:43:44 +0200 Volodymyr Mytnyk wrote:
> Fixes: fa5d824ce5dd ("net: prestera: acl: add multi-chain support offload")
> 
> Signed-off-by: Volodymyr Mytnyk <vmytnyk@marvell.com>

Ah, and please don't put empty lines between tags.
