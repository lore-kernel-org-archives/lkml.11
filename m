Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72D6C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 05:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244400AbiF1FLM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 01:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiF1FLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:11:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AC09FCF;
        Mon, 27 Jun 2022 22:11:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D08B61784;
        Tue, 28 Jun 2022 05:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205F3C341C6;
        Tue, 28 Jun 2022 05:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656393067;
        bh=gRITldOs4wFjJJ/Yq+ASt8gLd+uLO3gYyD/lQOZHrqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hg/plIKhrf8qrDSTcJYKhT1RGIr4RqDfcYcCSW3eMK10FeVlkwyDLCHfbgMiqB5Wk
         JwEfFYAqNZPov9K81/sAvff2wXm1RhWjJqa+qTglgwHESfNDkupNnOCaI6JgzxCzzs
         ujt4GgSegDKOxupcXcQVtmk09aI4OOXHGrluD5Xc5BIjjJwbBBNF9Vh/5G9tsYc8pW
         VJcUmpyr09GOSzm8ixltVD+kTm7i3E+6KfuP8S2nMTVPJkIpeSMI64hUEcYByaXTVH
         cimlXr7ypucRtrCfLcZFZCYlkffbUcXuxWH+9XxWotNFPWBaUfx6bvKa1IrKpGP2BG
         T/b3TtnqHGKQA==
Date:   Mon, 27 Jun 2022 22:11:05 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: sfp: fix memory leak in sfp_probe()
Message-ID: <20220627221105.5a5feb7c@kernel.org>
In-Reply-To: <20220624044941.1807118-1-niejianglei2021@163.com>
References: <20220624044941.1807118-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2022 12:49:41 +0800 Jianglei Nie wrote:
> sfp_probe() allocates a memory chunk from sfp with sfp_alloc(). When
> devm_add_action() fails, sfp is not freed, which leads to a memory leak.
> 
> We should use devm_add_action_or_reset() instead of devm_add_action().

Please add a Fixes tag referencing the commit which added the bug.
The subject for the next version should be start with [PATCH net v3].
