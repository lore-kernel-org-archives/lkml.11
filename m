Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C56C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 11:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348378AbiETLI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 07:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348369AbiETLIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:08:22 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F7367A830
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:08:21 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B5EB292009D; Fri, 20 May 2022 13:08:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B279192009B;
        Fri, 20 May 2022 12:08:20 +0100 (BST)
Date:   Fri, 20 May 2022 12:08:20 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PING][PATCH] RISC-V: PCI: Avoid handing out address 0 to devices
In-Reply-To: <alpine.DEB.2.21.2204271207590.9383@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2205200429300.52080@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2204271207590.9383@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022, Maciej W. Rozycki wrote:

> Therefore avoid handing out address 0, by bumping the lowest address 
> available to PCI via PCIBIOS_MIN_IO and PCIBIOS_MIN_MEM up by 4 and 16 
> respectively, which is the minimum allocation size for I/O and memory 
> BARs.

 Ping for:
<https://lore.kernel.org/lkml/alpine.DEB.2.21.2204271207590.9383@angie.orcam.me.uk/>

  Maciej
