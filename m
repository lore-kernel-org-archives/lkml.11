Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C11C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 May 2022 18:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242984AbiE3Ss3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 May 2022 14:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242972AbiE3SsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:48:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C910A22B07;
        Mon, 30 May 2022 11:48:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4543C60DC7;
        Mon, 30 May 2022 18:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EDDC385B8;
        Mon, 30 May 2022 18:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653936501;
        bh=4UyDZ8TUbII8LVNK4nSE9ZyW2o9sZxWtKW5y9Bi3k6M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JzJExOsIYPj2R2YsOAunx4oB4q4+GzneSfq8gPGm6yWBC3J7mSJj9djObU6nNp6qa
         TTX1Nbfg+85AoXVqMur6n0Ep/4d+Mo7oJy+gIXk9qH/34wtTyO3Iw51Vdkl6xTEf97
         W5LZYD7WTWdEyi+X4mKFb8Lr+qhcZ6LSyh9MCd3D3pwXCWCPTEUmoEIIn3YHq2uIRG
         hnJV8D6zOTnYPl3ZqYw1CpqoJgkNsweZocIAE1LN7iE9dbupoOaT8IuhZy+FILJ3sp
         dM8hhUx+H9L8/U8Cx5unSGIqJ8arXvpSOG6ojYun8oJai0ycT66cc1y3eZTuY0oDXA
         xbKHrh5sFFEkw==
Date:   Mon, 30 May 2022 11:48:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     patchwork-bot+netdevbpf@kernel.org, None <conleylee@foxmail.com>,
        davem@davemloft.net, mripard@kernel.org, wens@csie.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] sun4i-emac.c: add dma support
Message-ID: <20220530114819.551f3d2f@kernel.org>
In-Reply-To: <YpRNQlPHiuNoLu3J@Red>
References: <tencent_DE05ADA53D5B084D4605BE6CB11E49EF7408@qq.com>
        <164082961168.30206.13406661054070190413.git-patchwork-notify@kernel.org>
        <YpRNQlPHiuNoLu3J@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2022 06:51:14 +0200 Corentin Labbe wrote:
> Any news on patch which enable sun4i-emac DMA in DT ?

Who are you directing this question to and where's that patch posted?
