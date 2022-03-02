Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE161C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 12:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241923AbiCBMrf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiCBMr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:47:27 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B03F7807D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:46:44 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7v4w64Ldz4xv3;
        Wed,  2 Mar 2022 23:46:40 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <d8b33342d7454f6ca4f368f5206896558dfa06f4.1645538722.git.christophe.leroy@csgroup.eu>
References: <d8b33342d7454f6ca4f368f5206896558dfa06f4.1645538722.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Remove remaining stab codes
Message-Id: <164622488336.2052779.8567395814244091287.b4-ty@ellerman.id.au>
Date:   Wed, 02 Mar 2022 23:41:23 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 15:05:30 +0100, Christophe Leroy wrote:
> Following commit 12318163737c ("powerpc/32: Remove remaining .stabs
> annotations"), stabs code are not used anymore.
> 
> Remove them.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: Remove remaining stab codes
      https://git.kernel.org/powerpc/c/406a8c1d8fa59ae6a6462a6fb6ff892f6a4f7499

cheers
