Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF23C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Apr 2022 15:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242585AbiD3PK2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Apr 2022 11:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237866AbiD3PK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 11:10:26 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F98C48390;
        Sat, 30 Apr 2022 08:07:04 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 6F40D92009C; Sat, 30 Apr 2022 17:07:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 6833C92009B;
        Sat, 30 Apr 2022 16:07:02 +0100 (BST)
Date:   Sat, 30 Apr 2022 16:07:02 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     Joshua Kinard <kumba@gentoo.org>,
        Stephen Zhang <starzhangzsd@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] MIPS: Remove incorrect `cpu_has_fpu' overrides
Message-ID: <alpine.DEB.2.21.2204301559030.9383@angie.orcam.me.uk>
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
systems.

 This v2 of the series fixes a logical mistake in change descriptions.  

 Please apply.

  Maciej
