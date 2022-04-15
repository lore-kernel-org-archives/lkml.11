Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867A9C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 19:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347781AbiDOTEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 15:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347623AbiDOTER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:04:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E014D9E9B;
        Fri, 15 Apr 2022 12:01:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED8FCB82ECD;
        Fri, 15 Apr 2022 19:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850EBC385A5;
        Fri, 15 Apr 2022 19:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650049305;
        bh=Z5tq7WhsfYCtbsBpe6vYTV676bSOimMfYuf424iszwE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aV+e6hc/YF4o11T2Oms1tvdnTdFOUTPWcEW2d9B7X47iV5IgdOvthDZQHzb5HZQ23
         9l9KaD4MeUZOiH7SzithuFtnSoeUlv/o4Lpo4YyDME41z7B501NpoJGiFkRmF45BSM
         jpyxJ9WXisbunkgGL0p8RFCpAeZzaW27PAt61aO7Tgz+/sbSDIzh8zAgrIZysp6OF2
         gXBQs2I8YNN814UlqT3gGxH2hBVzNxDKl6FI3DfLXH/QscMkcUyHAP2eGpbQs4Qbps
         AiCzVD3nGWDsUYP0xIhez7Mqfq6z9PNYNpuBjq7MXu6z9N8bw9SSf6ikHavUmvlaZP
         xz1wDzi1VbD+w==
Date:   Fri, 15 Apr 2022 21:01:39 +0200
From:   Jakub Kicinski <kuba@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <davem@davemloft.net>,
        <pabeni@redhat.com>
Subject: Re: [PATCH net] net: lan966x: Make sure to release ptp interrupt
Message-ID: <20220415210139.2d338f4b@kernel.org>
In-Reply-To: <20220413195716.3796467-1-horatiu.vultur@microchip.com>
References: <20220413195716.3796467-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 21:57:16 +0200 Horatiu Vultur wrote:
> When the lan966x driver is removed make sure to remove also the ptp_irq
> IRQ.

I presume it's because you want to disable the IRQ so it doesn't fire
during / after remove? Would be good to have such justifications
spelled out in the commit message in the future!

> Fixes: e85a96e48e3309 ("net: lan966x: Add support for ptp interrupts")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
