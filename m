Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB03C433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jun 2022 03:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349469AbiFADnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 23:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiFADn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:43:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786D384A01;
        Tue, 31 May 2022 20:43:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9DA161139;
        Wed,  1 Jun 2022 03:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26860C385B8;
        Wed,  1 Jun 2022 03:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654055006;
        bh=OWd2/VzGcHSJVAYzt1o0X8eGieTIiCjDOqFC4+fczqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ahdP1rMHIBgY+/vGYg9zJDWrhhOqu1UYy19CTBGEt2+Aaxns2K1svmgRXQAwHj8lF
         /fvX15gm4GZcK0DH+hPLuhEhdRKgwAbyeyy4lSoPjv/ck50IfBoy/QK74627Fb2SDx
         WwPFx9yG3SeA3gkR5L7Deljunzi4URdVOxvFdiJ7xvkEWFaX9fYO2Fu/Q/e1r1loos
         AOFYxqdrlrLLbVoPsb4tnx7Q1p6OPIfmZqsf4ArLJguI6laJKEzwSzsifxIhw+7L4W
         HGZT4Og4o4MM+TEfQFVoyTFQDkFLN6EOiLy98Snarc1j3jKcq0nfIvntKDLEPLzM5G
         LS9oRdtxuOCGA==
Date:   Tue, 31 May 2022 20:43:25 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Menglong Dong <imagedong@tencent.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/3] net: skb: use auto-generation to
 convert skb drop reason to string
Message-ID: <20220531204325.5ba1362f@kernel.org>
In-Reply-To: <CADxym3bQ96s_tsQeE_1_TFNafTvzQfRr9WLB40urZCgn4a2C0A@mail.gmail.com>
References: <20220530081201.10151-1-imagedong@tencent.com>
        <20220530081201.10151-3-imagedong@tencent.com>
        <20220530131311.40914ab7@kernel.org>
        <CADxym3bQ96s_tsQeE_1_TFNafTvzQfRr9WLB40urZCgn4a2C0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2022 11:27:41 +0800 Menglong Dong wrote:
> > > +#include <linux/kernel.h>  
> >
> > Why?  
> 
> Oh, you noticed it. To simplify the code in dropreason_str.c, as
> EXPORT_SYMBOL() is used. Okay, I'll move it to the generation
> part.

IMHO you can move the EXPORT_SYMBOL() to skbuff.c, with a comment
saying that the array itself is in an auto-generated source.
Avoid avoid to "echo" both the EXPORT and the include.
