Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDD3C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 05:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiBOFaf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 00:30:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbiBOFa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:30:26 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FD112859C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:30:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV681Pdrz4xmx;
        Tue, 15 Feb 2022 16:30:08 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cc89d3c11fc9c742d0df3454a657a3a00be24046.1643538554.git.christophe.leroy@csgroup.eu>
References: <cc89d3c11fc9c742d0df3454a657a3a00be24046.1643538554.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Make pte_update() non atomic on 603 core
Message-Id: <164490280591.270256.978317263917716851.b4-ty@ellerman.id.au>
Date:   Tue, 15 Feb 2022 16:26:45 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2022 10:29:34 +0000, Christophe Leroy wrote:
> On 603 core, TLB miss handler don't do any change to the
> page tables so pte_update() doesn't need to be atomic.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/32s: Make pte_update() non atomic on 603 core
      https://git.kernel.org/powerpc/c/4291d085b0b07a78403e845c187428b038c901cd

cheers
