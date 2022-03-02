Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA58C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 12:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbiCBMtu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241945AbiCBMrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:47:40 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344E4C2E47
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:46:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7v565VFgz4xvW;
        Wed,  2 Mar 2022 23:46:50 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geoff Levand <geoff@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220214065543.198992-1-pmenzel@molgen.mpg.de>
References: <20220214065543.198992-1-pmenzel@molgen.mpg.de>
Subject: Re: [PATCH] powerpc/boot: Add `otheros-too-big.bld` to .gitignore
Message-Id: <164622487712.2052779.17970799380361079611.b4-ty@ellerman.id.au>
Date:   Wed, 02 Mar 2022 23:41:17 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 07:55:43 +0100, Paul Menzel wrote:
> Currently, `git status` lists the file as untracked by git, so tell git
> to ignore it.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/boot: Add `otheros-too-big.bld` to .gitignore
      https://git.kernel.org/powerpc/c/cb7356986db020c96f37532042fdae6706e81df7

cheers
