Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2EAC32792
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 09:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351152AbiHWJgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 05:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351129AbiHWJfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:35:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290A695E7F;
        Tue, 23 Aug 2022 01:39:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 889106132D;
        Tue, 23 Aug 2022 08:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788F4C433D6;
        Tue, 23 Aug 2022 08:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661243915;
        bh=b09QnvDg7xfHPslMRVg7vHUSCPbJTeYQlqKvtTja7U4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xByAZDETCrENvkjbaP4OnqiZ4zUWxKq99jrHto5unDhGUvAv9jYC1vx8/U4NoWemc
         LWoAJbAiqFW9lCzCZ/Rqv/IWt/vfR4/oYvDm6uAWOpxyXSbBYFalHRbiQEfMPzrGvH
         tTNkrAzLLScRcFGDzIHr0xToJ4BxaKN7I6utPcbw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 035/229] powerpc/powernv: Avoid crashing if rng is NULL
Date:   Tue, 23 Aug 2022 10:23:16 +0200
Message-Id: <20220823080054.807322627@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080053.202747790@linuxfoundation.org>
References: <20220823080053.202747790@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

commit 90b5d4fe0b3ba7f589c6723c6bfb559d9e83956a upstream.

On a bare-metal Power8 system that doesn't have an "ibm,power-rng", a
malicious QEMU and guest that ignore the absence of the
KVM_CAP_PPC_HWRNG flag, and calls H_RANDOM anyway, will dereference a
NULL pointer.

In practice all Power8 machines have an "ibm,power-rng", but let's not
rely on that, add a NULL check and early return in
powernv_get_random_real_mode().

Fixes: e928e9cb3601 ("KVM: PPC: Book3S HV: Add fast real-mode H_RANDOM implementation.")
Cc: stable@vger.kernel.org # v4.1+
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20220727143219.2684192-1-mpe@ellerman.id.au
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/powernv/rng.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/platforms/powernv/rng.c
+++ b/arch/powerpc/platforms/powernv/rng.c
@@ -63,6 +63,8 @@ int powernv_get_random_real_mode(unsigne
 	struct powernv_rng *rng;
 
 	rng = raw_cpu_read(powernv_rng);
+	if (!rng)
+		return 0;
 
 	*v = rng_whiten(rng, __raw_rm_readq(rng->regs_real));
 


