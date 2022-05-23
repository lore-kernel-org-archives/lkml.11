Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0D4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 May 2022 20:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiEWUXn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 16:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiEWUXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:23:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4214E0B3;
        Mon, 23 May 2022 13:23:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E38D614B6;
        Mon, 23 May 2022 20:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45343C385AA;
        Mon, 23 May 2022 20:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653337418;
        bh=cRmLCYxqZ/oPtyUyAbrJ2vSaCtJhJTaXonVzm1gzzZc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NKEVA1i2oilfkHiewDOhRCD2VgzU1ad8Meq+dybp0PEy6huQ+sA3jCZFN5B3i1p4d
         aRYuziRfx0xW0yhhxyrZns9P/1t2w7+H9uU2sxzu80/1JGRsKtt/rm0ybMQ9OLJIWG
         e8Avm6N7lI1+kCy5871Ae8jJr3GAFOKjB2jGLj4FI4ileAGPymwlmfonXfCTbb9xxC
         aZsaB4ZlkKHmOhwUJrFihy0GKOaOxUsG34Bz1WdBxHvLAcz3Ms+pc4KtNG+gLpktCx
         LrLFA9YVBGMML3Tt9+tMZRG+GpwUqWhE4CixX67CBqFQJg1Hv9GvMN/fRR39N5hRFx
         TO1c31n0Wvamg==
Date:   Mon, 23 May 2022 13:23:36 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Vitaly Bordug <vbordug@ru.mvista.com>,
        Dan Malek <dan@embeddededge.com>,
        Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: fs_enet: sync rx dma buffer before reading
Message-ID: <20220523132336.073965a5@kernel.org>
In-Reply-To: <20220521104430.1212bed5@kernel.org>
References: <20220519192443.28681-1-mans@mansr.com>
        <03f24864-9d4d-b4f9-354a-f3b271c0ae66@csgroup.eu>
        <yw1xmtfc9yaj.fsf@mansr.com>
        <b11dcb32-5915-c1c8-9f0e-3cfc57b55792@csgroup.eu>
        <20220520104347.2b1b658a@kernel.org>
        <d8cc1123-30d2-d65b-84b1-2ffee0d50aab@csgroup.eu>
        <20220521104430.1212bed5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 May 2022 10:44:30 -0700 Jakub Kicinski wrote:
> > Well, I say the contrary.
> > 
> > On the mainline the patch may be applied as is, it won't harm.
> > 
> > However, it is gets applied to kernel 4.9 (based on the fixes: tag), it 
> > will break the driver for at least powerpc 8xx.  
> 
> I see, we should make a note of that in the commit message so it doesn't
> get sucked into stable.
> 
> > I don't know how SWIOTLB works or even what it is, does any of the 
> > microcontrollers embedding freescale ethernet uses that at all ?  
> 
> AFAIU SWIOTLB basically forces the use of bounce buffers even if the
> device can reach the entire DRAM. I think some people also use it for
> added security? IDK. I mostly use it to check if I'm using the DMA API
> "right" :)

If what I said makes sense please repost the patch, the current version
has been dropped from patchwork already.
