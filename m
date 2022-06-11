Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9041AC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jun 2022 10:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiFKKGz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jun 2022 06:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiFKKGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 06:06:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0606314;
        Sat, 11 Jun 2022 03:06:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C2DDB80E9A;
        Sat, 11 Jun 2022 10:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92371C34116;
        Sat, 11 Jun 2022 10:06:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ooU+ZbNO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654942005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h4E1fp//jnKJu1hS8h2f00voZVd1N0DhSu9cKd6ZpkI=;
        b=ooU+ZbNOgZ4rEbYCnT19oQfd7LPlPhtL0SkJKZSfq3tJhrDwlUrxMCfd/1lO8UnD9OWDLR
        PdrcDd08bQFLggxVci5SHzXJV1xGkWlWaThImu+6KP/ot5SzMYaCOu5wIBUl+lH5+sEmRr
        uHmUhe9dh0iRi2zRTgInQ6KuLFkbuUA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e48741c0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 11 Jun 2022 10:06:45 +0000 (UTC)
Date:   Sat, 11 Jun 2022 12:06:44 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] powerpc/rng: wire up during setup_arch
Message-ID: <YqRpNAppvZszEOnT@zx2c4.com>
References: <20220611081114.449165-1-Jason@zx2c4.com>
 <956d2faa-4dae-fc75-2c03-387c77806f2b@csgroup.eu>
 <f6e5a9c4-f39d-749f-d124-884f11a8edfb@csgroup.eu>
 <YqRe3wHSuM6dcsCU@zx2c4.com>
 <c0198572-5aa2-7d65-ade2-766d6733431d@csgroup.eu>
 <YqRnPzVxK9HKROYi@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqRnPzVxK9HKROYi@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey again,

On Sat, Jun 11, 2022 at 11:58:23AM +0200, Jason A. Donenfeld wrote:
> Anyway, sure, I'll do that and send a v2 series.

This is now done here:
https://lore.kernel.org/lkml/20220611100447.5066-1-Jason@zx2c4.com/

Jason
