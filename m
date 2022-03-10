Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227BFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 16:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244317AbiCJQtZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 11:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244335AbiCJQtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:49:16 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E154E0A0F;
        Thu, 10 Mar 2022 08:48:02 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 705A792009C; Thu, 10 Mar 2022 17:48:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 6995C92009B;
        Thu, 10 Mar 2022 16:48:01 +0000 (GMT)
Date:   Thu, 10 Mar 2022 16:48:01 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Christoph Hellwig <hch@lst.de>
cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Huang Pei <huangpei@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [BUG] new MIPS compile error on v5.15.27
In-Reply-To: <20220310162818.GA4436@lst.de>
Message-ID: <alpine.DEB.2.21.2203101640560.47558@angie.orcam.me.uk>
References: <D148EFBD-55E0-449A-AD2A-12C80ABD4FC4@goldelico.com> <20220310162818.GA4436@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022, Christoph Hellwig wrote:

> Please fix <asm/asm.h>.   The most trivial fix might be to only defined
> END() under __ASSEMBLY__, although in the long run it probably wants a
> better name as well.

 FWIW the END macro has its roots in IRIX if not MIPSCO.  It's been around 
for some 30 years if not more.  MIPS/ULTRIX may have had it too, as it's 
originally all ECOFF stuff, i.e. `.end', `.ent', `.frame', etc. assembly 
pseudo-ops for symbol/debug information.

  Maciej
