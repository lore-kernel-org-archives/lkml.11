Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59D6C19F2D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Aug 2022 22:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiHMWir (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Aug 2022 18:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiHMWip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 18:38:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A92E6CD11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 15:38:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M4wSG1t2qz4x2c;
        Sun, 14 Aug 2022 08:38:38 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <eca9251f1e1f82c4c46ec6380ddb28356ab3fdfe.1659527244.git.christophe.leroy@csgroup.eu>
References: <eca9251f1e1f82c4c46ec6380ddb28356ab3fdfe.1659527244.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/ppc-opcode: Fix PPC_RAW_TW()
Message-Id: <166043029294.1050412.7867126278150984193.b4-ty@ellerman.id.au>
Date:   Sun, 14 Aug 2022 08:38:12 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Aug 2022 13:47:33 +0200, Christophe Leroy wrote:
> PPC_RAW_TW() is erroneously defined with base code 0x7f000008
> instead of 0x7c000008.
> 
> That's invisible because its only user is PPC_RAW_TRAP() which is
> 0x7fe00008, but fix it anyway to avoid any risk of future bug.
> 
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/ppc-opcode: Fix PPC_RAW_TW()
      https://git.kernel.org/powerpc/c/59bab33a4f57f886c5f8a4d1f2bed728ec185d16

cheers
