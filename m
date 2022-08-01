Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3FDC19F2D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 19:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiHATby (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiHATbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:31:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600A02ED79;
        Mon,  1 Aug 2022 12:31:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA06561302;
        Mon,  1 Aug 2022 19:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EA8C433D6;
        Mon,  1 Aug 2022 19:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659382304;
        bh=stzSfZcFD/Pbjg5V9MaKRmWf+zkGua0ZY7XxloWri/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dIXnRSSX3lSa7c7S9EEX/HV1EsFkw5rhu2wFTOubf59jZuo4ZMqcc57wt5aiYiL1A
         JgIBzo/SuN84td6eJSogDbGeFtDjX8Rn4M5346ltqro4HUjyGFPvH9fB50NNSAhrrf
         PvnbyOqGZfceGfCa7oPl1vRoz1TTlPBCnXD9yxkdZTmFEwYTW9u8tpOhkA5wu93hed
         No0PPHygckDyLVdhT9J5tfP47MGzn8i+S9Y+77T6SxCcrzRQrxs68r1l91YeqFSYj7
         kPbTimUiTTz5JP0GscunhZnDy21HL22N2H1VNySFTEIO2SRxh0R4FONUaqaLOttmlK
         inK32oNlUNa3Q==
Date:   Mon, 1 Aug 2022 12:31:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Jiawen Wu" <jiawenwu@trustnetic.com>
Cc:     "'Christophe JAILLET'" <christophe.jaillet@wanadoo.fr>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'Eric Dumazet'" <edumazet@google.com>,
        "'Paolo Abeni'" <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: txgbe: Fix an error handling path in txgbe_probe()
Message-ID: <20220801123142.559ca297@kernel.org>
In-Reply-To: <02a101d8a552$0e704650$2b50d2f0$@trustnetic.com>
References: <082003d00be1f05578c9c6434272ceb314609b8e.1659285240.git.christophe.jaillet@wanadoo.fr>
        <02a101d8a552$0e704650$2b50d2f0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2022 10:54:44 +0800 Jiawen Wu wrote:
> On Monday, August 1, 2022 12:34 AM, Christophe wrote:
> > A pci_enable_pcie_error_reporting() should be balanced by a corresponding
> > pci_disable_pcie_error_reporting() call in the error handling path, as already
> > done in the remove function.
> 
> Thanks Christophe, it's right.
> Reviewed-by: Jiawen Wu <jiawenwu@trustnetic.com>

Your reply did not make it to the list:
https://lore.kernel.org/r/02a101d8a552$0e704650$2b50d2f0$@trustnetic.com+898582B7F010EAA4/
not sure why but I wanted to let you know.

Thanks for reviewing the fix promptly!
