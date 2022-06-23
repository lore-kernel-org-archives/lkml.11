Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1746C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 19:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiFWTeT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiFWTde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:33:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8E34EDFA;
        Thu, 23 Jun 2022 12:14:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA2E4B824BD;
        Thu, 23 Jun 2022 19:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD72C341C0;
        Thu, 23 Jun 2022 19:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656011670;
        bh=wC/mFFOXrER8itkfHbAsJlzoussVbkCh7WfuQkWX524=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Uuir36EaxLJoFbQNhTM3TJD0TQfF9zlezPxAKPYt05pIDsPDlyU9JhpvtPJceomx+
         EBCHpxQgx59JsnVOVGJAnjEM5tAdsD+fzelCIqHSbMd7vyjGkMYJG7Qocuw9cJaZRb
         JvalXj+2PXrN2eSOqaJMSyPrfDmtFB7JlvWesQPR4saJpgDirsRxf1j67tCsz2fsk8
         0/V3GUER1ZlLysdquV50C0YuYlOUwzRTKBxtTjkp7jg94n4RXRwn9XrvCSmy7VoQQZ
         b/4YjlLKtmx23DzBdNYYN5gN8udxWdt5B7wAW6S3z/KTjLa37cFV8PfNKRVA6V31OJ
         8X3w4AOIj5f3g==
Date:   Thu, 23 Jun 2022 12:14:21 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sfp: fix memory leak in sfp_probe()
Message-ID: <20220623121421.3bc054d2@kernel.org>
In-Reply-To: <20220623070914.1781700-1-niejianglei2021@163.com>
References: <20220623070914.1781700-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 15:09:14 +0800 Jianglei Nie wrote:
> sfp_probe() allocates a memory chunk from sfp with sfp_alloc(), when
> devm_add_action() fails, sfp is not freed, which leads to a memory leak.
> 
> We should free the sfp with sfp_cleanup() when devm_add_action() fails.

.. and please add a Fixes tag
