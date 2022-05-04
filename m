Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B152FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 08:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346057AbiEDILw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 04:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346022AbiEDILr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:11:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B4822500;
        Wed,  4 May 2022 01:08:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5EFBB82299;
        Wed,  4 May 2022 08:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE971C385A4;
        Wed,  4 May 2022 08:08:07 +0000 (UTC)
Date:   Wed, 4 May 2022 09:08:03 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoffer Dall <cdall@cs.columbia.edu>,
        Will Deacon <will@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Oliver Upton <oupton@google.com>
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <YnI0Y/rF9gdVi5bV@arm.com>
References: <20220504143529.4060ab27@canb.auug.org.au>
 <877d71ixpc.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d71ixpc.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 08:06:07AM +0100, Marc Zyngier wrote:
> On Wed, 04 May 2022 05:35:29 +0100,
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > [1  <text/plain; US-ASCII (quoted-printable)>]
> > Hi all,
> > 
> > Today's linux-next merge of the kvm-arm tree got a conflict in:
> > 
> >   arch/arm64/kvm/sys_regs.c
> > 
> > between commit:
> > 
> >   0b12620fddb8 ("KVM: arm64: Treat ESR_EL2 as a 64-bit register")
> > 
> > from the arm64 tree and commits:
> > 
> >   e65197666773 ("KVM: arm64: Wire up CP15 feature registers to their AArch64 equivalents")
> >   9369bc5c5e35 ("KVM: arm64: Plumb cp10 ID traps through the AArch64 sysreg handler")
> > 
> > from the kvm-arm tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> 
> Thanks Stephen.
> 
> I've added a fix to address the 'u32 esr' instances that were
> introduced by Oliver's series. Catalin, do you want me to merge the
> ESR series in the kvm-arm tree in order to avoid the minor conflict?

You could merge the arm64 for-next/esr-elx-64-bit branch, it already has
a couple of KVM patches.

-- 
Catalin
