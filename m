Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD80C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Apr 2022 14:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378071AbiD2PA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Apr 2022 11:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378062AbiD2PA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:00:27 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8691EB0A54;
        Fri, 29 Apr 2022 07:57:07 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id A2CDF92009C; Fri, 29 Apr 2022 16:57:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 9E56892009B;
        Fri, 29 Apr 2022 15:57:06 +0100 (BST)
Date:   Fri, 29 Apr 2022 15:57:06 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     Joshua Kinard <kumba@gentoo.org>,
        Stephen Zhang <starzhangzsd@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] MIPS: Remove incorrect `cpu_has_fpu' overrides
Message-ID: <alpine.DEB.2.21.2204291523460.9383@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Forcing `cpu_has_fpu' to 1 is unsupported as it breaks the `nofpu' kernel 
parameter and more recently also the CONFIG_MIPS_FP_SUPPORT configuration 
option.  Remove the broken `cpu_has_fpu' overrides then for IP27 and IP30 
systems.  Please apply.

  Maciej
