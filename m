Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55194C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 17:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbiCDR5O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 12:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239907AbiCDR5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:57:12 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 066161CBAA6;
        Fri,  4 Mar 2022 09:56:24 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 37CC692009C; Fri,  4 Mar 2022 18:56:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3072C92009B;
        Fri,  4 Mar 2022 17:56:23 +0000 (GMT)
Date:   Fri, 4 Mar 2022 17:56:23 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        kernel test robot <lkp@intel.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v3] mips: DEC: honor CONFIG_MIPS_FP_SUPPORT=n
In-Reply-To: <20220304162427.27276-1-rdunlap@infradead.org>
Message-ID: <alpine.DEB.2.21.2203041755430.47558@angie.orcam.me.uk>
References: <20220304162427.27276-1-rdunlap@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022, Randy Dunlap wrote:

> Include the DECstation interrupt handler in opting out of
> FPU support.

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

 Thank you!

  Maciej
