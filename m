Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5935C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jun 2022 15:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbiFKPK2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jun 2022 11:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbiFKPK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 11:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0552611
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 08:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0416061011
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 15:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97C3C34116;
        Sat, 11 Jun 2022 15:10:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kttCWqMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654960222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qF416RNckkOUpRlpwH6/BPTNNSan6sPETx4V80w0A2c=;
        b=kttCWqMq4NWyq0k+UrViGCTrQpBQXIUTG+7tlS7oTxPOiebyfjDs6JuVV2JZade3OUE8aZ
        CwQoFQub0jXH1Vr0emNUG6e0U5Px9+iRZ+lhTRcLPw/WoDCcUvqy8UxVEkuUEvtoXE2b6I
        pWr7ROxHzpLwwzTOAChNvf9WxYM2Kxs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 121c7299 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 11 Jun 2022 15:10:22 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 0/3] powerpc: wire up rng during setup_arch
Date:   Sat, 11 Jun 2022 17:10:12 +0200
Message-Id: <20220611151015.548325-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform's RNG must be available before random_init() in order to be
useful for initial seeding, which in turn means that it needs to be
called from setup_arch(), rather than from an init call. This series
wires that up properly on the three platforms that currently initialize
the RNG from the wrong place.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>

Jason A. Donenfeld (3):
  powerpc/microwatt: wire up rng during setup_arch
  powerpc/powernv: wire up rng during setup_arch
  powerpc/pseries: wire up rng during setup_arch

 arch/powerpc/platforms/microwatt/microwatt.h |  7 +++++++
 arch/powerpc/platforms/microwatt/rng.c       | 10 +++-------
 arch/powerpc/platforms/microwatt/setup.c     |  8 ++++++++
 arch/powerpc/platforms/powernv/powernv.h     |  2 ++
 arch/powerpc/platforms/powernv/rng.c         | 18 +++++-------------
 arch/powerpc/platforms/powernv/setup.c       |  2 ++
 arch/powerpc/platforms/pseries/pseries.h     |  2 ++
 arch/powerpc/platforms/pseries/rng.c         | 11 +++--------
 arch/powerpc/platforms/pseries/setup.c       |  1 +
 9 files changed, 33 insertions(+), 28 deletions(-)
 create mode 100644 arch/powerpc/platforms/microwatt/microwatt.h

-- 
2.35.1

