Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C047BC43217
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 16:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380891AbiBUQnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 11:43:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380788AbiBUQnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:43:16 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 380B4220C6;
        Mon, 21 Feb 2022 08:42:53 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 79B1E92009C; Mon, 21 Feb 2022 17:42:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 6B0B592009B;
        Mon, 21 Feb 2022 16:42:52 +0000 (GMT)
Date:   Mon, 21 Feb 2022 16:42:52 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenhuacai@kernel.org, tsbogend@alpha.franken.de
Subject: Re: [RFC PATCH 2/3] MIPS: io.h use barrier terminology from
 asm-generic
In-Reply-To: <20220221145531.10479-3-jiaxun.yang@flygoat.com>
Message-ID: <alpine.DEB.2.21.2202211628570.56785@angie.orcam.me.uk>
References: <20220221145531.10479-1-jiaxun.yang@flygoat.com> <20220221145531.10479-3-jiaxun.yang@flygoat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2022, Jiaxun Yang wrote:

> So we can share understanding of those barriers with other archs
> and hopefully one day we will be able to switch asm-generic.

 You're mixing the ordering of DMA WRT MMIO here with the ordering of MMIO 
WRT itself, and this single line of justification does not explain why it 
is a change worth making.  You're free to define additional DMA barriers 
if we're missing some.

  Maciej
